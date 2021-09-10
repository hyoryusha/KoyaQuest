//
//  AppData.swift
//  KoyaQuest2021
//
//  Created by Kevin K Collins on 2021/02/03.
//

import Combine
import SwiftUI

enum ChallengeState {
    case idle, active, paused
}

enum GameState {
    case initial, login, idle, active, complete, exited
}
enum Level: String, CaseIterable, Identifiable {
    var id : String { UUID().uuidString }
    case
            myoo = "Wisdom King",
            master = "Master",
            adept = "Adept",
            journeyman = "Journeyman",
            novice = "Novice"
}

final class AppData: ObservableObject {
    // @Published var gameState: GameState = .complete
    // @Published var gameStarted: Bool = false
    @Published var isPlayingGame: Bool = true // true is the default
    @Published var challengeState: ChallengeState = .idle
    @Published var completedChallengeSummary: [CompletedChallenge] = loadCompletedSummary()
    @Published var completedBonusSummary: [CompletedBonus] = loadCompletedBonusSummary()
    @Published var completedChallenges: [Challenge] = []
    @Published var completedBonuses: [Bonus] = []
    @Published var allLocalRatings: [LocalRating] = []
    @Published var localRatings: [LocalRating] = loadLocalRatings()
    @Published var kukaiChallengeState: ChallengeState = .idle
    @Published var isShowingResumeKukaiChallenge: Bool = false
    @Published var userName: String {
        didSet {
            UserDefaults.standard.set(userName, forKey: "userName")
        }
    }

    init() {
        self.userName = UserDefaults.standard.object(forKey: "userName") as? String ?? ""
    }

    var scorePosted: Bool = checkScorePosted() {
        willSet {
            objectWillChange.send()
        }
    }

    var gameState: GameState = .initial { // pre-set to .initial
        willSet {
            objectWillChange.send()
        }
    }

    var level: Level {
        switch self.totalScore {
        case 0...99:
            return .novice
        case 100...179:
            return .journeyman
        case 180...249:
        return .adept
        case 249...299:
            return .master
        case 300...:
            return .myoo
        default:
            return .novice
        }
    }
    var handicap: Int = 0 // a starting score?

    var totalScore: Int {
        completedChallengeSummary.reduce(handicap) {$0 + $1.points} + completedBonusSummary.reduce(0) {$0 + $1.points}
    }

    var challengeScore: Int {
        completedChallengeSummary.reduce(0) {$0 + $1.points}
    }

    var bonusScore: Int {
        completedBonusSummary.reduce(0) {$0 + $1.points}
    }

    var progressString: String {
        "Completed \(self.completedChallengeSummary.count) out of \(allChallenges.count) Challenges."
    }

    var bonusProgressString: String {
        "Completed \(self.completedBonusSummary.count) out of \(Bonus.bonusQuestions.count) Bonus Questions."
    }

    var isShowingBonus = false {
        willSet {
            objectWillChange.send()
        }
    }

    var activeBonus: Bonus = Bonus.mockBonus {
        willSet {
            objectWillChange.send()
        }
    }

    var isShowingChallenge = true {
        willSet {
            objectWillChange.send()
        }
    }

    var challengeToDisplay: Challenge? {
        willSet {
            // print("Will set challengeToDisplay to \(String(describing: newValue?.name))")
            objectWillChange.send()
        }
    }

// MARK: - Static
    static let completedKey = "Completed Challenges"
    static let completedBonusKey = "Completed Bonuses"
    static let ratingsKey = "Local Ratings"
    static let mockData: [CompletedChallenge] = [ ]
    static let rating1 = LocalRating(landmark: "Nyonindo", stars: 4)
    static let mockRatings: [LocalRating] = [rating1]
    static let mockBonus: [CompletedBonus] = []

// MARK: - GameOverCheck
    func checkForGameOver() {
        if completedBonusSummary.count == Bonus.bonusQuestions.count &&
            completedChallengeSummary.count == allChallenges.count {
            self.gameState = .complete
        } 
    }

// MARK: - ChangeGameState
    func changeGameState(newState: GameState) {
        self.gameState = newState
    }

// MARK: - Handle Completed Challenge

    func recordCompletedChallenge(challenge: Challenge, points: Int) {
        let newItem = CompletedChallenge(challenge: challenge.name, points: points)
        self.addCompletedChallenge(newItem)
        challenge.completed = true
        completedChallenges.append(challenge)
        // add a little delay ?
        checkForGameOver()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.checkForBonus(challenge: challenge)
        }
    }

    func addCompletedChallenge(_ completedItem: CompletedChallenge) {
        completedChallengeSummary.append(completedItem)
        persistCompletedChallenge()
    }
    private func persistCompletedChallenge() {
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(completedChallengeSummary) {
                UserDefaults.standard.set(encoded, forKey: AppData.completedKey)
            }
        }

    func checkForBonus(challenge: Challenge) {
        if challenge.bonus == true {
            guard let bonus = challenge.bonusQuestion else {
                return
            }
            checkBonusComplete(bonus: bonus)
        }
    }

    func checkBonusComplete(bonus: Bonus) {
        if !completedBonusSummary.contains(where: {$0.id == bonus.id }) {
            self.isShowingBonus = true
            self.activeBonus = bonus
        }
    }

// MARK: - Handle Completed Bonus

    func recordCompletedBonus(bonus: Bonus, points: Int) {
        let newItem = CompletedBonus(id: bonus.id, points: points)
        self.addCompletedBonus(newItem)
        completedBonuses.append(bonus)
    }
    func addCompletedBonus(_ completedItem: CompletedBonus) {
        completedBonusSummary.append(completedItem)
        self.isShowingBonus = false
        persistCompletedBonus()
        checkForGameOver()
    }

    private func persistCompletedBonus() {
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(completedBonusSummary) {
                UserDefaults.standard.set(encoded, forKey: AppData.completedBonusKey)
            }
        }

// MARK: - Handle Local Ratings
    func addLocalRatings(_ rating: LocalRating) {
        localRatings.append(rating)
        persistRating()
    }

    func recordLocalRating(landmark: String, stars: Int ) {
        let newItem = LocalRating(landmark: landmark, stars: stars)
        self.addLocalRatings(newItem)
        allLocalRatings.append(newItem)
    }

    private func persistRating() {
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(localRatings) {
                UserDefaults.standard.set(encoded, forKey: AppData.ratingsKey)
            }
        }

// MARK: - LOAD USER DEFAULTS

    static func loadLocalRatings() -> [LocalRating] {
        let savedRatings = UserDefaults.standard.object(forKey: AppData.ratingsKey )
        if let savedRatings = savedRatings as? Data {
        let decoder = JSONDecoder()
        return (try? decoder.decode([LocalRating].self, from: savedRatings))
            ?? AppData.mockRatings
        }
        return AppData.mockRatings
        }

    static func loadCompletedSummary() -> [CompletedChallenge] {
            let savedCompleted = UserDefaults.standard.object(forKey: AppData.completedKey )
            if let savedCompleted = savedCompleted as? Data {
            let decoder = JSONDecoder()
            return (try? decoder.decode([CompletedChallenge].self, from: savedCompleted))
                ?? AppData.mockData
            }
            return AppData.mockData
            }

    static func loadCompletedBonusSummary() -> [CompletedBonus] {
        let savedCompleted = UserDefaults.standard.object(forKey: AppData.completedBonusKey )
        if let savedCompleted = savedCompleted as? Data {
        let decoder = JSONDecoder()
        return (try? decoder.decode([CompletedBonus].self, from: savedCompleted))
            ?? AppData.mockBonus
        }
        return AppData.mockBonus
        }

    static func checkScorePosted() -> Bool {
        let userDefaults = UserDefaults.standard
        if userDefaults.valueIsTrue(forKey: "postedScore") {
            return true
        } else {
            return false
        }
    }

// MARK: - Challenge Display funcs
        func showChallenge() {
                self.isShowingChallenge = true
        }
}

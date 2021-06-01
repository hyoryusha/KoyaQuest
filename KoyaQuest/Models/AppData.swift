//
//  AppData.swift
//  KoyaQuest2021
//
//  Created by Kevin K Collins on 2021/02/03.
//

import Combine
import SwiftUI


enum ChallengeState {
    case idle , active
}

final class AppData: ObservableObject {
    @Published var gameStarted: Bool = false
    @Published var isPlayingGame: Bool = true // true is the default
    @Published var challengeState: ChallengeState = .idle
    @Published var localRatings: [LocalRating] = loadLocalRatings()
    @Published var completedChallengeSummary: [CompletedChallenge] = loadCompletedSummary()
    @Published var completedChallenges: [Challenge] = []
    @Published var allLocalRatings: [LocalRating] = []
    
//MARK: -- ChallengeDisplay properties
    var isShowingChallenge = false {
        willSet {
            objectWillChange.send()
        }
    }
    var challengeToDisplay : Challenge? {
        willSet {
            print("Will set challengeToDisplay to \(String(describing: newValue?.name))")
            objectWillChange.send()
        }
    }
    
    
    
    

    var totalScore: Int {
        completedChallengeSummary.reduce(0) {$0 + $1.points}
    }
    
    func addCompletedChallenge(_ completedItem: CompletedChallenge) {
        completedChallengeSummary.append(completedItem)
        persistCompletedChallenge()
    }
   
    func addLocalRatings(_ rating: LocalRating) {
        localRatings.append(rating)
        //print("From appData: recording new rating for \(rating.landmark) with \(rating.stars) stars.")
        persistRating()
    }
    
    func recordCompletedChallenge(challenge: Challenge, points: Int) {
        let newItem = CompletedChallenge(challenge: challenge.name, points: points)
        self.addCompletedChallenge(newItem)
        challenge.completed = true
        //print("From appData: recording completed challenge for \(challenge.name) with \(points) points.")
        completedChallenges.append(challenge)
    }
    
    func recordLocalRating(landmark: String, stars: Int ) {
        let newItem = LocalRating(landmark: landmark, stars: stars)
        self.addLocalRatings(newItem)
        allLocalRatings.append(newItem)
    }
    
    
    
    
// MARK: - LOAD USER DEFAULTS
    
    static let completedKey = "Completed Challenges"
    static let ratingsKey = "Local Ratings"
    static let mockData: [CompletedChallenge] = [ ]
    static let rating1 = LocalRating(landmark: "Nyonindo", stars: 4)
    static let mockRatings: [LocalRating] = [rating1 ] //OR: CompletedChallenge(challenge: "Mock Challenge", points: 0)
    
    
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
    
    private func persistCompletedChallenge() {
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(completedChallengeSummary) {
                UserDefaults.standard.set(encoded, forKey: AppData.completedKey)
            }
        }
    
    private func persistRating() {
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(localRatings) {
                UserDefaults.standard.set(encoded, forKey: AppData.ratingsKey)
            }
        }
    //MARK: Challenge Display funcs
        func showChallenge() {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2){
                self.isShowingChallenge = true
            }
            
        }
        
        func hideChallenge() {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2){
                self.isShowingChallenge = false
            }
        }
        
        func loadChallenge(for area: Area) {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2){
            if let challenge = area.challenge{
                self.challengeToDisplay = challenge
                print("Challenge to Display should be set to \(challenge.name)")
                }
            }
        }
}
// MARK: - Completed Challenge Class
final class CompletedChallenge : Identifiable, Codable, Equatable {
    
    static func == (lhs: CompletedChallenge, rhs: CompletedChallenge) -> Bool {
        return lhs.challenge == rhs.challenge && lhs.points == rhs.points
    }
    
    var id = UUID()
    var challenge: String
    var points: Int
    
    init(challenge: String, points: Int) {
        self.challenge = challenge
        self.points = points
    }
}

final class LocalRating: Identifiable, Codable, Equatable {
    
    static func == (lhs: LocalRating, rhs: LocalRating) -> Bool {
        return lhs.landmark == rhs.landmark && lhs.stars == rhs.stars
    }
    
    var id = UUID()
    var landmark: String
    var stars: Int
    
    init(landmark: String, stars: Int) {
        self.landmark = landmark
        self.stars = stars
    }
}//





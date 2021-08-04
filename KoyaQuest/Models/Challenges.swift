//
//  Challenges.swift
//  KoyaQuest2021
//
//  Created by Kevin K Collins on 2021/02/03.
//

import Foundation

class Challenge: Identifiable, Hashable {
    var id: Int
    var name: String
    var maxPoints: Int
    var details: ChallengeDetail
    var completed: Bool
    var bonus: Bool
    var bonusQuestion: Bonus?
    required init(id: Int, name: String, maxPoints: Int,
                  details: ChallengeDetail,
                  completed: Bool, bonus: Bool, bonusQuestion: Bonus? = nil) {
        self.id = id
        self.name = name
        self.maxPoints = maxPoints
        self.details = details
        self.completed = completed
        self.bonus = bonus
        self.bonusQuestion = bonusQuestion
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    static let mockChallenge = Challenge(id: 0, name: "Mock Challenge",
              maxPoints: 50,
              details: ChallengeDetail(id: 0, header: "Fake Header",
                                       teaser: "Placeholder",
                                       synopsis: "synopsis",
                                       instructions: "Lorem Ipsum",
                                       extra: "More text",
                                       imageName: "daimon"),
              completed: false,
              bonus: false)
}

extension Challenge: Equatable {
    static func == (lhs: Challenge, rhs: Challenge) -> Bool {
        return
            lhs.name == rhs.name &&
            lhs.maxPoints == rhs.maxPoints
    }
}

let koyakunChallenge = Challenge(id: 1, name: ChallengeNames.koyakun,
                                 maxPoints: 100,
                                 details: ChallengeDetail.koyakunChallengeDetails ?? ChallengeDetail.example,
                                 completed: false,
                                 bonus: false)

let shogunsChallenge = Challenge(id: 12, name: ChallengeNames.shoguns,
                                 maxPoints: 20,
                                 details: ChallengeDetail.shogunChallengeDetails ?? ChallengeDetail.example,
                                 completed: false,
                                 bonus: true,
                                 bonusQuestion: Bonus.shogunBonus)

let numbersChallenge = Challenge(id: 11, name: ChallengeNames.numbers,
                                 maxPoints: 20,
                                 details: ChallengeDetail.numbersChallengeDetails ?? ChallengeDetail.example,
                                 completed: false,
                                 bonus: true,
                                 bonusQuestion: Bonus.numbersBonus)

let daimonChallenge = Challenge(id: 2, name: ChallengeNames.daimon,
                                maxPoints: 20,
                                details: ChallengeDetail.daimonChallengeDetails ?? ChallengeDetail.example,
                                completed: false,
                                bonus: true,
                                bonusQuestion: Bonus.daimonBonus)

let choishiChallenge = Challenge(id: 3, name: ChallengeNames.choishi,
                                 maxPoints: 20,
                                 details: ChallengeDetail.choishiChallengeDetails ?? ChallengeDetail.example,
                                 completed: false,
                                 bonus: true,
                                 bonusQuestion: Bonus.choishiBonus)

let vajraChallenge = Challenge(id: 4, name: ChallengeNames.vajra,
                               maxPoints: 30,
                               details: ChallengeDetail.vajraChallengeDetails ?? ChallengeDetail.example,
                               completed: false,
                               bonus: false)

let saigyoChallenge = Challenge(id: 5, name: ChallengeNames.saigyo,
                                maxPoints: 30,
                                details: ChallengeDetail.saigyoChallengeDetails ?? ChallengeDetail.example,
                                completed: false,
                                bonus: false)

let kukaiChallenge = Challenge(id: 9, name: ChallengeNames.kukai,
                               maxPoints: 20,
                               details: ChallengeDetail.kukaiChallengeDetails ?? ChallengeDetail.example,
                               completed: false,
                               bonus: true,
                               bonusQuestion: Bonus.kukaiBonus)

let gorintoChallenge = Challenge(id: 6, name: ChallengeNames.gorinto,
                                 maxPoints: 30,
                                 details: ChallengeDetail.gorintoChallengeDetails ?? ChallengeDetail.example,
                                 completed: false,
                                 bonus: false)

let mizumukeChallenge = Challenge(id: 8, name: ChallengeNames.mizumuke,
                                  maxPoints: 25,
                                  details: ChallengeDetail.mizumukeChallengeDetails ?? ChallengeDetail.example,
                                  completed: false,
                                  bonus: true,
                                  bonusQuestion: Bonus.mizumukeBonus)

let kenshinChallenge = Challenge(id: 7, name: ChallengeNames.kenshin,
                                 maxPoints: 35,
                                 details: ChallengeDetail.kenshinChallengeDetails ?? ChallengeDetail.example,
                                 completed: false,
                                 bonus: false)

let nyonindoChallenge = Challenge(id: 10, name: ChallengeNames.nyonindo,
                                  maxPoints: 100,
                                  details: ChallengeDetail.nyonindoChallengeDetails ?? ChallengeDetail.example,
                                  completed: false,
                                  bonus: false)

let allChallenges: [Challenge] = [koyakunChallenge,
                daimonChallenge,
                kukaiChallenge,
                vajraChallenge,
                saigyoChallenge,
                choishiChallenge,
                gorintoChallenge,
                mizumukeChallenge,
                kenshinChallenge,
                nyonindoChallenge,
                numbersChallenge,
                shogunsChallenge
]

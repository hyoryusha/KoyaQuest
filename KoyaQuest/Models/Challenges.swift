//
//  Challenges.swift
//  KoyaQuest2021
//
//  Created by Kevin K Collins on 2021/02/03.
//

import Foundation


class Challenge : Identifiable , Hashable {
    var id = UUID() //added 12-28-2020
    var name: String
    var maxPoints: Int
    var instructions: ChallengeDescription
    var completed: Bool
    required init(name: String, maxPoints: Int,   instructions: ChallengeDescription, completed: Bool) {
        self.name = name
        self.maxPoints = maxPoints
        self.instructions = instructions
        self.completed = completed
    }
    
//   func markCompleted(challenge: Challenge, points: Int) {
//        let completed = Completed(challenge: challenge, points: points)
//        completedChallenges.append(completed)
//    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    //for testing, etc:
    static let mockChallenge = Challenge(name: "Mock Challenge", maxPoints: 50, instructions: ChallengeDescription(header: "Fake Header", teaser: "Placeholder", synopsis: "synopsis", instructions: "Lorem Ipsum", extra: "More text", image: "daimon") , completed: false)
}


extension Challenge: Equatable {
    static func == (lhs: Challenge, rhs: Challenge) -> Bool {
        return
            lhs.name == rhs.name &&
            lhs.maxPoints == rhs.maxPoints
    }
}

let shogunsChallenge = Challenge(name: ChallengeNames.shoguns, maxPoints: 20, instructions: shogunsChallengeDescription, completed: false)
let numbersChallenge = Challenge(name: ChallengeNames.numbers, maxPoints: 20, instructions: numbersChallengeDescription, completed: false)
let koyakunChallenge = Challenge(name: ChallengeNames.koyakun, maxPoints: 72, instructions: koyakunChallengeDescription, completed: false)
let daimonChallenge = Challenge(name: ChallengeNames.daimon, maxPoints: 20,  instructions: daimonChallengeDescription , completed: false)
let choishiChallenge = Challenge(name: ChallengeNames.choishi, maxPoints: 20,  instructions: choishiChallengeDescription , completed: false)
let vajraChallenge = Challenge(name: ChallengeNames.vajra, maxPoints: 30,  instructions: vajraChallengeDescription , completed: false)
let saigyoChallenge = Challenge(name: ChallengeNames.saigyo, maxPoints: 20 ,  instructions: saigyoChallengeDescription , completed: false)
let kukaiChallenge = Challenge(name: ChallengeNames.kukai, maxPoints: 10,  instructions: kukaiChallengeDescription , completed: false)
let gorintoChallenge = Challenge(name: ChallengeNames.gorinto, maxPoints: 30,  instructions: gorintoChallengeDescription , completed: false)
let mizumukeChallenge = Challenge(name: ChallengeNames.mizumuke, maxPoints: 20,  instructions: mizumukeChallengeDescription , completed: false)
let kenshinChallenge = Challenge(name: ChallengeNames.kenshin, maxPoints: 35,  instructions: kenshinChallengeDescription , completed: false)
let nyonindoChallenge = Challenge(name: ChallengeNames.nyonindo, maxPoints: 40,  instructions: nyonindoChallengeDescription , completed: false)
let sugatamiChallenge = Challenge(name: ChallengeNames.sugatami, maxPoints: 20,  instructions: sugatamiChallengeDescription , completed: false)

let allChallenges:[Challenge] = [koyakunChallenge, daimonChallenge , choishiChallenge , kukaiChallenge ,vajraChallenge , saigyoChallenge , gorintoChallenge , mizumukeChallenge, kenshinChallenge , nyonindoChallenge , numbersChallenge , shogunsChallenge]

//see ChallengeInstructions for instructions for each challenge


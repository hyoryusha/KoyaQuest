//
//  AppDataPropertiesTests.swift
//  KoyaQuestTests
//
//  Created by Kevin K Collins on 2021/09/03.
//

import XCTest
@testable import KoyaQuest

let completedChallenge1  = CompletedChallenge(challenge: daimonChallenge.name, points: daimonChallenge.maxPoints)
let completedChallenge2 = CompletedChallenge(challenge: vajraChallenge.name, points: vajraChallenge.maxPoints)
let completedChallenge3 = CompletedChallenge(challenge: koyakunChallenge.name, points: 56)
let completedChallenge4 = CompletedChallenge(challenge: kukaiChallenge.name, points: kukaiChallenge.maxPoints)
let completedBonus1 = CompletedBonus(id: Bonus.daimonBonus.id, points: 8)
let completedBonus2 = CompletedBonus(id: Bonus.kukaiBonus.id, points: 12)

class AppDataPropertiesTests: BaseTestCase {
    let completedKey = "Completed Challenges"
    let completedBonusKey = "Completed Bonuses"
    var appData = AppData()
    let completedChallengeSummary: [CompletedChallenge] = [completedChallenge1,
        completedChallenge2,
        completedChallenge3,
        completedChallenge4
    ]
    let completedBonusSummary: [CompletedBonus] = [completedBonus1, completedBonus2]

    func testChallengeScore() throws {
        appData.completedChallengeSummary = completedChallengeSummary
        XCTAssertEqual(appData.challengeScore, 126, "Total score for four challenges should be 126")
    }

    func testBonusScore() throws {
        appData.completedBonusSummary = completedBonusSummary
        XCTAssertEqual(appData.bonusScore, 20, "Total score for two bonuses should be 20")
    }

    func testTotalScore() {
        UserDefaults.standard.removeObject(forKey: completedKey)
        UserDefaults.standard.removeObject(forKey: completedBonusKey)
        appData.completedChallengeSummary = completedChallengeSummary
        appData.completedBonusSummary = completedBonusSummary
        XCTAssertEqual(appData.totalScore, 114 + 32,
                       "Total score for three challenges should be 106")
    }

    func testProgressString() throws {
        appData.completedChallengeSummary = completedChallengeSummary

        XCTAssertEqual(appData.progressString,
                       "Completed 4 out of 12 Challenges.",
                       "Progress string should say 4 out of 12.")
    }

    func testBonusProgressString() throws {
        appData.completedBonusSummary = completedBonusSummary

        XCTAssertEqual(appData.bonusProgressString,
                       "Completed 2 out of 6 Bonus Questions.",
                       "Progress string should say 2 out of 6.")
    }

    func testGamePlayDisabled () throws {

    }
}

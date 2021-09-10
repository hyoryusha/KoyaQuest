//
//  ChallengeCompletionTests.swift
//  KoyaQuestTests
//
//  Created by Kevin K Collins on 2021/09/01.
//

import CoreData
import XCTest
@testable import KoyaQuest

class ChallengeCompletionTests: BaseTestCase {
    var appData = AppData()
    let challenge = daimonChallenge
    let points = daimonChallenge.maxPoints
    let bonus = Bonus.daimonBonus
    let bonusPoints = 0
    let completedKey = "Completed Challenges"
    let completedBonusKey = "Completed Bonuses"

    func testRecordCompletedChallenge() {
        let newItem = CompletedChallenge(challenge: challenge.name, points: points)
        appData.addCompletedChallenge(newItem)
        challenge.completed = true
        appData.completedChallenges.append(challenge)

        XCTAssertEqual(appData.completedChallenges[0].completed, true)
    }

    func testAddCompletedChallenge() { //this uses UserDefaults
        UserDefaults.standard.removeObject(forKey: completedKey)
        let completedChallenge = CompletedChallenge(challenge: challenge.name, points: points)

        appData.addCompletedChallenge(completedChallenge)

        XCTAssertEqual(appData.completedChallengeSummary[0].points, daimonChallenge.maxPoints, "Failed to add completed challenge to array of completed challenges.")

        let completedChallengesFromUserData: [CompletedChallenge] = AppData.loadCompletedSummary()

        XCTAssertNotNil(completedChallengesFromUserData)

    }

    func testCheckForBonus() { //this relies on UserData
        UserDefaults.standard.removeObject(forKey: completedKey)
        UserDefaults.standard.removeObject(forKey: completedBonusKey)
        appData.checkForBonus(challenge: challenge)
        XCTAssertTrue(appData.isShowingBonus)
    }

    func testRecordCompletedBonus() {
        appData.recordCompletedBonus(bonus: bonus, points: bonusPoints)
        XCTAssertEqual(appData.completedBonuses[0].id, bonus.id)
    }

    func testAddCompletedBonus() { //this uses UserDefaults
        UserDefaults.standard.removeObject(forKey: completedKey)
        UserDefaults.standard.removeObject(forKey: completedBonusKey)
        let completedBonus = CompletedBonus(id: bonus.id, points: bonusPoints)
        appData.addCompletedBonus(completedBonus)
        //check if isShowingBonus is set to false:
        XCTAssertFalse(appData.isShowingBonus)
        //check game over status:
        XCTAssertFalse(appData.gameState == .complete)

        //check if new item was persisted to UserDefaults:
        // NOT SURE HOW TO DO THIS YET
        let completedBonuses = AppData.loadCompletedBonusSummary()
        XCTAssertEqual(completedBonuses.count, 1)

    }

    func testCheckForGameOver() {
        appData.checkForGameOver()
        XCTAssertNotEqual(appData.gameState, .complete)
    }
    func testChangeGameState() {
        appData.changeGameState(newState: .login)
        XCTAssertEqual(appData.gameState, .login)
    }

}
// NOTE: I need to be careful with tests that use UserDefaults as these DO get saved in the UserDefaults of the simulator! One solution is to delete the app from the simulator in question...
// another solution is to test around the UserDefaults (i.e. avoid any functions that use them...

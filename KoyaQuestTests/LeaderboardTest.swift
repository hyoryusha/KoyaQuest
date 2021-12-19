//
//  LeaderboardTest.swift
//  KoyaQuestTests
//
//  Created by Kevin K Collins on 2021/09/30.
//

import CoreData
import XCTest
@testable import KoyaQuest

class LeaderboardTest: BaseTestCase {
    var viewModel = PostScoreViewModel()
    let invalidUsername = "homer simpson"
    let validUsername = "lisa simpson"

    func testPostScoreToLeaderbpard() throws {
        let newRecord = FinalScoreRecord(
            userName: "Homer Simpson",
            date: Date(),
            score: 312)

        FinalScore.createWith(userIdentifier: UUID().uuidString,
            userName: newRecord.userName,
            score: newRecord.score,
            submitDate: newRecord.date,
            using: managedObjectContext)

        XCTAssertEqual(dataController.count(
            for: FinalScore.fetchRequest()), 1)
    }

    func testCheckUserNameAvailable() throws {
        let newRecord = FinalScoreRecord(
            userName: "bart simpson",
            date: Date(),
            score: 312)

        FinalScore.createWith(userIdentifier: UUID().uuidString,
            userName: newRecord.userName,
            score: newRecord.score,
            submitDate: newRecord.date,
            using: managedObjectContext)

        let secondRecord = FinalScoreRecord(
            userName: "Homer Simpson",
            date: Date(),
            score: 200)

        FinalScore.createWith(userIdentifier: UUID().uuidString,
            userName: secondRecord.userName,
            score: secondRecord.score,
            submitDate: secondRecord.date,
            using: managedObjectContext)

        let fetchRequest: NSFetchRequest<FinalScore>
        fetchRequest = FinalScore.fetchRequest()

        let finalScores = try managedObjectContext.fetch(fetchRequest)

        var userNamesTestArray: [String] {
            finalScores.compactMap { $0.userName }
        }

        viewModel.checkUserNameAvailable(userNamesArray: userNamesTestArray, userNameToTest: validUsername)
        XCTAssertTrue(viewModel.userNameAvailable)
    }
}


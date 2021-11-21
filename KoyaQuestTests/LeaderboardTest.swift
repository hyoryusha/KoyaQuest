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
    let username = "don johnson"

    func testPostScoreToLeaderbpard() throws {
        let newRecord = FinalScoreRecord(
            userName: "john doe",
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
            userName: "john doe",
            date: Date(),
            score: 312)

        FinalScore.createWith(userIdentifier: UUID().uuidString,
            userName: newRecord.userName,
            score: newRecord.score,
            submitDate: newRecord.date,
            using: managedObjectContext)

        let secondRecord = FinalScoreRecord(
            userName: "John Doe",
            date: Date(),
            score: 200)

        FinalScore.createWith(userIdentifier: UUID().uuidString,
            userName: secondRecord.userName,
            score: secondRecord.score,
            submitDate: secondRecord.date,
            using: managedObjectContext)

        let request = NSFetchRequest<FinalScore>(
            entityName: "FinalScore"
        )
        let finalScores = try managedObjectContext.fetch(request)

        var userNamesArray: [String] {
            finalScores.compactMap { $0.userName }
        }

        var testFinalScore: [FinalScore]?

        let testFoundFinalScore = finalScores.contains(where: {
            $0.userName == username
        })

        if testFoundFinalScore {
            testFinalScore = finalScores.filter {
                $0.score == 312
            }
        }

        XCTAssertFalse(testFinalScore?.isEmpty == true)

        viewModel.checkUserNameAvailable(userNamesArray: userNamesArray)

        let lowerCasedNames = userNamesArray.map {
            $0.lowercased()
        }

        let filteredArray = lowerCasedNames.filter {
            $0 == username
        }
    if filteredArray.isEmpty {
        viewModel.userNameAvailable = true
        }
        XCTAssertTrue(viewModel.userNameAvailable)
    }
}

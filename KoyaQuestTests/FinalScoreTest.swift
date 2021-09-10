//
//  FinalScoreTest.swift
//  KoyaQuestTests
//
//  Created by Kevin K Collins on 2021/07/28.
//
import CoreData
import XCTest
@testable import KoyaQuest

class FinalScoreTest: BaseTestCase {
    

    func testCreateNewFinalScore() {
        FinalScore.createWith(
            userIdentifier: UUID().uuidString,
            userName: "TestName",
            score: 200,
            submitDate: Date(),
            using: managedObjectContext)

        XCTAssertEqual(dataController.count(for: FinalScore.fetchRequest()), 1)
    }

}

//
//  AssetTest.swift
//  KoyaQuestTests
//
//  Created by Kevin K Collins on 2021/07/28.
//

import XCTest
@testable import KoyaQuest

class AssetTest: XCTestCase {

    func testLoadsLandmarkJSONCorrectly() {
        XCTAssertFalse(Landmark.allLandmarks.isEmpty, "Failed to load landmarks from JSON")
    }
    func testLoadsInformationJSONCorrectly() {
        XCTAssertFalse(Information.allInfo.isEmpty, "Failed to load information from JSON")
    }

    func testLoadsFAQJSONCorrectly() {
        XCTAssertFalse(FAQ.allFAQ.isEmpty, "Failed to load information from JSON")
        }
}

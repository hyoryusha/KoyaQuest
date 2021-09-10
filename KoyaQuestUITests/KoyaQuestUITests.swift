//
//  KoyaQuestUITests.swift
//  KoyaQuestUITests
//
//  Created by Kevin K Collins on 2021/09/02.
//

import XCTest


class KoyaQuestUITests: XCTestCase {
    var app: XCUIApplication!

    override func setUpWithError() throws {
        app = XCUIApplication()
        app.launchArguments = ["enable-testing"]
        app.launch()
        continueAfterFailure = false
    }

    func testNavigationToListLandmarkListView() throws {
        let currentLandmarkCount = 41 // I need to hard code the number because a UITest cannot access the model!
        app.buttons["Get started"].tap()
        app.buttons["See List"].tap()
        XCTAssertEqual(app.tables.cells.count, currentLandmarkCount , "Number of cells in list should be same as number of lankmarks.")
    }

    func testNavigationToListLandmarkDetailView() throws {
        app.buttons["Get started"].tap()
        app.buttons["See List"].tap()
        app.buttons["Middle Gate"].tap()
        XCTAssertEqual(app.images.count, 1)
    }

    func testNavigationToLandmarkDetailFromScrollView()  throws {
        app.buttons["Get started"].tap()
        for landmark in app.scrollViews.buttons.allElementsBoundByIndex {
            landmark.tap()
            XCTAssertEqual(app.images.count, 1)
        }

    }

    func skip_testNavigationToMoreInfo() throws {
        app.buttons["More information"].tap()
    }

}

//"Middle Gate"

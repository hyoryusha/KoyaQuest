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

    func testExample() {

        //XCUIApplication().buttons["Close"].tap()

//        let app = XCUIApplication()
//        let moreInfoButton = app.buttons["More info"]
//        moreInfoButton.tap()
//
//        let closeButton = app.buttons["Close"]
//        closeButton.tap()
//        moreInfoButton.tap()
//        closeButton.tap()
//        app.buttons["Get started"].tap()
//        app.buttons["See List"].tap()
//
//        let pointsOfInterestNavigationBar = app.navigationBars["Points of Interest"]
//        pointsOfInterestNavigationBar.staticTexts["Points of Interest"].tap()
//        pointsOfInterestNavigationBar.buttons["Back"].tap()
//        app.switches["Play Game:, gamecontroller"].tap()


        let app = XCUIApplication()
        app.buttons["About"].tap()
        app.tables/*@START_MENU_TOKEN@*/.buttons["What is KoyaQuest?, Explore the features of this app..."]/*[[".cells[\"What is KoyaQuest?, Explore the features of this app...\"].buttons[\"What is KoyaQuest?, Explore the features of this app...\"]",".buttons[\"What is KoyaQuest?, Explore the features of this app...\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()



    }
    func testNavigationToAboutView() throws {
        let app = XCUIApplication()
        app.buttons["Get started"].tap()
        app.buttons["About"].tap()
        XCTAssertTrue(app.buttons["About"].exists)
        app.buttons["About"].tap()
        XCTAssertEqual(app.tables.cells.count, 3 , "Number of cells in list should be 3.")

//        let tablesQuery = app.tables
//        tablesQuery.cells["What is KoyaQuest?, Explore the features of this app..."].children(matching: .other).element(boundBy: 0).children(matching: .other).element.tap()
//        tablesQuery.cells["What is \"KoyaQuest\"?"].children(matching: .other).element(boundBy: 0).children(matching: .other).element.tap()
//
//
//        XCTAssertEqual(app.tables.cells.count, 3 , "Number of cells in list should be 3.")


    }


    func testNavigationToMoreInfo() throws {
        let app = XCUIApplication()
        let moreInfoButton = app.buttons["More info"]
        moreInfoButton.tap()
        let closeButton = app.buttons["Close"]
        XCTAssertTrue(closeButton.exists)
    }


    func testNavigationToListLandmarkListView() throws {
        let currentLandmarkCount = 41 // I need to hard code the number because a UITest cannot access the model!
        app.buttons["Get started"].tap()
        app.buttons["See List"].tap()
        XCTAssertEqual(app.tables.cells.count, currentLandmarkCount , "Number of cells in list should be same as number of landmarks.")
    }

    func skip_testNavigationToListLandmarkDetailView() throws {
        app.buttons["Get started"].tap()
        app.buttons["See List"].tap()
        app.buttons["Middle Gate"].tap()
        XCTAssertEqual(app.images.count, 4)
    }

    func skip_testNavigationToLandmarkDetailFromScrollView()  throws {
        app.buttons["Get started"].tap()
        for landmark in app.scrollViews.buttons.allElementsBoundByIndex {
            landmark.tap()
            XCTAssertEqual(app.images.count, 7)
        }

    }

    func skip_testNavigationToMoreInfo() throws {
        app.buttons["More information"].tap()
    }

}

//"Middle Gate"

/*
 app.alerts.element
 app.buttons.element
 app.collectionViews.element
 app.images.element
 app.maps.element
 app.navigationBars.element
 app.pickers.element
 app.progressIndicators.element
 app.scrollViews.element
 app.segmentedControls.element
 app.staticTexts.element
 app.switches.element
 app.tabBars.element
 app.tables.element
 app.textFields.element
 app.textViews.element
 app.webViews.element


 // the only button
 app.buttons.element

 // the button titled "Help"
 app.buttons["Help"]

 // all buttons inside a specific scroll view (direct subviews only)
 app.scrollViews["Main"].children(matching: .button)

 // all buttons anywhere inside a specific scroll view (subviews, sub-subviews, sub-sub-subviews, etc)
 app.scrollViews["Main"].descendants(matching: .button)

 // find the first and fourth buttons
 app.buttons.element(boundBy: 0)
 app.buttons.element(boundBy: 3)

 // find the first button
 app.buttons.firstMatch

 XCTAssertEqual(app.buttons.element.title, "Buy")
 XCTAssertEqual(app.staticTexts.element.label, "test")

 XCTAssertTrue(app.alerts["Warning"].exists)
 */

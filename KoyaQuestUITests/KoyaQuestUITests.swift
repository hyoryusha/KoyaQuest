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



    }
    func testNavigationToAboutView() throws {
        let app = XCUIApplication()
        app.buttons["Get started"].tap()
        XCUIApplication().buttons["About"].tap()
        XCTAssertEqual(app.tables.cells.count,
                       3, "Number of cells in list should be 3.")
    }

    func testNavigationWelcomeInfoView() throws {
       // let app = XCUIApplication()
        let moreInfoButton = app.buttons["More info"]
        moreInfoButton.tap()
        let targetButton = app.buttons["welcome view close button"]
        XCTAssertTrue(targetButton.exists)
    }

    func testNavigationToListLandmarkListView() throws {
        let currentLandmarkCount = 42 // I need to hard code the number because a UITest cannot access the model!
        app.buttons["Get started"].tap()
        app.buttons["See List"].tap()
        XCTAssertEqual(app.tables.cells.count,
                       currentLandmarkCount, "Number of cells in list should be same as number of landmarks.")
    }

    func testNavigationToListLandmarkDetailView() throws {
        app.buttons["Get started"].tap()
        app.buttons["See List"].tap()
        app.tables.cells["Middle Gate"].children(matching:
                                                        .other).element(boundBy:
                                                                            0).children(matching:
                                                                                                .other).element.tap()
        let targetButton = app.buttons["BACK"]
        let targetText = app.scrollViews.otherElements.staticTexts["Middle Gate"]
        XCTAssertTrue(targetButton.exists)
        XCTAssertTrue(targetText.exists)
    }

    func testNavigationToLandmarkDetailFromScrollView()  throws {
        app.buttons["Get started"].tap()
        let elementsQuery = app.scrollViews.otherElements
        elementsQuery.buttons["sanno-in"].swipeLeft()
        elementsQuery.buttons["saito"].swipeLeft()
        elementsQuery.buttons["junteido"].tap()
        app.buttons["Junteidō"].tap()
        let targetButton = app.buttons["BACK"]
        let targetText = app.scrollViews.otherElements.staticTexts["Junteidō"]
        XCTAssertTrue(targetButton.exists)
        XCTAssertTrue(targetText.exists)
    }

    func testNavigationToScoreSummary () throws {
        app.buttons["Get started"].tap()
        app.buttons["Score Summary"].tap()
        let targetText = app.staticTexts["Score Summary"]
        XCTAssertTrue(targetText.exists)
    }

    func testGamePlayDisabled() throws {
        app.buttons["Get started"].tap()
        let playGameGamecontrollerSwitch = app.switches["Play Game:, gamecontroller"]
        playGameGamecontrollerSwitch.tap()
        // swiftlint:disable:next line_length
        let targetText = app.staticTexts["Gameplay has been disabled.\n(Use toggle switch in top-right corner to resume.)"]
        XCTAssertTrue(targetText.exists)
    }

    func testNavigationToFAQVIew()  throws {
        let app = XCUIApplication()
        app.buttons["Get started"].tap()
        app.buttons["About"].tap()
        app.tables.cells["FAQ, Find out more about Mt. Kōya..."].children(matching: .other).element(boundBy: 0).children(matching: .other).element.tap()
        //app.navigationBars["FAQ"].staticTexts["FAQ"].tap()
        let targetText = app.staticTexts["FAQ"]
        XCTAssertTrue(targetText.exists)
    }

    func testNavigationToFAQItem() throws {

        let app = XCUIApplication()
        app.buttons["Get started"].tap()
        app.buttons["About"].tap()
        app.tables.cells["FAQ, Find out more about Mt. Kōya..."].children(matching: .other).element(boundBy: 0).children(matching: .other).element.tap()

        let elementsQuery = app.scrollViews.otherElements
        elementsQuery.buttons["What is Mt. Kōya?"].tap()
//        elementsQuery.staticTexts["A Monastic Center for Shingon Buddhism"].tap()
        let targetText = app.staticTexts["A Monastic Center for Shingon Buddhism"]
        XCTAssertTrue(targetText.exists)

    }
}
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

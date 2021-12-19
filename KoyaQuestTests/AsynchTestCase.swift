//
//  AsynchTestCase.swift
//  KoyaQuestTests
//
//  Created by Kevin K Collins on 2021/10/02.
//

import XCTest
@testable import KoyaQuest
import CoreAudio

class AsynchTestCase: XCTestCase {
    let timeout: TimeInterval = 5
    var expectation: XCTestExpectation!

    override func setUp() {
        expectation = expectation(
            description: "Server responds in reasonable time."
        )
    }

    func testNoServerResponse() {

        let url = URL(string: "blahblahblah")!
        URLSession.shared.dataTask(with: url) { data, response, error in
            defer { self.expectation.fulfill() }
            XCTAssertNil(data)
            XCTAssertNil(response)
            XCTAssertNotNil(error)
        }
        .resume()

        waitForExpectations(timeout: timeout)
    }

    func testReadingJsonInfoFile() {
        let url = URL(
            string: "https://www.koyaquest.com/backend/json/Information.json"
        )!

        URLSession.shared.dataTask(with: url) { data, response, error in
            defer { self.expectation.fulfill() }
            XCTAssertNil(error)
            do {
                let response = try XCTUnwrap( response as? HTTPURLResponse)
                XCTAssert(response.statusCode == 200) // 200 = success

                let data = try XCTUnwrap(data)
                XCTAssertNoThrow(
                    try JSONDecoder().decode([Information].self, from: data)
                )
            } catch {

            }
        }
        .resume()
        waitForExpectations(timeout: timeout)
    }

    func testReadingJsonLandmarkFile() {
        let url = URL(string: "https://www.koyaquest.com/backend/json/Landmarks.json")!

        URLSession.shared.dataTask(with: url) { data, response, error in
            defer { self.expectation.fulfill() }
            XCTAssertNil(error)
            do {
                let response = try XCTUnwrap( response as? HTTPURLResponse)
                XCTAssert(response.statusCode == 200) // 200 = success

                let data = try XCTUnwrap(data)
                XCTAssertNoThrow(
                    try JSONDecoder().decode([Landmark].self, from: data)
                )
            } catch {

            }
        }
        .resume()
        waitForExpectations(timeout: timeout)

    }

    func testReadingJsonFAQFile() {
        let url = URL(
            string: "https://www.koyaquest.com/backend/json/FAQ.json"
        )!

        URLSession.shared.dataTask(with: url) { data, response, error in
            defer { self.expectation.fulfill() }
            XCTAssertNil(error)

            do {
                let response = try XCTUnwrap( response as? HTTPURLResponse)
                XCTAssert(response.statusCode == 200) // 200 = success

                let data = try XCTUnwrap(data)
                XCTAssertNoThrow(
                    try JSONDecoder().decode([FAQ].self, from: data)
                )
            } catch {

            }
        }
        .resume()
        waitForExpectations(timeout: timeout)

    }

    func test404() {
        let url = URL(
            string: "https://www.koyaquest.com/backend/json/AFQ2.json"
        )! // note the WRONG URL here

        URLSession.shared.dataTask(with: url) { data, response, error in
            defer { self.expectation.fulfill() }
            XCTAssertNil(error)

            do {
                let response = try XCTUnwrap( response as? HTTPURLResponse)
                XCTAssertEqual(response.statusCode, 404) // 200 = success

                let data = try XCTUnwrap(data)

                XCTAssertThrowsError(
                    try JSONDecoder().decode([FAQ].self, from: data)
                ) { error in
                    guard case DecodingError.dataCorrupted = error else {
                        XCTFail("fail")
                        return
                    }
                }
            } catch { }
        }
        .resume()
        waitForExpectations(timeout: timeout)
    }
}

//
//  RatingsTest.swift
//  KoyaQuestTests
//
//  Created by Kevin K Collins on 2021/07/28.
//

import CoreData
import XCTest
@testable import KoyaQuest


class RatingsTest: BaseTestCase {

    func testCreateNewRating()  throws {
        let newRating: Int16 = 2
        let wrongRating: Int16 = 5
        let landmarkName: String = Landmark.allLandmarks[6].name
        Rating.createWith(
            landmark: landmarkName,
            rating: newRating,
            date: Date(),
            using: managedObjectContext)

        XCTAssertEqual(dataController.count(for: Rating.fetchRequest()), 1)

        let request = NSFetchRequest<Rating>(entityName: "Rating")
        let ratings = try managedObjectContext.fetch(request)

        var testRating: [Rating]?
        let testRatingFound = ratings.contains(where: {
            $0.landmark == landmarkName
        })
        if testRatingFound {
            testRating = ratings.filter {
                $0.ratingLandmark == landmarkName
            }
        }
        XCTAssertEqual(testRating?[0].rating, newRating)
        XCTAssertNotEqual(testRating?[0].rating, wrongRating)

    }

}

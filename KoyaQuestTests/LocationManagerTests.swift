//
//  LocationManagerTests.swift
//  KoyaQuestTests
//
//  Created by Kevin K Collins on 2021/11/19.
//

import CoreData
import XCTest
import CoreLocation
@testable import KoyaQuest
import MapKit

class LocationMangerTest: BaseTestCase {
    let locationManager = LocationManager()
    let locations: [CLLocation] = [MockLocationManager.chumonLocation]

    let chumonCoords: CLLocationCoordinate2D = CLLocationCoordinate2D(
        latitude: 34.2123538,
        longitude: 135.5792138)

    let regionInTargetZone: CLCircularRegion = CLCircularRegion(center: CLLocationCoordinate2D(
        latitude: 34.2123538,
        longitude: 135.5792138),
                         radius: 100,
                         identifier: "West Garan Area")

    let regionOutsideTargetZone: CLCircularRegion = CLCircularRegion(center: CLLocationCoordinate2D(
        latitude: 35.2123538,
        longitude: 130.5792138),
                         radius: 100,
                         identifier: "Outside Area")

    func testLocationManagerLocationServicesEnabled() throws {
        let test = locationManager.isLocationServicesEnabled()
        XCTAssertTrue(test)
    }

    func testConvertRegionToArea() throws {
        let activeZone = locationManager.convertRegionToArea(region: regionInTargetZone.identifier)

        XCTAssertEqual(activeZone.identifier, regionInTargetZone.identifier)
    }

    func testHandleActiveTargetArea() throws {
        locationManager.handleActiveArea(regionInTargetZone)
        XCTAssertTrue(locationManager.isInTargetZone)
        XCTAssertFalse(locationManager.isNearGobyo)
        XCTAssertEqual(locationManager.activeArea?.identifier, "West Garan Area")
    }


    func testHandleActiveNonTargetArea() throws {
        locationManager.handleActiveArea(regionOutsideTargetZone)
        XCTAssertFalse(locationManager.isInTargetZone)
        XCTAssertFalse(locationManager.isNearGobyo)
        XCTAssertNil(locationManager.activeTargetZone)
    }

}

//
//  MockLocationManager.swift
//  KoyaQuest
//
//  Created by Kevin K Collins on 2021/12/02.
//

import CoreLocation
@testable import KoyaQuest

class MockLocationManager: LocationManagerProtocol {


    let greaterLocation: CLLocation = CLLocation(
        latitude: 34.2109456915934,
        longitude: 135.59842651113263
    )

    static let chumonLocation: CLLocation = CLLocation(
        latitude: 34.2123538,
        longitude: 135.5792138
    )

    var activeArea: Area?
    var activeTargetZone: Area?
    var isNearGobyo: Bool = false
    var isInTargetZone: Bool = false
    var delegate: CLLocationManagerDelegate?
    var distanceFilter: CLLocationDistance = 10
    var pausesLocationUpdatesAutomatically = false
    var allowsBackgroundLocationUpdates = true

    func verifyGPSAuthorization() { }
    func startUpdatingLocation() { }
    func stopUpdatingLocation() { }

    func isLocationServicesEnabled() -> Bool {
            return true
        }

    func convertRegionToArea(region: String) -> Area {
        var activeZone: Area?
        for area in areas where area.identifier == region {
            activeZone = area
        }
        return activeZone ?? Area.greaterArea
    }

    func handleActiveArea(_ region: CLRegion) {
        activeArea = convertRegionToArea(region: region.identifier)
        if activeArea == torodoArea {
            isNearGobyo = true
        } else {
            isNearGobyo = false
        }

        if activeArea?.isTargetZone == true {

            isInTargetZone = true
            activeTargetZone = activeArea
        } else {
            isInTargetZone = false
            activeTargetZone = nil
        }

    }
}

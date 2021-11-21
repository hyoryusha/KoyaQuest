//
//  LocationManager.swift
//  KoyaQuest2021
//
//  Created by Kevin K Collins on 2021/02/03.
//

import CoreLocation
import Combine
import SwiftUI

final class LocationManager: NSObject, ObservableObject {
    private let locationManager = CLLocationManager()

    let objectWillChange = PassthroughSubject<Void, Never>()

    var currentLocation: CLLocation?
    @Published var inGreaterRange: Bool = true
    @Published var currentAddress = ""
    @Published var isInTargetZone = false {
        willSet {
            objectWillChange.send()
        }
    }
    @Published var activeArea: Area?
    @Published var activeTargetZone: Area? {
        willSet {
            objectWillChange.send()
        }
    }
    @Published var alertItem: AlertItem?
    @Published var scrollIndex = 1001 {
        willSet {
            objectWillChange.send()
        }
    }

    @Published var isNearGobyo = false {
        willSet {
            objectWillChange.send()
        }
    }

    @Published var showGobyoAlert = false {
        willSet {
            objectWillChange.send()
        }
    }

    var onEntry: Bool = true
    var location: CLLocation?
    lazy var geocoder = CLGeocoder()

    override init() {
        super.init()
        locationManager.delegate = self
    }

    func verifyGPSAuthorization() {
        if locationManager.authorizationStatus == .authorizedAlways
            || locationManager.authorizationStatus == .authorizedWhenInUse {
            startLocationServices()
        } else {
            locationManager.requestAlwaysAuthorization()
        }
    }

    func startLocationServices() {
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.activityType = .fitness
        locationManager.pausesLocationUpdatesAutomatically = true // do I want this?
        locationManager.distanceFilter = 10 // updating will only occur when the user moves 5 meters
        locationManager.allowsBackgroundLocationUpdates = true
        locationManager.showsBackgroundLocationIndicator = true
        locationManager.startUpdatingLocation()

        if CLLocationManager.isMonitoringAvailable(for: CLCircularRegion.self) {
            for target in areas {
                locationManager.startMonitoring(for: target.region)
                locationManager.requestState(for: target.region)
                target.region.notifyOnEntry = true
                target.region.notifyOnExit = true
            }
        } else {
            print("Location monitoring not available")
        }
    }

    func stopLocationUpdates() {
        locationManager.stopUpdatingLocation()
        print("stopping location updates")
    }

    func pauseRegionMonitoring() {
        for target in areas {
            locationManager.stopMonitoring(for: target.region)
        }
    }

    func resumeRegionMonitoring() {
        for target in areas {
            locationManager.startMonitoring(for: target.region)
            locationManager.requestState(for: target.region)
            target.region.notifyOnEntry = true
            target.region.notifyOnExit = true
        }
    }

    func convertRegionToArea(region: String) -> Area {
        var activeZone: Area?
        for area in areas where area.identifier == region {
            activeZone = area
        }
        return activeZone ?? Area.greaterArea
    }
}

// MARK: - DELEGATE
extension LocationManager: CLLocationManagerDelegate {

    // MARK: - handleActiveArea
    fileprivate func handleActiveArea(_ region: CLRegion) {
        activeArea = convertRegionToArea(region: region.identifier)

        if activeArea == torodoArea {
            isNearGobyo = true
            showGobyoAlert = true
        } else {
            isNearGobyo = false
        }

        if activeArea?.isTargetZone == true {

            isInTargetZone = true
            activeTargetZone = activeArea
            if let index = Landmark.allLandmarks.firstIndex(where: { $0.area == activeArea?.identifier }) {
                scrollIndex = Landmark.allLandmarks[index].id
            }
        } else {
            isInTargetZone = false
            activeTargetZone = nil
        }
    }
    // MARK: - DID DETERMINE STATE
    func locationManager(_ manager: CLLocationManager, didDetermineState state: CLRegionState, for region: CLRegion) {
        if state == .inside {
            guard !region.identifier.isEmpty else {return}
            onEntry = false
            handleActiveArea(region)
        }
    }

    // MARK: - DID ENTER REGION
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        guard !region.identifier.isEmpty else {return}
        handleActiveArea(region)
    }

    // MARK: - DID EXIT REGION

    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
        guard !region.identifier.isEmpty else {return}
        activeArea = convertRegionToArea(region: region.identifier)
        isInTargetZone = false
        activeTargetZone = nil
    }

    func locationManager(_ manager: CLLocationManager,
                         monitoringDidFailFor region: CLRegion?,
                         withError error: Error) {
        print(error.localizedDescription)
    }

    func locationManager(_ manager: CLLocationManager,
                         didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            locationManager.startUpdatingLocation()
        case .notDetermined:
            verifyGPSAuthorization()
        case .denied, .restricted:
            alertItem = AlertContext.authorizationRequest
        default:
            break
        }
    }

    func stopLocationServices() {
        locationManager.stopUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else {return}

        let range: Double = 5000
        let centerPoint = CLLocation(
            latitude: Area.greaterArea.coordinate.latitude,
            longitude: Area.greaterArea.coordinate.longitude)

        let distance = location.distance(from: centerPoint)
        if distance < range { // the user is in the greater area

        } else {
            inGreaterRange = false
            alertItem = AlertContext.outOfRange
        }
    }
    // MARK: - ERRORS
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        guard let clError = error as? CLError else { return }
        switch clError {
        case CLError.regionMonitoringFailure: print("Region monitor failure")
            alertItem = AlertContext.regionMonitorFailure
        case CLError.deferredNotUpdatingLocation: print("Not updating")
            alertItem = AlertContext.updatingFailure
        case CLError.deferredFailed: print("Deferred failed")
        case CLError.deferredAccuracyTooLow: print("accuracy too low")
            alertItem = AlertContext.lowAccuracy
        case CLError.denied: print("Access denied")
        case CLError.locationUnknown: print("Location is Unknown")
        default: print("Catch all errors.")
        }
    }
}

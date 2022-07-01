//
//  KenshinChallengeViewModel.swift
//  KoyaQuest2021
//
//  Created by Kevin K Collins on 2021/05/03.
//

import SwiftUI
import CoreLocation

final class KenshinChallengeViewModel: NSObject , ObservableObject {
    let kenshinLocator = CLLocationManager()
    
    @Published var didFindGhost = false
    @Published var didConcludeVideo = false
    @Published var didExitChallenge = false
    @Published var success = false
    @Published var challengeCompleted: Bool = false
    @Published var instructions: String = ""
    @Published var scannedCode = ""
    @Published var foundLocation = "Keep searching..."
    @Published var foundTakeda = false
    @Published var alertItem: KenshinScannerAlertItem?
    @Published var distanceToTarget = 50.00
    
    let kenshinHaka = CLLocation(
        latitude: ("34.21702248" as NSString).doubleValue, //50--2342516
        longitude: ("135.598298" as NSString).doubleValue
    )

    let takedaHaka = CLLocation(
        latitude: ("34.2165230" as NSString).doubleValue, // 233-3981546
        longitude: ("135.598398" as NSString).doubleValue //415-2551383
    )
    
    override init() {
        super.init()
        kenshinLocator.delegate = self
    }
    
    func setSuccess() {
        self.success = true
        // print("Set success to true")
    }

    var scannerStatusText: String {
        scannedCode.isEmpty ? "Not yet scanned" : scannedCode
    }

    var scannerStatusTextColor: Color {
        var color: Color = .koyaGreen
        switch foundLocation {
        case "": color = .red
        case "QR-Code does not belong to Mt. Koya": color = .red
        case "Unrecognized QR Code": color = .red
        default: color = .koyaGreen
        }
        return color
    }

    var statusText: String {
        didFindGhost ? "You found the Ghost! (Move closer for better viewing.)" : "Keep searching..."
    }
    
    var displayOverlay: Bool {
        var display = false
        if target == takedaHaka {
            if distanceToTarget < 10 {
                display = true
            }
        } else {
            display = false
        }
        return display
    }
    
    var target: CLLocation {
        didFindGhost ? takedaHaka : kenshinHaka
    }

    var statusTextColor: Color {
        didFindGhost ? .koyaGreen : .red
    }
    
    var bearing: CLLocationDirection = 0.0
    var heading: Double = 0.0
    
    var rotation: Double {
        let degrees = (self.heading - self.bearing) * -1
        return degrees
    }

    var distanceIndicatorColor: Color {
        switch distanceToTarget {
        case 99.00..<300.00:
            return Color.koyaRed
        case 49.00..<99.00:
            return Color.koyaOrange
        case 0.00..<49:
            return Color.koyaGreen
        default:
            return Color.koyaRed
        }
    }
    
    func verifyGPSAuthorization() {
        if kenshinLocator.authorizationStatus == .authorizedAlways
            || kenshinLocator.authorizationStatus == .authorizedWhenInUse {
            startLocationServices()
        } else {
            kenshinLocator.requestAlwaysAuthorization()
        }
    }
    
    func startLocationServices() {
            kenshinLocator.startUpdatingLocation()
        }

    func stopTakedaLocator() {
        kenshinLocator.stopUpdatingLocation()
    }
    
    private func getBearing(fromLocation: CLLocation, toLocation: CLLocation) {
            var bearing: CLLocationDirection
            let fromLat = D2R2D.degreesToRadians(fromLocation.coordinate.latitude)
            let fromLon = D2R2D.degreesToRadians(fromLocation.coordinate.longitude)
            let toLat = D2R2D.degreesToRadians(toLocation.coordinate.latitude)
            let toLon = D2R2D.degreesToRadians(toLocation.coordinate.longitude)
    
                let y = sin(toLon - fromLon) * cos(toLat)
                let x = cos(fromLat) * sin(toLat) - sin(fromLat) * cos(toLat) * cos(toLon - fromLon)
            bearing = D2R2D.radiansToDegrees( atan2(y, x) ) as CLLocationDirection
    
                bearing = (bearing + 360.0)
                self.bearing = bearing
            }
    
        private func getHeading(){
            kenshinLocator.startUpdatingHeading()
        }
}

// MARK: - DELEGATE
extension KenshinChallengeViewModel: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.last!
        let distance = location.distance(from: target)
        self.distanceToTarget = distance
        //let desiredRange: Double = 2.0
        let roundedDistance = Double(round(1000*distance)/1000)
        distanceToTarget = roundedDistance
        getBearing(fromLocation: location, toLocation: target)
    }
    
        func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
            if status == .authorizedAlways || status == .authorizedWhenInUse {
                if CLLocationManager.isMonitoringAvailable(for: CLBeaconRegion.self) {
//                    if CLLocationManager.isRangingAvailable() {
//                        self.beaconRangingAvailable = true
//                    }
                    if CLLocationManager.headingAvailable() {
                        getHeading()
                    }
                }
            }
        }
        func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
            self.heading = newHeading.trueHeading
        }
}

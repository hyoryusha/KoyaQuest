//
//  VajraGameScene.swift
//  KoyaQuest
//
//  Created by Kevin K Collins on 2021/06/06.
//

import SpriteKit
import ARKit
import SwiftUI

class VajraGameScene: SKScene, CLLocationManagerDelegate {
    weak var viewContoller: VajraFinderVC?
    var viewModel: VajraChallengeViewModel?
    var display = ""
    var distanceTracker: Double?
    let sight = SKSpriteNode(imageNamed: "sight")
    var isSetUp = false
    // added 5-14-22:
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
        viewModel?.bearing = bearing
        }
    
    private func getHeading(){
        locationManager.startUpdatingHeading()
    }
    
    var sceneView: ARSKView {
        // swiftlint:disable force_cast
        return view as! ARSKView
        // swiftlint:enable force_cast
    }

    override func sceneDidLoad() {
        locationManager.delegate = self
    }

    // Sanko Pine small string 34.213344, 135.579316
    let targetSanko = CLLocation(
        latitude: ("34.213344" as NSString).doubleValue,
        longitude: ("135.579316" as NSString).doubleValue
    )

    // MARK: - LOCATION MANAGER
    var locationManager = CLLocationManager()

    func setUpCoreLocation() {
        if locationManager.authorizationStatus == .authorizedAlways
            || locationManager.authorizationStatus == .authorizedWhenInUse {
            startLocationServices()
        } else {
            locationManager.requestAlwaysAuthorization()
        }
    }

    func startLocationServices() {
        if CLLocationManager.locationServicesEnabled() {
            locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
            locationManager.activityType = .fitness
            locationManager.startUpdatingLocation()
        }
    }

    // MARK: - DETERMINE RANGE
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.last!
        let distance = location.distance(from: targetSanko)
        self.distanceTracker = distance
        let desiredRange: Double = 10.0
        let roundedDistance = Double(round(1000*distance)/1000)
        viewModel?.distance = roundedDistance

        //added 5-14-22
        if CLLocationManager.headingAvailable() {
            getHeading()
        }
        getBearing(fromLocation: location, toLocation: targetSanko)
        
        if distance < desiredRange {
            self.display = "true"
            viewModel?.distance = 0
            viewModel?.found = true
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        viewModel?.heading = newHeading.trueHeading
    }

    // MARK: - SPRITE NODES

    private func setUp() {
        guard let currentFrame = sceneView.session.currentFrame
        else { return }
        var translation = matrix_identity_float4x4
        translation.columns.3.z = -3.0 // this is the apparent distance from user in meters
        let transform = currentFrame.camera.transform * translation
        let anchor = ARAnchor(transform: transform)
        if self.display == "true" {
            sceneView.session.add(anchor: anchor)
            isSetUp = true
            showSight()
        }
    }

    override func update(_ currentTime: TimeInterval) {
        if !isSetUp {
            setUp()
        }
    }

    func showSight() {
        sight.position = CGPoint(x: self.frame.width / 2, y: self.frame.height / 2)
        addChild(sight)
    }

    func showFeedback() {
        sight.removeFromParent()
        viewModel?.zapped = true
        viewModel?.isShowingModal = true
        let successLabel = SuccessLabel(text: "Success!")
        successLabel.position = CGPoint(x: self.frame.width / 2, y: 0 + self.frame.height / 2 - 60)
        addChild(successLabel)
    }

    override func didMove(to view: SKView) {
        setUpCoreLocation()
        UIApplication.shared.isIdleTimerDisabled = true
        do {
            let sounds: [String] = ["zapped"]
            for sound in sounds {
                let path: String = Bundle.main.path(forResource: sound, ofType: "wav")!
                let url: URL = URL(fileURLWithPath: path)
                let audioPlayer: AVAudioPlayer = try AVAudioPlayer(contentsOf: url)
                audioPlayer.prepareToPlay()
            }
        } catch {
        }
    }

    override func touchesBegan(_ touches: Set<UITouch>,
                               with event: UIEvent?) {

        let location = sight.position
        let hitNodes = nodes(at: location)
        var hitSanko: SKNode?

        for node in hitNodes  where node.name == "sanko" {
            hitSanko = node
        }

        // if the sanko was "captured"
        if let hitSanko = hitSanko,
           let anchor = sceneView.anchor(for: hitSanko) {
            let action = SKAction.run {
                self.run(SKAction.playSoundFileNamed("zapped", waitForCompletion: false))
                self.sceneView.session.remove(anchor: anchor)
                self.showFeedback()
            }
            let group = SKAction.group([action])
            let sequence = [SKAction.wait(forDuration: 0.3), group]
            hitSanko.run(SKAction.sequence(sequence))
        }
    }
}

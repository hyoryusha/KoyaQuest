//
//  KenshinFinderVC.swift
//  KoyaQuest2021
//
//  Created by Kevin K Collins on 2021/05/03.
//

import UIKit
import ARKit
import AVKit
import AVFoundation

protocol KenshinFinderVCDelegate: AnyObject {
    func didFindGhost()
    func videoCompleted()
    func updateInstructions(instructions: String)
}

class KenshinFinderVC: UIViewController, ARSCNViewDelegate, ARSessionDelegate {
    weak var kenshinFinderDelegate: KenshinFinderVCDelegate?
    var videoPlayCount = 0
    init(kenshinFinderDelegate: KenshinFinderVCDelegate) {
        super.init(nibName: nil, bundle: nil)
        self.kenshinFinderDelegate = kenshinFinderDelegate
    }
    var avPlayer: AVPlayer?
    let avPlayerController = AVPlayerViewController()
    var foundAnchor: ARImageAnchor?
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    let targetImageNames = [
        "kenshin_door": "Mausoleum of Uesugi Kenshin"
        ]

    var isRestartAvailable = true

    let configuration = ARWorldTrackingConfiguration()

    var sceneView: ARSCNView {
        // swiftlint:disable force_cast
        return self.view as! ARSCNView
        // swiftlint:enable force_cast
       }

    override func loadView() {
         self.view = ARSCNView(frame: .zero)
       }
    override func viewDidLoad() {
          super.viewDidLoad()
            sceneView.delegate = self
            sceneView.scene = SCNScene()
            UIApplication.shared.isIdleTimerDisabled = true
            startARSession()
       }
// MARK: - Functions for standard AR view handling

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
       }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
       }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        sceneView.session.run(configuration)
        sceneView.delegate = self
       }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        sceneView.session.pause()
        self.avPlayer?.pause()
       }
    // MARK: - ARSCNViewDelegate

    func sessionWasInterrupted(_ session: ARSession) {}

    func sessionInterruptionEnded(_ session: ARSession) {}

    func session(_ session: ARSession, didFailWithError error: Error) { }

    func session(_ session: ARSession, cameraDidChangeTrackingState
       camera: ARCamera) {
        var instructionString = ""
        switch camera.trackingState {
        case .limited(let reason):
            // instructionLabel.isHidden = false
          switch reason {
          case .excessiveMotion:
            instructionString = "Try moving more slowly"
          case .initializing, .relocalizing:
            instructionString = "Warming up..."
          case .insufficientFeatures:
            instructionString = "Not enough features detected. It may be too dark."
          @unknown default:
            fatalError("Unknown error.")
            }
        case .normal:
            instructionString = "Point your camera toward a place where you might expect to see Kenshin's ghost."
        case .notAvailable:
            instructionString = "Camera tracking is not available."
        }
        kenshinFinderDelegate?.updateInstructions(instructions: instructionString)
    }

    // MARK: - Image detection

        func startARSession() {
          // Make sure that we have an AR resource group.
          guard let referenceImages = ARReferenceImage.referenceImages(inGroupNamed: "AR Resources", bundle: nil) else {
            fatalError("This app doesn't have an AR resource group named 'AR Resources'!")
          }

          // Set up the AR configuration.
          configuration.worldAlignment = .gravityAndHeading
          configuration.detectionImages = referenceImages

          // RUN the AR session:
          sceneView.session.run(configuration, options: [.resetTracking, .removeExistingAnchors])
        }

        func restartExperience() {
          guard isRestartAvailable else { return }
          isRestartAvailable = false
          startARSession()
            print("Experience restarted")
          // Disable for a few seconds to give the AR session time to restart.
          DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
            self.isRestartAvailable = true
          }
        }

        func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
          guard let imageAnchor = anchor as? ARImageAnchor else {
            return }
//          let referenceImage = imageAnchor.referenceImage
            foundAnchor = imageAnchor
          DispatchQueue.main.async {
            self.handleSuccess()
            self.handleFoundImage(imageAnchor, node)
          }
        }

    func handleSuccess() {
            kenshinFinderDelegate?.didFindGhost()
        }

//    func stopVideo() {
//        print("will try to stop video")
//        self.avPlayer?.pause()
//
//    }
    private func handleFoundImage(_ imageAnchor: ARImageAnchor, _ node: SCNNode) {
        foundAnchor = imageAnchor
        print("found anchor set")
        let size = imageAnchor.referenceImage.physicalSize
        if let videoNode = makeGhostVideo(size: size) {
          node.addChildNode(videoNode)
          node.opacity = 1
        }
  }
    private func makeGhostVideo(size: CGSize) -> SCNNode? {
    guard let videoURL = Bundle.main.url(forResource: "uesugi_ghost",
                                         withExtension: "mp4") else {
                                          return nil
    }

    let avPlayerItem = AVPlayerItem(url: videoURL)
    //let avPlayer = AVPlayer(playerItem: avPlayerItem)
        avPlayer = AVPlayer(playerItem: avPlayerItem)
        if videoPlayCount < 1 { // this should not work
            self.avPlayer?.play()
        } else {
            return nil
        }
    NotificationCenter.default.addObserver(
        forName: .AVPlayerItemDidPlayToEndTime,
        object: nil,
        queue: nil
    ) { _ in
        self.avPlayer?.seek(to: .zero)
        //self.avPlayerController.dismiss(animated: true)
        self.kenshinFinderDelegate?.videoCompleted()
        print("Delegate video completed called.")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { [unowned self] in
            self.kenshinFinderDelegate?.videoCompleted() // why is this called twice?
            print("Delegate video completed called after async delay.")
            videoPlayCount += 1
            print("Video play count is \(videoPlayCount)")
        }
    }

    let avMaterial = SCNMaterial()
    avMaterial.diffuse.contents = avPlayer

    let videoPlane = SCNPlane(width: size.width, height: size.height)
    videoPlane.materials = [avMaterial]

    let videoNode = SCNNode(geometry: videoPlane)
    videoNode.eulerAngles.x = -.pi / 2
    return videoNode
  }
}

//
//  KukaiFinderVC.swift
//  KoyaQuest
//
//  Created by Kevin K Collins on 2021/06/10.
//

import UIKit
import ARKit
import AVFoundation

protocol KukaiFinderVCDelegate: AnyObject {
    func didFind(foundImage: String)
}

class KukaiFinderVC: UIViewController, ARSCNViewDelegate, ARSessionDelegate {
    weak var kukaiFinderDelegate: KukaiFinderVCDelegate?

    init(kukaiFinderDelegate: KukaiFinderVCDelegate) {
        super.init(nibName: nil, bundle: nil)
        self.kukaiFinderDelegate = kukaiFinderDelegate
    }

    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented") }

    let targetImageNames = [
        "kukai": "Kūkai"
        ]

    var isRestartAvailable = true
    var printMessage: String = ""
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
        UIApplication.shared.isIdleTimerDisabled = true
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
       }

    // MARK: - ARSCNViewDelegate

    func sessionWasInterrupted(_ session: ARSession) {}

    func sessionInterruptionEnded(_ session: ARSession) {}

    func session(_ session: ARSession, didFailWithError error: Error) {}

    func session(_ session: ARSession, cameraDidChangeTrackingState
       camera: ARCamera) {}
    // MARK: - Image detection

        func startARSession() {
            guard let referenceImages = ARReferenceImage.referenceImages(
                    inGroupNamed: "AR Resources",
                    bundle: nil
            ) else {
                fatalError("Missing expected asset catalog resources.")
            }
          configuration.worldAlignment = .gravityAndHeading
          configuration.detectionImages = referenceImages
          sceneView.session.run(configuration, options: [.resetTracking, .removeExistingAnchors])
        }

        func restartExperience() {
          guard isRestartAvailable else { return }
          isRestartAvailable = false
          startARSession()
          // Disable for a few seconds to give the AR session time to restart.
          DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
            self.isRestartAvailable = true
          }
        }

        func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {

          guard let imageAnchor = anchor as? ARImageAnchor else { return }
          let referenceImage = imageAnchor.referenceImage
          let imageName = referenceImage.name ?? "[Unknown]"
          DispatchQueue.main.async {
            self.handleSuccess(imageName: self.targetImageNames[imageName] ?? "Unidentified")
          }
        }

    func handleSuccess(imageName: String) {
            kukaiFinderDelegate?.didFind(foundImage: imageName)
            print(printMessage)
        }
}

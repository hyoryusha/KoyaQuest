//
//  VajraFinderVC.swift
//  KoyaQuest
//
//  Created by Kevin K Collins on 2021/06/06.
//

import SwiftUI
import UIKit
import ARKit
import SpriteKit

protocol VajraFinderVCDelegate: AnyObject {
//    func didFind()
//    func didSurface(error: CameraError)
}

class VajraFinderVC: UIViewController {
    var sceneView = ARSKView()
    var gameScene: VajraGameScene?
    var viewModel: VajraChallengeViewModel?
    var found: Bool?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(sceneView)

        // add autolayout contstraints
        sceneView.translatesAutoresizingMaskIntoConstraints = false
        sceneView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        sceneView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        sceneView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        sceneView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true

        // Set the view's delegate
                sceneView.delegate = self
                let scene = VajraGameScene(size: sceneView.bounds.size)
                scene.viewModel = viewModel
                scene.scaleMode = .resizeFill
                sceneView.presentScene(scene)
        }

        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            let configuration = ARWorldTrackingConfiguration()
            sceneView.session.run(configuration) // this is where the app crashes:
        }

        override func viewWillDisappear(_ animated: Bool) {
            super.viewWillDisappear(animated)
            sceneView.session.pause()
        }

        override var shouldAutorotate: Bool {
            return true
        }

        override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
            if UIDevice.current.userInterfaceIdiom == .phone {
                return .allButUpsideDown
            } else {
                return .all
            }
        }

        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Release any cached data, images, etc that aren't in use.
        }

        override var prefersStatusBarHidden: Bool {
            return true
        }
    }

// MARK: - EXTENSION

extension VajraFinderVC: ARSKViewDelegate {
    func session(_ session: ARSession,
                 didFailWithError error: Error) {
        print("Failure")
    }

    func sessionWasInterrupted(_ session: ARSession) {
        print("Session interrupted")
    }

    func sessionInterruptionEnded(_ session: ARSession) {
        print("Session resumed")
        sceneView.session.run(session.configuration!,
                              options: [.resetTracking,
                                        .removeExistingAnchors])
    }

    func view(_ view: ARSKView,
              nodeFor anchor: ARAnchor) -> SKNode? {
        let sanko = SKSpriteNode(imageNamed: "sanko")
        sanko.position = CGPoint(x: view.frame.midX, y: view.frame.midY + 100)
        // add animation here:
        let shiftUpAction = SKAction.moveBy(x: 0, y: 40, duration: 1.8)
        let shiftDownAction = SKAction.moveBy(x: 0, y: -40, duration: 1.8)
        let scaleUpAction = SKAction.scale(to: 1.3, duration: 1.8)
        let scaleDownAction = SKAction.scale(to: 1, duration: 1.8)
        let firstPhase = SKAction.group([shiftUpAction, scaleUpAction])
        let secondPhase = SKAction.group([shiftDownAction, scaleDownAction])
        let actionSequence = SKAction.sequence([firstPhase, secondPhase])
        let repeatAction = SKAction.repeatForever(actionSequence)
        sanko.run(repeatAction)
        sanko.name = "sanko"
        return sanko
    }
}

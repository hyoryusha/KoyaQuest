//
//  KoyakunCatcherVC.swift
//  KoyaQuest2021
//
//  Created by Kevin K Collins on 2021/05/01.
//

import UIKit
import ARKit
import AVFoundation
import SpriteKit

protocol KoyakunCatcherVCDelegate: AnyObject {
    // func didFind(foundImage: String)
}

class KoyakunCatcherVC: UIViewController {

    var sceneView = ARSKView()
    var gameScene: KoyakunGameScene?
    var viewModel: KoyakunChallengeViewModel?
    var completed: Bool?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(sceneView)

        sceneView.translatesAutoresizingMaskIntoConstraints = false
        sceneView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        sceneView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        sceneView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        sceneView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        sceneView.delegate = self

        let scene = KoyakunGameScene(size: sceneView.bounds.size)
        scene.viewModel = viewModel
        scene.scaleMode = .resizeFill
        sceneView.presentScene(scene)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let koyakunConfiguration = ARWorldTrackingConfiguration()
       sceneView.session.run(koyakunConfiguration)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        sceneView.session.pause()
    }
}
// MARK: - ARSKViewDelegate

extension KoyakunCatcherVC: ARSKViewDelegate {

    func view(_ view: ARSKView, nodeFor anchor: ARAnchor) -> SKNode? {
        if KoyakunGameScene.koyaGameState == .generatingKoyakun {
            let koyakun = Koyakun()
            koyakun.setup()
            return koyakun
        } else {
            return SKNode()
        }
    }

    func session(_ session: ARSession, didFailWithError error: Error) {
        // present error message to user
        print("did fail with error: \(error.localizedDescription)")
        fatalError("Fatal error: \(error.localizedDescription)")
    }

    func sessionWasInterrupted(_ session: ARSession) {
        // inform user that session has been interrupted
    }

    func sessionInterruptionEnded( _ session: ARSession) {
        // reset tracking and or remove existing anchors if consistent traking is req'd
    }
}

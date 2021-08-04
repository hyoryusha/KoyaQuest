//
//  DaimonGameScene.swift
//  KoyaQuest
//
//  Created by Kevin K Collins on 2021/06/05.
//

import SwiftUI
import SpriteKit

class DaimonGameScene: SKScene {
    var viewModel: DaimonGameViewModel?
    let daimon = SKSpriteNode(imageNamed: "daimon_whats_wrong")
    let solution = SKSpriteNode(imageNamed: "daimon_solution")
    let box = SKSpriteNode(color: SKColor.clear, size: CGSize(width: 580, height: 190))
    // let successLabel = SKLabelNode(text: "You got it!")
    let successLabel = SuccessLabel(text: "You got it!")
    // let failLabel = SKLabelNode(text: "Too bad, you missed it.")
    let failLabel = FailLabel(text: "No, that was incorrect")

    override func didMove(to view: SKView) {
        UIApplication.shared.isIdleTimerDisabled = true
        view.allowsTransparency = true
        view.backgroundColor = UIColor(.clear)
        daimon.scale(to: CGSize(width: frame.size.width, height: frame.size.width * 0.75))
        // daimon.scale(to: CGSize(width: 400, height: 300))
        daimon.zPosition = 1
        daimon.position = CGPoint(x: frame.size.width / 2, y: frame.size.height / 2)
        daimon.name = "daimon"

        box.name = "target"
        box.zPosition = 100
        box.position = CGPoint(x: 70, y: 300)

        addChild(daimon)
        daimon.addChild(box)
        solution.scale(to: CGSize(width: 727, height: 700))
        solution.position = CGPoint(x: 70, y: 400)
        if viewModel?.showingSolution == true {
            daimon.addChild(solution)
            if viewModel?.tapOnTarget == true {
            } else {
            }
        }
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {return}
        if viewModel?.respondToTap == true {
            let positionInScene = touch.location(in: self)
            selectNodeForTouch(touchLocation: positionInScene)
        }
    }

    func selectNodeForTouch(touchLocation: CGPoint) {
        let touchedNode = self.atPoint(touchLocation)
        if touchedNode is SKSpriteNode {
            // a node has been tapped...
            if touchedNode.name == "target" {
                viewModel?.tapOnTarget = true
                viewModel?.points = 20
            } else {
                viewModel?.tapOnTarget = false
            }
            viewModel?.showingAlert = true
        }
    }
}

//
//  ShogunsSummaryScene.swift
//  KoyaQuest
//
//  Created by Kevin K Collins on 2021/06/11.
//

import SpriteKit
import SwiftUI
import GameplayKit

class ShogunsSummaryScene: SKScene {
    var viewModel: ShogunsChallengeViewModel?
    var backgroundSprite = SKSpriteNode(imageNamed: "shoguns_solved")
    let feedback = SKLabelNode(text: "The correct answers are...")
    let kamiNoKu = SKLabelNode(text: "If the cuckoo will not sing...")
    override func didMove(to view: SKView) {

    self.backgroundColor = UIColor(red: 30 / 255, green: 32 / 255, blue: 53 / 255, alpha: 1.0)
        backgroundSprite.setScale(0.9)

    backgroundSprite.position = CGPoint(x: frame.size.width / 2, y: frame.size.height / 2 - 20)
    backgroundSprite.zPosition = 1
    backgroundSprite.name = "shoguns_solved"
    addChild(backgroundSprite)

    feedback.fontSize = 18
        feedback.fontName = SKFont.medium
    feedback.fontColor = UIColor(red: 0, green: 204 / 255, blue: 131 / 255, alpha: 1.0)

    feedback.position = CGPoint(x: frame.size.width / 2, y: frame.size.height - frame.size.height / 8)
    feedback.zPosition = 100
    addChild(feedback)
    kamiNoKu.fontSize = 16.0
        kamiNoKu.fontName = SKFont.mediumItalic
    kamiNoKu.fontColor = UIColor.white
        kamiNoKu.position = CGPoint(x: frame.size.width / 2, y: frame.size.height - frame.size.height / 6.5 )
        kamiNoKu.zPosition = 100
    addChild(kamiNoKu)
    }
}

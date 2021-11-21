//
//  ShogunsSummaryScene.swift
//  KoyaQuest
//
//  Created by Kevin K Collins on 2021/06/11.
//

import SpriteKit
import SwiftUI

class ShogunsSummaryScene: SKScene {
    @Binding var challengeCompleted: Bool

    init(_ challengeCompleted: Binding<Bool>) {
        _challengeCompleted = challengeCompleted
        super.init(size: CGSize(
            width: UIScreen.main.bounds.width,
            height: UIScreen.main.bounds.height))
        self.scaleMode = .aspectFill
    }

    required init?(coder aDecoder: NSCoder) {
        _challengeCompleted = .constant(false)
        super.init(coder: aDecoder)
    }

    var backgroundSprite = SKSpriteNode(imageNamed: "shoguns_solved")
    let feedback = SKLabelNode(text: "The correct answers are:")
    let kamiNoKu = SKLabelNode(text: "If the cuckoo will not sing...")

    let exitButton = SKSpriteNode(color: SKColor.orange, size: CGSize(width: 244, height: 48))
    let exitButtonLabel = SKLabelNode(text: "Exit")

    override func didMove(to view: SKView) {

        self.backgroundColor = UIColor(red: 30 / 255, green: 32 / 255, blue: 53 / 255, alpha: 1.0)
        backgroundSprite.setScale(0.8)

        backgroundSprite.position = CGPoint(x: frame.size.width / 2, y: frame.size.height / 2 - 20)
        backgroundSprite.zPosition = 1
        backgroundSprite.name = "shoguns_solved"
        addChild(backgroundSprite)

        feedback.fontSize = 18
        feedback.fontName = SKFont.medium
        feedback.fontColor = UIColor(red: 0, green: 204 / 255, blue: 131 / 255, alpha: 1.0)

        feedback.position = CGPoint(
            x: frame.size.width / 2,
            y: frame.size.height - frame.size.height / 8
        )
        feedback.zPosition = 100
        addChild(feedback)
        kamiNoKu.fontSize = 16.0
        kamiNoKu.fontName = SKFont.mediumItalic
        kamiNoKu.fontColor = UIColor.white
        kamiNoKu.position = CGPoint(
            x: frame.size.width / 2,
            y: frame.size.height - frame.size.height / 6.5
        )
        kamiNoKu.zPosition = 100
        addChild(kamiNoKu)

        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) { [weak self] in
            self?.addExitButton()
        }
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            if exitButton.contains(location) {
                challengeCompleted = true
            }
        }
    }

    func addExitButton() {
        exitButtonLabel.fontName = SKFont.bold
        exitButtonLabel.fontSize = 34.0
        exitButtonLabel.fontColor = UIColor.white
        exitButtonLabel.position = CGPoint(x: 0, y: -12)
        exitButton.addChild(exitButtonLabel)
        exitButton.position = CGPoint(x: self.frame.midX, y: self.frame.size.height * 0.085)
        exitButton.zPosition = 5
        let fadeInAction = SKAction.fadeIn(withDuration: 1.0)
        addChild(exitButton)
        exitButton.run(fadeInAction)
    }
}

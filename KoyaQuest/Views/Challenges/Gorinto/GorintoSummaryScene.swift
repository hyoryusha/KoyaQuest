//
//  GorintoSummaryScene.swift
//  KoyaQuest
//
//  Created by Kevin K Collins on 2021/06/12.
//

import SpriteKit
import SwiftUI

class GorintoSummaryScene: SKScene {
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

    let gorinto = SKSpriteNode(imageNamed: "gorinto_solution_purple")
    let kanji = SKLabelNode(text: "五輪塔")
    let topExplanation = SKLabelNode(text: "The sections are as follows:")
    let bottomExplanation = SKLabelNode(text: "Collectively, they represent Consciousness.")
    let exitButton = SKSpriteNode(
        color: SKColor.orange,
        size: CGSize(width: 258,
                     height: 66)
    )
    let exitButtonLabel = SKLabelNode(text: "Exit")

    override func didMove(to view: SKView) {
        self.backgroundColor = UIColor.koyaPurple
        ?? UIColor(
            red: 30 / 255,
            green: 32 / 255,
            blue: 53 / 255,
            alpha: 1.0
        )

        kanji.fontName = SKFont.kanji
        kanji.fontSize = 28.0
        kanji.fontColor = UIColor.orange
        kanji.position = CGPoint(x: frame.midX, y: frame.size.height * 0.90)
        addChild(kanji)

        topExplanation.fontName = SKFont.bold
        topExplanation.fontSize = 24.0
        topExplanation.fontColor = UIColor.white
        topExplanation.position = CGPoint(x: frame.midX, y: frame.size.height * 0.85)
        addChild(topExplanation)

        gorinto.size = CGSize(width: 672, height: 989)
        gorinto.setScale(0.5)
        gorinto.position = CGPoint(x: frame.midX, y: frame.size.height * 0.45)
        gorinto.zPosition = 1
        gorinto.name = "gorinto"
        addChild(gorinto)

        bottomExplanation.color = UIColor.white
        bottomExplanation.fontName = SKFont.regular
        bottomExplanation.fontSize = 15.0
        bottomExplanation.fontColor = UIColor.white
        bottomExplanation.position = CGPoint(x: frame.midX, y: frame.size.height * 0.8)
        addChild(bottomExplanation)

        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) { [weak self] in
            self?.addExitButton()
        }
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {

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
        exitButtonLabel.fontSize = 40.0
        exitButtonLabel.fontColor = UIColor.white
        exitButtonLabel.position = CGPoint(x: 0, y: -12)
        exitButton.addChild(exitButtonLabel)
        exitButton.position = CGPoint(
            x: self.frame.midX,
            y: self.frame.size.height * 0.12
        )
        exitButton.zPosition = 5
        let fadeInAction = SKAction.fadeIn(withDuration: 1.0)
        addChild(exitButton)
        exitButton.run(fadeInAction)
    }
}

//
//  GorintoSummaryScene.swift
//  KoyaQuest
//
//  Created by Kevin K Collins on 2021/06/12.
//

import SpriteKit
import StoreKit
import SwiftUI

class GorintoSummaryScene: SKScene {
    var viewModel: GorintoChallengeViewModel?
    let gorinto = SKSpriteNode(imageNamed: "gorinto_solution_purple")
    let kanji = SKLabelNode(text: "五輪塔")
    let topExplanation = SKLabelNode(text: "The sections are as follows:")
    let bottomExplanation = SKLabelNode(text: "Collectively, they represent Consciousness.")

    let exitMessage = SKLabelNode(text: "Tap the X (in upper-right corner) to exit.")

    override func didMove(to view: SKView) {
        self.backgroundColor = UIColor.koyaPurple
            ?? UIColor(red: 30 / 255, green: 32 / 255, blue: 53 / 255, alpha: 1.0)

        kanji.fontName = SKFont.kanji
        kanji.fontSize = 28.0
        kanji.fontColor = UIColor.orange
        kanji.position = CGPoint(x: frame.midX, y: frame.maxY - 100)
        addChild(kanji)

        topExplanation.fontName = SKFont.bold
        topExplanation.fontSize = 24.0
        topExplanation.fontColor = UIColor.white
        topExplanation.position = CGPoint(x: frame.midX, y: frame.maxY - 160)
        addChild(topExplanation)

        gorinto.size = CGSize(width: 672, height: 989)
        gorinto.setScale(0.5)
        gorinto.position = CGPoint(x: frame.size.width / 2, y: frame.size.height / 2 - 20)
        gorinto.zPosition = 1
        gorinto.name = "gorinto"
        addChild(gorinto)

        bottomExplanation.color = UIColor.white
        bottomExplanation.fontName = SKFont.regular
        bottomExplanation.fontSize = 20.0
        bottomExplanation.fontColor = UIColor.white
        bottomExplanation.position = CGPoint(x: frame.midX, y: frame.minY + 10) // 120
        addChild(bottomExplanation)

        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) { [weak self] in
            self?.viewModel?.isShowingFeedback = true
        }
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {

    }
}

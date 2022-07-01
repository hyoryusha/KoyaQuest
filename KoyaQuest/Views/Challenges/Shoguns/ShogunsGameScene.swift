//
//  ShogunsGameScene.swift
//  KoyaQuest
//
//  Created by Kevin K Collins on 2021/06/11.
//

import SpriteKit
import SwiftUI
import GameplayKit

class ShogunsGameScene: SKScene {
    @Binding var challengeCompleted: Bool
    @Binding var pointsEarned: Int

    init(_ challengeCompleted: Binding<Bool>, _ pointsEarned: Binding<Int>) {
        _challengeCompleted = challengeCompleted
        _pointsEarned = pointsEarned
        super.init(size: CGSize(
            width: UIScreen.main.bounds.width,
            height: UIScreen.main.bounds.height))
        self.scaleMode = .aspectFill
    }

    required init?(coder aDecoder: NSCoder) {
        _challengeCompleted = .constant(false)
        _pointsEarned = .constant(0)
        super.init(coder: aDecoder)
    }

    var backgroundSprite = SKSpriteNode(imageNamed: "shoguns")
    var ieyasuQuote = SKSpriteNode(imageNamed: "ieyasu_quote")
    var nobunagaQuote = SKSpriteNode(imageNamed: "nobunaga_quote")
    var hideyoshiQuote = SKSpriteNode(imageNamed: "hideyoshi_quote")
    var kamiNoKu = SKLabelNode(text: "If the cuckoo will not sing...")
    var points = 0
    var selectedNode = SKSpriteNode()
    var checkButton = CheckAnswerButton()
    let checkButtonLabel = SKLabelNode(text: "Check")
    let alert = SKLabelNode(text: "You must move all the quotes into position.")
    let feedback = SKLabelNode(text: "")

    var group: SKSpriteNode!
    var finalPositions: [String: CGFloat] = [:]
    var matches: [String] = []
    var solved: Bool = false

    override func didMove(to view: SKView) {
        UIApplication.shared.isIdleTimerDisabled = true
        self.backgroundColor = SKColor.purple

        setUpBackground()
        addChild(backgroundSprite)

        ieyasuQuote.position = CGPoint(
            x: ieyasuQuote.size.width / 2 + 6,
            y: frame.size.height - frame.size.height / 9
        )
        ieyasuQuote.setScale(0.8)
        ieyasuQuote.zPosition = 10
        ieyasuQuote.name = "A"
        addChild(ieyasuQuote)

        nobunagaQuote.position = CGPoint(
            x: frame.size.width / 2 + 6,
            y: frame.size.height - frame.size.height / 9
        )
        nobunagaQuote.setScale(0.8)
        nobunagaQuote.zPosition = 10
        nobunagaQuote.name = "C"
        addChild(nobunagaQuote)

        hideyoshiQuote.position = CGPoint(
            x: frame.size.width - ieyasuQuote.size.width / 2 - 6,
            y: frame.size.height - frame.size.height / 9
        )
        hideyoshiQuote.setScale(0.8)
        hideyoshiQuote.zPosition = 10
        hideyoshiQuote.name = "B"
        addChild(hideyoshiQuote)

        kamiNoKu.fontSize = 15.0
        kamiNoKu.fontName = SKFont.mediumItalic
        kamiNoKu.fontColor = UIColor.white
        kamiNoKu.position = CGPoint(
            x: frame.size.width / 2,
            y: frame.size.height - frame.size.height / 9 + ieyasuQuote.size.height * 0.8
        )
        kamiNoKu.zPosition = 100
        addChild(kamiNoKu)
        setUpCheckButton()
        addChild(checkButton)
        setUpAlert()

        addChild(alert)
        alert.isHidden = true
    }

    func setUpBackground() {
        backgroundSprite.setScale(0.8)
        backgroundSprite.position = CGPoint(
            x: frame.size.width / 2,
            y: frame.size.height / 2 - 20
        )
        backgroundSprite.zPosition = 1
        backgroundSprite.name = "shoguns"
    }

    func setUpCheckButton() {
        checkButtonLabel.fontName = SKFont.bold
        checkButtonLabel.fontSize = 20.0
        checkButtonLabel.fontColor = UIColor.white
        checkButtonLabel.position = CGPoint(x: 0, y: -8)
        checkButton.addChild(checkButtonLabel)
        checkButton.position = CGPoint(x: frame.midX, y: frame.size.height * 0.075)
        checkButton.name = "check"
        checkButton.zPosition = 100
    }

    func setUpAlert() {
        alert.fontSize = 18
        alert.fontName = SKFont.medium
        alert.fontColor = UIColor.red
        alert.position = CGPoint(x: frame.size.width / 2, y: frame.size.height - frame.size.height / 6)
        alert.zPosition = 100
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {return}
        let positionInScene = touch.location(in: self)
        selectNodeForTouch(touchLocation: positionInScene)
        if checkButton.contains(positionInScene) {
            checkAnswers()
        }
    } // end touches began

    func checkAnswers() {
        if finalPositions.count < 3 {
            alert.isHidden = false
        } else {
            let keySorted = finalPositions.sorted { $0.0 < $1.0 }
            let correctSorted = finalPositions.sorted { $0.1 < $1.1 }
            var matchingIndices = 0
            let keyNames  = ["A", "B", "C"]
            var matches: [String] = []
            for name in keyNames {
                let correctIndexForName = keySorted.firstIndex(where: {$0.key == name})
                let returnedIndexForName = correctSorted.firstIndex(where: {$0.key == name})
                if correctIndexForName! == returnedIndexForName! {
                    matchingIndices += 1
                    matches.append(name)
                }
            }
            switch matchingIndices {
            case 3:
                points = 20
            case 1:
                points = 8
            case 0:
                points = 0
            default:
                points = 0
            }

            checkButton.isHidden = true
            kamiNoKu.isHidden = true
            alert.isHidden = true
            if matchingIndices == 1 {
                feedback.text = "You made \(matchingIndices) match for \(points) points"
            } else {
                feedback.text = "You made \(matchingIndices) matches for \(points) points"
            }

            setUpFeedback()
            addChild(feedback)
            colorize(for: matches)
            self.solved = true
            pointsEarned = self.points
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) { // go to summary scene
                self.showSummaryScene(withTransition: .crossFade(withDuration: 0.75))
            }
        }
    } // end checkAnswers()

    private func showSummaryScene(withTransition transition: SKTransition) {
        let delay = SKAction.wait(forDuration: 1)
        let sceneChange = SKAction.run {
            let scene = ShogunsSummaryScene(self.$challengeCompleted)
            self.view?.presentScene(scene, transition: transition)
        }
        run(.sequence([delay, sceneChange]))
    }

    func setUpFeedback() {
        feedback.fontSize = 17
        feedback.fontName = SKFont.medium
        // feedback.fontColor = UIColor(red: 0, green: 204 / 255, blue: 131 / 255, alpha: 1.0)
        feedback.fontColor = UIColor.koyaGreen
        feedback.position = CGPoint(x: frame.size.width / 2, y: frame.size.height - frame.size.height / 8)
        feedback.zPosition = 100
    }
    func colorize(for matches: [String]) {
        let colorOverlay = UIColor(red: 0, green: 204 / 255, blue: 131 / 255, alpha: 1.0)
        let colorize = SKAction.colorize(with: colorOverlay, colorBlendFactor: 0.5, duration: 1.5)
        for match in matches {
            let sprite = childNode(withName: match)
            sprite?.run(colorize)
        }
    }

    func selectNodeForTouch(touchLocation: CGPoint) {
        let touchedNode = self.atPoint(touchLocation)

        if touchedNode is SKSpriteNode && touchedNode.name != "shoguns" {

            if !selectedNode.isEqual(touchedNode) {
                selectedNode.removeAllActions()
                selectedNode.run(SKAction.rotate(toAngle: 0.0, duration: 0.1))
                // swiftlint:disable force_cast
                selectedNode = touchedNode as! SKSpriteNode
                // swiftlint:enable force_cast
            }
        }
    }
    func panForTranslation(translation: CGPoint) {
        let position = selectedNode.position
        let newPosition = CGPoint(x: position.x + translation.x, y: position.y + translation.y)
        selectedNode.position = newPosition
        let minHeight = backgroundSprite.frame.maxY
        if newPosition.y < minHeight {
            finalPositions[selectedNode.name ?? "something"] = newPosition.y
        }
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {return}
        let positionInScene = touch.location(in: self)
        let previousPosition = touch.previousLocation(in: self)
        let translation = CGPoint(x: positionInScene.x - previousPosition.x, y: positionInScene.y - previousPosition.y)
        panForTranslation(translation: translation)
        alert.isHidden = true
    }
}

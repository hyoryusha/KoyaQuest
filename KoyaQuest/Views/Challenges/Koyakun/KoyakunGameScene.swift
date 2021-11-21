//
//  KoyakunGameScene.swift
//  KoyaQuest2021
//
//  Created by Kevin K Collins on 2021/05/01.
//

import SpriteKit
import ARKit

class KoyakunGameScene: SKScene {
    var viewModel: KoyakunChallengeViewModel?
    var timerDisplay = SKLabelNode(text: "-- Secs.")
    var pointsDisplay = SKLabelNode(text: "0 Points")
    var messageDisplay = SKLabelNode(text: "Exit & begin again if no targets appear after 5 secs.")
    var numberOfKoyakun = 20
    var gameOver = false

    var remainingTime: Int = 61 {
        didSet {
            if remainingTime == 1 {
                timerDisplay.text = "\(remainingTime) Sec."
            } else {
                timerDisplay.text = "\(remainingTime) Secs."
            }
        }
    }

    var points: Int = 0 {
        didSet {
            pointsDisplay.text = "\(points) Points"
        }
    }

    static var koyaGameState: KoyakunGameState = .none

    override func didMove(to view: SKView) {
        UIApplication.shared.isIdleTimerDisabled = true

        NotificationCenter.default.addObserver(self,
                                               selector: #selector(KoyakunGameScene.generateKoyakun),
                                               name: Notification.Name("KoyakunGenerate"),
                                               object: nil
        )
        messageDisplay.fontName = SKFont.lightItalic
        messageDisplay.fontSize = 14.0
        messageDisplay.fontColor = UIColor.red
        messageDisplay.position = CGPoint(x: 200, y: frame.minY + 98)
        addChild(messageDisplay)

        timerDisplay.fontName = SKFont.bold
        timerDisplay.fontSize = 20.0
        timerDisplay.fontColor = UIColor.white
        timerDisplay.position = CGPoint(x: 200, y: frame.minY + 68)
        addChild(timerDisplay)
        pointsDisplay.fontName = SKFont.bold
        pointsDisplay.fontSize = 20.0
        pointsDisplay.fontColor = UIColor(
            red: 0,
            green: 204 / 255,
            blue: 131 / 255,
            alpha: 1.0
        )
        pointsDisplay.position = CGPoint(x: 200, y: frame.minY + 38)
        addChild(pointsDisplay)

        // this runs the game
        KoyakunGameScene.koyaGameState = .generatingKoyakun
        timerSetup()
        let waitAction = SKAction.wait(forDuration: 1.5)
        let generateAction = SKAction.run {
            self.performInitialGeneration()
        }
        self.run(SKAction.sequence([waitAction, generateAction]))

    } // end of didMove to view

    func timerSetup() {
        print("Koyakun timer started")
        let wait = SKAction.wait(forDuration: 1)
        let action = SKAction.run {
            self.remainingTime -= 1
        }
        let timerAction = SKAction.sequence([wait, action])
        self.run(SKAction.repeatForever(timerAction))
        if self.remainingTime == 0 {
            handleGameOver()
        }
    }

    func handleGameOver() {
        gameOver = true
        timerDisplay.removeFromParent()
        pointsDisplay.removeFromParent()
        self.removeAllActions()
        self.removeAllChildren()
        koyakunCatchPoints = points
        let gameOverText = SKLabelNode(fontNamed: SKFont.bold)
        gameOverText.text = "Game Over!"
        gameOverText.fontSize = 34
        gameOverText.color = UIColor(red: 229 / 255, green: 127 / 255, blue: 42 / 255, alpha: 1)
        gameOverText.position = CGPoint(x: self.frame.midX, y: self.frame.midY + 80)
        gameOverText.zPosition = 100
        gameOverText.verticalAlignmentMode = .center
        self.addChild(gameOverText)

        let pointReport = SKLabelNode(fontNamed: SKFont.bold)
        pointReport.text = "You earned \(koyakunCatchPoints) Points"
        pointReport.position = CGPoint(x: frame.midX, y: frame.midY - 10)
        pointReport.fontColor = UIColor(red: 0, green: 204 / 255, blue: 131 / 255, alpha: 1.0)
        addChild(pointReport)

        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            self.viewModel?.completed = true
            self.viewModel?.points = self.points
        }
    }
// swiftlint:disable:next cyclomatic_complexity
    override func update(_ currentTime: TimeInterval) {
        if remainingTime == 0 {
            self.removeAllActions()
            self.removeAllChildren()
            koyakunCatchPoints = points
            gameOver = true
            handleGameOver()
        }
        if remainingTime == 55 {
            let messageDuration = 2.0
            let messageFade = SKAction.fadeOut(withDuration: messageDuration)
            messageDisplay.run(messageFade)
        }
        guard let sceneView = self.view as? ARSKView else {return}
        if let cameraZ = sceneView.session.currentFrame?.camera.transform.columns.3.z {
            if gameOver == false {

                for node in nodes(at: CGPoint.zero) {
                    if let koyakun = node as? Koyakun {
                        guard let anchors = sceneView.session.currentFrame?.anchors else {
                            return
                        }
                        for anchor in anchors {
                            if abs(cameraZ - anchor.transform.columns.3.z) < 0.35 {
                                if let potentialTarget = sceneView.node(for: anchor) {
                                    if koyakun == potentialTarget {
                                        koyakun.removeFromParent()
                                        self.run(SKAction.playSoundFileNamed("pop", waitForCompletion: false))
                                        generateKoyakun()
                                        points += 3
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }

    func performInitialGeneration() {
        KoyakunGameScene.koyaGameState = .generatingKoyakun
        for _ in 1 ... numberOfKoyakun {
            generateKoyakun()
        }
    }

    @objc func generateKoyakun() { // exposed to objc because called in the notification center selector
        guard let sceneView = self.view as? ARSKView else {return}
        if let currentFrame = sceneView.session.currentFrame {
            var translation = matrix_identity_float4x4
            translation.columns.3.x = randomPosition(lowerBound: -3.0, upperBound: 3.0) // -1.5  1.5 later
            translation.columns.3.y = randomPosition(lowerBound: -1.0, upperBound: 2.0) // -1.5  1.5 later
            translation.columns.3.z = randomPosition(lowerBound: -2, upperBound: 2.0) // -2  2 later
            let transform = simd_mul(currentFrame.camera.transform, translation)
            let anchor = ARAnchor(transform: transform)
            sceneView.session.add(anchor: anchor)
        }
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {return}
        let positionInScene = touch.location(in: self)
        let touchedNodes = self.nodes(at: positionInScene)
        if let name = touchedNodes.last?.name {
            if name == "exitButton" {
                // Remove?
                print("exit button tapped")
            }
        }
    }
}

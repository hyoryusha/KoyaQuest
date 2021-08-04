//
//  GorintoGameScene.swift
//  KoyaQuest
//
//  Created by Kevin K Collins on 2021/06/12.
//

import SpriteKit
import SwiftUI
import Combine

class GorintoGameScene: SKScene {
    var viewModel: GorintoChallengeViewModel?
    var points = 0

    private let elementLabel = "movable"
    var selectedNode = SKSpriteNode()

    var checkButton = SKSpriteNode(color: UIColor.orange, size: CGSize(width: 120, height: 28))
    let checkButtonLabel = SKLabelNode(text: "Check")
    let alertMessage = SKLabelNode(text: "You must move all labels into position.")
    let hintMessage = SKLabelNode(text: "Drag and drop the labels into position.")

    var gorinto = SKSpriteNode(imageNamed: "gorinto_line_purple")
    var fireLabel = SKSpriteNode(imageNamed: "fire_label")
    var windLabel = SKSpriteNode(imageNamed: "wind_label")
    var earthLabel = SKSpriteNode(imageNamed: "earth_label")
    var waterLabel = SKSpriteNode(imageNamed: "water_label")
    var spaceLabel = SKSpriteNode(imageNamed: "space_label")
    let labelSize = CGSize(width: 90, height: 28)
    let labelZPos = CGFloat(10)

    var finalPositions: [String: CGFloat] = [:]
    var matches: [String] = []
    var misMatches: [String] = []

 override func didMove(to view: SKView) {
    UIApplication.shared.isIdleTimerDisabled = true
    self.backgroundColor = UIColor.koyaPurple
        ?? UIColor(red: 30 / 255, green: 32 / 255, blue: 53 / 255, alpha: 1.0)

    setupGorinto()
    addChild(gorinto)

    setupHint()
    addChild(hintMessage)
    setupFireLabel()
    addChild(fireLabel)

    setupWaterLabel()
    addChild(waterLabel)

    setupSpaceLabel()
    addChild(spaceLabel)

    setupWindLabel()
    addChild(windLabel)

    setupEarthLabel()
    addChild(earthLabel)

    checkButtonLabel.fontName = SKFont.bold
    checkButtonLabel.fontSize = 20.0
    checkButtonLabel.fontColor = UIColor.white
    checkButtonLabel.position = CGPoint(x: 0, y: -8)
    checkButton.addChild(checkButtonLabel)

    checkButton.position = CGPoint(x: frame.midX, y: frame.minY + 40)
    checkButton.name = "check"
    checkButton.zPosition = 100
    addChild(checkButton)
    }

    func setupGorinto() {
        gorinto.size = CGSize(width: 672, height: 989)
        gorinto.setScale(0.5)
        gorinto.position = CGPoint(x: frame.size.width / 2, y: frame.size.height / 2 - 20)
        gorinto.zPosition = 1
        gorinto.name = "gorinto"
    }

    func setupHint() {
        hintMessage.fontName = SKFont.regular
        hintMessage.fontSize = 16.0
        hintMessage.fontColor = UIColor.white
        hintMessage.position = CGPoint(x: frame.midX, y: frame.minY + 60)
        hintMessage.zPosition = 100
    }

    func setupFireLabel() {
        fireLabel.position = CGPoint(x: frame.size.width / 2, y: frame.size.height - 60)
        fireLabel.size = labelSize
        fireLabel.name = "C"
        fireLabel.zPosition = labelZPos
    }

    func setupWaterLabel() {
        waterLabel.position = CGPoint(x: frame.size.width / 2 - 95, y: frame.size.height - 60)
        waterLabel.size = labelSize
        waterLabel.name = "B"
        waterLabel.zPosition = labelZPos
    }

    func setupSpaceLabel() {
        spaceLabel.position = CGPoint(x: frame.size.width / 2 + 95, y: frame.size.height - 60)
        spaceLabel.size = labelSize
        spaceLabel.name = "E"
        spaceLabel.zPosition = labelZPos
    }

    func setupWindLabel() {
        windLabel.position = CGPoint(x: frame.size.width * 0.33 + 14, y: frame.size.height - 98)
        windLabel.size = labelSize
        windLabel.name = "D"
        windLabel.zPosition = labelZPos
    }

    func setupEarthLabel() {
        earthLabel.position = CGPoint(x: frame.size.width * 0.66 - 14, y: frame.size.height - 98)
        earthLabel.size = labelSize
        earthLabel.name = "A"
        earthLabel.zPosition = labelZPos
    }
// MARK: - COLORIZE
    func colorize(for matches: [String]) {
        let colorize = SKAction.colorize(with: .red, colorBlendFactor: 0.5, duration: 1.5)
        for match in matches {
            let sprite = childNode(withName: match)
            sprite?.run(colorize)
        }
    }

override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    guard let touch = touches.first else {return}

    let positionInScene = touch.location(in: self)
    if checkButton.contains(positionInScene) {
        checkAnswers()
    }

    selectNodeForTouch(touchLocation: positionInScene)
    } // end touches began

    func selectNodeForTouch(touchLocation: CGPoint) {

        let touchedNode = self.atPoint(touchLocation)

        if touchedNode is SKSpriteNode && touchedNode.name != "gorinto" && touchedNode.name != "check" {
            if alertMessage.parent != nil {
                alertMessage.removeFromParent()
            }
            if hintMessage.parent != nil {
                hintMessage.removeFromParent()
            }

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

      if selectedNode.name == elementLabel {
        selectedNode.position = CGPoint(x: position.x + translation.x, y: position.y + translation.y)
      } else {
        let newPosition = CGPoint(
            x: position.x + translation.x,
            y: position.y + translation.y
        )
        selectedNode.position = newPosition
        let minHeight = gorinto.frame.maxY
        if newPosition.y < minHeight {
            finalPositions[selectedNode.name ?? ""] = newPosition.y
        }
      }
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {return}
        let positionInScene = touch.location(in: self)
        let previousPosition = touch.previousLocation(in: self)
        let translation = CGPoint(x: positionInScene.x - previousPosition.x, y: positionInScene.y - previousPosition.y)
        panForTranslation(translation: translation)
    }

    func checkAnswers() {
        if finalPositions.count < 5 {
            // show alert
            if alertMessage.parent != nil {
                alertMessage.removeFromParent()
            }
            setupAlert()
            addChild(alertMessage)

        } else {
           // ready to evaluate
            let keySorted = finalPositions.sorted {
                $0.0 < $1.0
            } // this gives a fixed order array based on alphabetical order of keys
                      let correctSorted = finalPositions.sorted {
                        $0.1 < $1.1
                      } // this gives a fixed order array based on values
                      var matchingIndices = 0
                      let keyNames  = ["A", "B", "C", "D", "E"]

                      var matches: [String] = []
                      for name in keyNames {
                        let correctIndexForName = keySorted.firstIndex(where: { $0.key == name })
                        let returnedIndexForName = correctSorted.firstIndex(where: { $0.key == name })
                          if correctIndexForName! == returnedIndexForName! {
                              matchingIndices += 1
                              matches.append(name)
                          } else {
                            misMatches.append(name)
                          }
                      }
                      switch matchingIndices {
                      case 5:
                          points = 30
                      case 4:
                          points = 20
                      case 3:
                          points = 15
                      case 2:
                          points = 10
                      case 1:
                          points = 5
                      case 0:
                          points = 0
                      default:
                          points = 0
                      }
            displayScore(points: points)
            colorize(for: misMatches)
        }
    }

    func setupAlert() {
        alertMessage.fontName = SKFont.bold
        alertMessage.fontSize = 16.0
        alertMessage.fontColor = UIColor.systemRed
        alertMessage.position = CGPoint(x: frame.midX, y: frame.minY + 56)
        alertMessage.zPosition = 100
    }

    func displayScore(points: Int) {
        let gameOverLabel = SKLabelNode(text: "Game Over")
        gameOverLabel.fontName = SKFont.bold
        gameOverLabel.fontSize = 36.0
        gameOverLabel.fontColor = UIColor(red: 0, green: 204 / 255, blue: 131 / 255, alpha: 1.0)
        gameOverLabel.position = CGPoint(x: frame.midX, y: frame.maxY - 80)
        addChild(gameOverLabel)

        let scoreLabel = SKLabelNode(text: "You earned " + "\(points) points")
        scoreLabel.fontName = SKFont.bold
        scoreLabel.fontSize = 24.0
        scoreLabel.fontColor = UIColor.koyaOrange ?? UIColor.orange
        scoreLabel.position = CGPoint(x: frame.midX, y: frame.maxY - 108)
        addChild(scoreLabel)
        let message = SKLabelNode(text: "Incorrect answers are shaded in red.")
        message.fontName = SKFont.medium
        message.fontSize = 13.0
        message.fontColor = UIColor(.white)
        message.position = CGPoint(x: frame.midX, y: frame.maxY - 128)
        addChild(message)

        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) { [weak self] in
            self?.viewModel?.solved = true
            self?.viewModel?.points = self?.points ?? 0
        }
    }

    func animateLabel(label: SKLabelNode) {
        let scaleUp = SKAction.scale(to: 1.1, duration: 0.5)
        let scaleDown = SKAction.scale(to: 1.0, duration: 0.5)
        let sequence = SKAction.sequence([scaleUp, scaleDown])
        label.run(SKAction.repeatForever(sequence))
    }
}

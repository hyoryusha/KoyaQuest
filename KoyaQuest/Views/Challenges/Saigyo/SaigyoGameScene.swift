//
//  SaigyoGameScene.swift
//  KoyaQuest
//
//  Created by Kevin K Collins on 2021/06/08.
//

import SpriteKit
import GameplayKit
import SwiftUI

enum CardLevel: CGFloat {
  case board = 2
  case moving = 100
  case enlarged = 200
}

class SaigyoGameScene: SKScene {
    var viewModel = SaigyoChallengeViewModel()

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


    let landingZone = SKSpriteNode(imageNamed: "blank card")
    let checkAnswerButton = CheckAnswerButton()
    let proceedToSummaryButton = CheckAnswerButton()
    let successLabel = SKLabelNode(text: "You've made a match!")
    var selectedNode = SKSpriteNode()
    var finalPositions: [String: CGFloat] = [:]
    var attempts = 0
    var buttonText = "CHECK ANSWER"
    var playerChoice = SKSpriteNode()
    var points = 0
    let keepTryingLabel = SKLabelNode(text: "Try again!")
    var keepTryingLabelDisplayed = false
    let gameOverLabel = SKLabelNode(text: "You Completed the Poem!")

    override func didMove(to view: SKView) {
        UIApplication.shared.isIdleTimerDisabled = true
        let background = SKSpriteNode(imageNamed: "saigyo_bg")
        background.size = self.frame.size
        background.zPosition = -1
        background.position = CGPoint(x: frame.size.width / 2, y: frame.size.height / 2)
        addChild(background)

        setUpCards()
        setUpCheckAnswerButton()
    }

    func setUpCards() {
        let cardWidth = CGFloat(frame.size.width * 0.45)
        let cardHeight = CGFloat(cardWidth * 1.5)
        let cardSize = CGSize(width: cardWidth, height: cardHeight)

        landingZone.position = CGPoint(x: size.width * 0.25, y: size.height / 2 + cardHeight * 0.7 )
        landingZone.size = cardSize
        addChild(landingZone)

        let sks77kami = Card(cardType: .sks77kami)
        sks77kami.position = CGPoint(x: (size.width * 0.75), y: size.height / 2 + cardHeight * 0.7 )
        sks77kami.size = cardSize
        sks77kami.name = "77 kami no ku"
        sks77kami.zPosition = 2
        addChild(sks77kami)

        let sks768 = Card(cardType: .sks768)
        sks768.position = CGPoint(x: size.width * 0.25 + 10, y: size.height / 2.8 )
        sks768.size = cardSize
        sks768.name = "768"
        sks768.zPosition = 2
        addChild(sks768)

        let sks77shimo = Card(cardType: .sks77shimo)
        sks77shimo.position = CGPoint(x: size.width * 0.40 + 10, y: size.height / 2.8 - 3 )
        sks77shimo.size = cardSize
        sks77shimo.name = "77 shimo no ku"
        sks77shimo.zPosition = 3
        addChild(sks77shimo)

        let sks942 = Card(cardType: .sks942)
        sks942.position = CGPoint(x: size.width * 0.55 + 10, y: size.height / 2.8 - 6)
        sks942.size = cardSize
        sks942.name = "942"
        sks942.zPosition = 4
        addChild(sks942)

        let sks1040 = Card(cardType: .sks1040)
        sks1040.position = CGPoint(x: size.width * 0.70 + 10, y: size.height / 2.8 - 9)
        sks1040.size = cardSize
        sks1040.name = "1040"
        sks1040.zPosition = 5
        addChild(sks1040)
    }

    func setUpCheckAnswerButton() {
        let checkAnswerLabel = SKLabelNode(text: buttonText)
        checkAnswerLabel.fontName = SKFont.regular
        checkAnswerLabel.fontSize = 20.0
        checkAnswerLabel.fontColor = UIColor.white
        checkAnswerLabel.position = CGPoint(x: 0, y: -6.0)
        checkAnswerButton.position = CGPoint(x: self.frame.midX, y: frame.size.height * 0.10 - 6)
        checkAnswerButton.zPosition = 1000
        checkAnswerButton.addChild(checkAnswerLabel)
        self.addChild(checkAnswerButton)
    }

    func addProceedToSummaryButton() {
        let proceedButtonLabel = SKLabelNode(text: "Got it!")
        proceedButtonLabel.fontName = SKFont.medium
        proceedButtonLabel.fontSize = 20.0
        proceedButtonLabel.fontColor = UIColor.white
        proceedButtonLabel.position = CGPoint(x: 0, y: -6.0)
        proceedToSummaryButton.position = CGPoint(x: self.frame.midX, y: frame.size.height * 0.10 - 6)
        proceedToSummaryButton.zPosition = 1000
        proceedToSummaryButton.addChild(proceedButtonLabel)
        proceedToSummaryButton.name = "proceed button"

        successLabel.fontSize = 18
        successLabel.fontName = SKFont.medium
        successLabel.fontColor = UIColor.green
        successLabel.position = CGPoint(x: frame.midX, y: frame.size.height * 0.14 - 4)
        successLabel.zPosition = 100
        self.addChild(proceedToSummaryButton)
        self.addChild(successLabel)
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {

            guard let touch = touches.first else {return}
            let positionInScene = touch.location(in: self)
            let previousPosition = touch.previousLocation(in: self)
            let translation = CGPoint(
                x: positionInScene.x - previousPosition.x,
                y: positionInScene.y - previousPosition.y
            )
            panForTranslation(translation: translation)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
      for touch in touches {

        let location = touch.location(in: self)
        if let card = atPoint(location) as? Card {
          card.zPosition = CardLevel.moving.rawValue
            card.removeAction(forKey: "drop")
            let scaleUp = SKAction.scale(to: 1.4, duration: 0.25)
            card.run(scaleUp, withKey: "pickup")
            selectNodeForTouch(touchLocation: location)
        }
        if checkAnswerButton.contains(location) {
            checkAnswer()
        }
          if proceedToSummaryButton.contains(location) {
              self.removeAllChildren()
              showSummaryScene(withTransition: .crossFade(withDuration: 0.5))
          }
      }
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
      for touch in touches {
        let location = touch.location(in: self)
        if let card = atPoint(location) as? Card {
          card.zPosition = CardLevel.board.rawValue
          card.removeFromParent()
          addChild(card)
            card.removeAction(forKey: "pickup")
            card.run(SKAction.scale(to: 1.0, duration: 0.25), withKey: "drop")
        }
      }
    }

    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }

 // MARK: - METHODS
  func selectNodeForTouch(touchLocation: CGPoint) {
    // 1
      let touchedNode = self.atPoint(touchLocation)
      if !selectedNode.isEqual(touchedNode) {
            selectedNode.removeAllActions()
            selectedNode.run(SKAction.rotate(toAngle: 0.0, duration: 0.1))
        // swiftlint:disable force_cast
            selectedNode = touchedNode as! SKSpriteNode
        // swiftlint:enable force_cast
      }
  }

    func panForTranslation(translation: CGPoint) {
      let position = selectedNode.position
        if selectedNode.name != "77 kami no ku" { // do not allow kami no ku to move
        let newPosition = CGPoint(x: position.x + translation.x, y: position.y + translation.y)
        selectedNode.position = newPosition
            selectedNode.anchorPoint = CGPoint(x: 0.5, y: 0.5)
            let minHeight = size.height / 2 + 100
            if newPosition.y > minHeight { // the card must be moved above landingZone
                playerChoice = selectedNode
        }
      }
    }

    func checkAnswer() {
        keepTryingLabelDisplayed ? keepTryingLabel.removeFromParent() : nil
        attempts += 1
        // first make sure that one and only one card has been moved into landingZone
        if playerChoice.name != "" { // not empty
            if playerChoice.name == "77 shimo no ku" { // correct answer
                checkAnswerButton.removeFromParent()
                if !viewModel.solved {
                    gameOver()
                }
            } else {
                keepTrying()
            }
        } else {
            print("empty")
        }
    }

    func gameOver() {
        switch attempts {
        case 1:
            points = 30
        case 2:
            points = 20
        case 3:
            points = 10
        case 4:
            points = 5
        default:
            points = 0
        }
        viewModel.solved = true
        viewModel.points = self.points
        pointsEarned = points
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.addProceedToSummaryButton()
        }
    }

    private func showSummaryScene(withTransition transition: SKTransition) {
             let delay = SKAction.wait(forDuration: 1)
             let sceneChange = SKAction.run {
                 let scene = SaigyoSummaryScene(self.$challengeCompleted)
                 scene.viewModel = self.viewModel
               self.view?.presentScene(scene, transition: transition)
             }
             run(.sequence([delay, sceneChange]))
           }

    func keepTrying() {
        keepTryingLabelDisplayed ? keepTryingLabel.removeFromParent() : nil
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { [unowned self] in
        keepTryingLabel.fontSize = 18
        keepTryingLabel.fontName = SKFont.medium
        keepTryingLabel.fontColor = UIColor.orange
        keepTryingLabel.position = CGPoint(x: frame.midX, y: frame.size.height * 0.14 - 4)
        keepTryingLabel.zPosition = 100
            switch attempts {
            case 0:
                keepTryingLabel.text = ""
            case 1:
                keepTryingLabel.text = "Try again!"
            case 2:
                keepTryingLabel.text = "Not yet."
            case 3:
                keepTryingLabel.text = "One more chance (But no points)."
            default:
                keepTryingLabel.text = ""
            }
        addChild(keepTryingLabel)
        keepTryingLabelDisplayed = true
        }
    }
}

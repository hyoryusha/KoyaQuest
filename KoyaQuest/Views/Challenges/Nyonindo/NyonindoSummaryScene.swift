//
//  NyonindoPreviewScene.swift
//  NyonindoChallengeSwiftUI
//
//  Created by Kevin K Collins on 2021/04/22.
//
import SpriteKit
import SwiftUI

class NyonindoSummaryScene: SKScene {
    var viewModel : NyonindoChallengeViewModel?
   // @Binding var viewModel: NyonindoChallengeViewModel
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

    let exitButton = SKSpriteNode(color: SKColor.orange, size: CGSize(width: 258, height: 66))
    let exitButtonLabel = SKLabelNode(text: "Exit")


    override func didMove(to view: SKView) {
        print("did move to summary scene")
        //var background = SKSpriteNode(imageNamed: "nyonindo_challenge_bg")
        let background = SKSpriteNode(imageNamed: "nyonindo_bg")
        background.size = self.frame.size
        background.zPosition = -1
        background.position = CGPoint(x: frame.size.width / 2, y: frame.size.height / 2)
        addChild(background)

        let gate = SKSpriteNode(imageNamed: "daimon_illustration")
        gate.position = CGPoint(x: size.width * 0.5, y: size.height * 0.86)
        addChild(gate)

        let rikishi = SKSpriteNode(imageNamed: "rikishi1")
        rikishi.setScale(0.7)
        addChild(rikishi)
        rikishi.position = CGPoint(x: frame.midX, y: frame.midY + (rikishi.size.height * 0.8))
        rikishi.zPosition = 1000
        addLabels()
        addExitButton()
    }
    func addExitButton() {
        exitButtonLabel.fontName = SKFont.bold
        exitButtonLabel.fontSize = 40.0
        exitButtonLabel.fontColor = UIColor.white
        exitButtonLabel.position = CGPoint(x: 0, y: -12)
        exitButton.addChild(exitButtonLabel)
        exitButton.position = CGPoint(x:self.frame.midX, y:self.frame.midY)
        exitButton.zPosition = 3
        addChild(exitButton)
    }

    func addLabels() {
        let playLabel = SKLabelNode(text: "Game Over")
        playLabel.fontName = SKFont.bold
        playLabel.fontSize = 50.0
        playLabel.fontColor = UIColor.black
        playLabel.position = CGPoint(x: frame.midX, y: frame.height * 0.82)
        addChild(playLabel)
        animateLabel(label: playLabel)
        //let highScoreLabel = SKLabelNode(text: "High Score: " + "\(UserDefaults.standard.integer(forKey: "HighScore"))")
        let highScoreLabel = SKLabelNode(text: "High Score: " + "\(viewModel?.highestScore ?? 0)")
        highScoreLabel.fontName = SKFont.bold
        highScoreLabel.fontSize = 30.0
        highScoreLabel.fontColor = UIColor.black
        highScoreLabel.position = CGPoint(x: frame.midX,  y: size.height * 0.25 )
        addChild(highScoreLabel)
        //let recentScoreLabel = SKLabelNode(text: "Recent Score: " + "\(UserDefaults.standard.integer(forKey: "RecentScore"))")
        let recentScoreLabel = SKLabelNode(text: "Recent Score: " + "\(viewModel?.recentScore ?? 0)")
        recentScoreLabel.fontName = SKFont.bold
        recentScoreLabel.fontSize = 24.0
        recentScoreLabel.fontColor = UIColor.black
        recentScoreLabel.position = CGPoint(x: frame.midX, y: highScoreLabel.position.y - 30 )
        addChild(recentScoreLabel)
    }

    func animateLabel(label: SKLabelNode) {
//        let fadeOut = SKAction.fadeOut(withDuration: 0.5)
//        let fadeIn = SKAction.fadeIn(withDuration: 0.5)
        let scaleUp = SKAction.scale(to: 1.1, duration: 0.5)
        let scaleDown = SKAction.scale(to: 1.0, duration: 0.5)
        //let sequence = SKAction.sequence([fadeOut, fadeIn])
        let sequence = SKAction.sequence([scaleUp, scaleDown])
        label.run(SKAction.repeatForever(sequence))
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {

    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
                for touch in touches {
                let location = touch.location(in: self)
                    if exitButton.contains(location) {
                        print("exit button tapped")
                        //viewModel?.gameOver = true
                        challengeCompleted = true
                    }
                }
            }
}

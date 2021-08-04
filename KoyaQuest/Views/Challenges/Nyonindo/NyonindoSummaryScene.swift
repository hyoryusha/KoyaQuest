//
//  NyonindoPreviewScene.swift
//  NyonindoChallengeSwiftUI
//
//  Created by Kevin K Collins on 2021/04/22.
//
import SpriteKit

class NyonindoSummaryScene: SKScene {
    var viewModel : NyonindoChallengeViewModel?
    
    override func didMove(to view: SKView) {
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
        addChild(rikishi)
        rikishi.position = CGPoint(x: size.width * 0.5, y: size.height / 2 + (rikishi.size.height / 2 ))
        rikishi.zPosition = 1000
        addLabels()
        //addClearScoreButton()
    }
//        func addClearScoreButton() {
//
//            let replayButtonLabel = SKLabelNode(text: "Clear Score")
//            replayButtonLabel.fontName = "AvenirNext-Bold" // AvenirNext-Bold
//            replayButtonLabel.fontSize = 20.0
//            replayButtonLabel.fontColor = UIColor.white
//            replayButtonLabel.position = CGPoint(x: 0, y: -8)
//
//        }
    
    func addLabels() {
        let playLabel = SKLabelNode(text: "Game Over")
        playLabel.fontName = SKFont.bold
        playLabel.fontSize = 50.0
        playLabel.fontColor = UIColor.black
        playLabel.position = CGPoint(x: frame.midX, y: frame.height * 0.82)
        addChild(playLabel)
        animateLabel(label: playLabel)
        let highScoreLabel = SKLabelNode(text: "High Score: " + "\(UserDefaults.standard.integer(forKey: "HighScore"))")
        highScoreLabel.fontName = SKFont.bold
        highScoreLabel.fontSize = 30.0
        highScoreLabel.fontColor = UIColor.black
        highScoreLabel.position = CGPoint(x: frame.midX, y: frame.midY - highScoreLabel.frame.size.height*4)
        addChild(highScoreLabel)
        let recentScoreLabel = SKLabelNode(text: "Recent Score: " + "\(UserDefaults.standard.integer(forKey: "RecentScore"))")
        recentScoreLabel.fontName = SKFont.bold
        recentScoreLabel.fontSize = 30.0
        recentScoreLabel.fontColor = UIColor.black
        recentScoreLabel.position = CGPoint(x: frame.midX, y: frame.midY - highScoreLabel.position.y - recentScoreLabel.frame.size.height*3)
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
                // Loop over all the touches in this event
    }
}

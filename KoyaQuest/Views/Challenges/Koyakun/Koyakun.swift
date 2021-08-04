//
//  Koyakun.swift
//  KoyaQuest2021
//
//  Created by Kevin K Collins on 2021/05/01.
//

import SpriteKit
import GameplayKit

class Koyakun: SKSpriteNode {

    var mainKoyakunSprite = SKSpriteNode()

    func setup() {

        mainKoyakunSprite = SKSpriteNode(imageNamed: "koyakun")
        self.addChild(mainKoyakunSprite)

        let textureAtlas = SKTextureAtlas(named: "koyakun")
        let frames = [
            "sprite_0", "sprite_1", "sprite_2", "sprite_3", "sprite_4", "sprite_5", "sprite_6"
        ].map { textureAtlas.textureNamed($0) }

        let atlasAnimation = SKAction.animate(with: frames, timePerFrame: 1/7, resize: true, restore: false)
        let animationAction = SKAction.repeatForever(atlasAnimation)
        mainKoyakunSprite.run(animationAction)

        let duration = randomNumber(lowerBound: 25, upperBound: 35) // this sets the time each sprite will be visible
        let fade = SKAction.fadeOut(withDuration: TimeInterval(duration))
        let removeKoyakun = SKAction.run {
            NotificationCenter.default.post(name: Notification.Name("KoyakunGenerate"), object: nil)
            self.removeFromParent()
        }
        let appearSequence = SKAction.sequence([fade, removeKoyakun])
        mainKoyakunSprite.run(appearSequence)
    }

}

enum KoyakunGameState: Int {
    case none, generatingKoyakun
}

func randomPosition (lowerBound lower: Float, upperBound upper: Float) -> Float {
    return Float(arc4random()) / Float(UInt32.max) * (lower - upper) + upper
}

func randomNumber (lowerBound lower: Int, upperBound upper: Int) -> Int {
    return Int(arc4random()) / Int(UInt32.max) * (lower - upper) + upper
}

var koyakunCatchGameOver: Bool = false
var koyakunCatchPoints: Int = 0
//var koyakunPracticeRound: Bool = false
// var koyakunIdle: Bool = true

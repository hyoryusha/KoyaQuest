//
//  SaigyoSummaryScene.swift
//  KoyaQuest
//
//  Created by Kevin K Collins on 2021/06/08.
//

import SpriteKit
import GameplayKit
import CoreMotion
import SwiftUI

class SaigyoSummaryScene: SKScene {

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

    let floor = Floor()
    override func didMove(to view: SKView) {
        physicsWorld.contactDelegate = self
        let background = SKSpriteNode(imageNamed: "saigyo_bg")
        // background.size = background.texture!.size()
        background.size = self.size
        background.zPosition = -1
        background.position = CGPoint(x: frame.size.width / 2, y: frame.size.height / 2)

        let poem = SKSpriteNode(imageNamed: "negawaku_text")
        poem.position = CGPoint(x: size.width / 2 - 28, y: frame.midY + 20)
        poem.zPosition = 200
        poem.setScale(1.0)
        addChild(poem)

        let commentary = SKSpriteNode(imageNamed: "negawaku_commentary")
        commentary.position = CGPoint(x: size.width / 2 - 20, y: poem.position.y - poem.size.height)
        commentary.zPosition = 200
        commentary.setScale(1.0)
        addChild(commentary)

        let poet = SKSpriteNode(imageNamed: "saigyo_shadow")
        poet.position = CGPoint(x: size.width * 0.4, y: size.height / 3)
        poet.zPosition = 3
        poet.setScale(1.1)
        addChild(poet)
        addChild(background)
        addChild(floor)

        run(SKAction.repeatForever(
            SKAction.sequence([
                SKAction.run(spawnBlossom),
                SKAction.wait(forDuration: 0.25),
                SKAction.run(spawnPetal),
                SKAction.wait(forDuration: 0.7)
            ])
        ))
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
            self.addExitButton()
        }

    } // end did move

    override func sceneDidLoad() {
        physicsWorld.contactDelegate = self
    }

    func random() -> CGFloat {
        return CGFloat(Float(arc4random()) / Float(0xFFFFFFFF))
    }

    func random(min: CGFloat, max: CGFloat) -> CGFloat {
        return random() * (max - min) + min
    }

    func spawnBlossom() {

        let blossom = SKSpriteNode(imageNamed: "cherry_blossom")

        let randomX = random(min: -50, max: size.width / 2)

        blossom.position = CGPoint(x: randomX, y: size.height - 20)
        blossom.physicsBody = SKPhysicsBody(circleOfRadius: blossom.size.width)
        blossom.physicsBody?.isDynamic = true // 2
        blossom.physicsBody?.categoryBitMask = PhysicsCategory.blossom // 3
        blossom.physicsBody?.contactTestBitMask = PhysicsCategory.floor // 4
        blossom.physicsBody?.collisionBitMask = PhysicsCategory.floor // 5 I changed this to gate from none; again, why?
        blossom.physicsBody?.usesPreciseCollisionDetection = true
        blossom.physicsBody?.linearDamping = 5
        blossom.setScale(0.8)
        blossom.zPosition = 1
        addChild(blossom)

        let angle = CGVector(dx: 120, dy: 0)
        let angularAction = SKAction.applyImpulse(angle, duration: 2.0)
        let randomRotation = random(min: 45, max: 270)
        let actionMove = SKAction.rotate(toAngle: randomRotation, duration: 40.0)
        let actionGroup = SKAction.group([actionMove, angularAction])
        blossom.run(actionGroup)
    }

    func spawnPetal() {
        let petal = SKSpriteNode(imageNamed: "cherry_petal")
        let randomX = random(min: -50, max: size.width / 2)

        petal.position = CGPoint(x: randomX, y: size.height - 20)
        petal.physicsBody = SKPhysicsBody(circleOfRadius: petal.size.width)
        petal.physicsBody?.isDynamic = true // 2
        petal.physicsBody?.categoryBitMask = PhysicsCategory.blossom // 3
        petal.physicsBody?.contactTestBitMask = PhysicsCategory.floor // 4
        petal.physicsBody?.collisionBitMask = PhysicsCategory.floor // 5 changed to gate from none
        petal.physicsBody?.usesPreciseCollisionDetection = true
        petal.physicsBody?.linearDamping = 6
        petal.setScale(0.8)
        petal.zPosition = 1
        addChild(petal)

        let angle = CGVector(dx: 100, dy: 0)
        let angularAction = SKAction.applyImpulse(angle, duration: 2.0)
        let randomRotation = random(min: 45, max: 270)
        let actionMove = SKAction.rotate(toAngle: randomRotation, duration: 30.0)
        let actionGroup = SKAction.group([actionMove, angularAction])
        petal.run(actionGroup)
    }

    func addExitButton() {
        exitButtonLabel.fontName = SKFont.bold
        exitButtonLabel.fontSize = 40.0
        exitButtonLabel.fontColor = UIColor.white
        exitButtonLabel.position = CGPoint(x: 0, y: -12)
        exitButton.addChild(exitButtonLabel)
        exitButton.position = CGPoint(x: self.frame.midX, y: self.frame.size.height * 0.12)
        exitButton.zPosition = 5
        let fadeInAction = SKAction.fadeIn(withDuration: 1.0)
        addChild(exitButton)
        exitButton.run(fadeInAction)
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            if exitButton.contains(location) {
                print("exit button tapped")
                challengeCompleted = true
            }
        }
    }
}

extension SaigyoSummaryScene: SKPhysicsContactDelegate {
    override func update(_ currentTime: TimeInterval) {
    }

    func didBegin(_ contact: SKPhysicsContact) {
        if (contact.bodyA.categoryBitMask == PhysicsCategory.blossom)
            && (contact.bodyB.categoryBitMask == PhysicsCategory.floor) {
            contact.bodyA.node?.removeFromParent()
        } else if (contact.bodyA.categoryBitMask == PhysicsCategory.floor)
                    && (contact.bodyB.categoryBitMask == PhysicsCategory.blossom) {
            contact.bodyB.node?.removeFromParent()
        }
    }
}

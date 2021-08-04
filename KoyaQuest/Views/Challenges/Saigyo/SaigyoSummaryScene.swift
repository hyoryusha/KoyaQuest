//
//  SaigyoSummaryScene.swift
//  KoyaQuest
//
//  Created by Kevin K Collins on 2021/06/08.
//

import SpriteKit
import GameplayKit
import CoreMotion

class SaigyoSummaryScene: SKScene {
    var viewModel: SaigyoChallengeViewModel?

    let floor = Floor()
    override func didMove(to view: SKView) {
        physicsWorld.contactDelegate = self
        let background = SKSpriteNode(imageNamed: "saigyo_bg")
        // background.size = background.texture!.size()
        background.size = self.size
        background.zPosition = -1
        background.position = CGPoint(x: frame.size.width / 2, y: frame.size.height / 2)

        let commentary = SKSpriteNode(imageNamed: "negawaku_commentary")
        commentary.position = CGPoint(x: size.width / 2 - 20, y: size.height * 0.25 - 10)
        commentary.zPosition = 200
        commentary.setScale(1.0)
        addChild(commentary)

        let poem = SKSpriteNode(imageNamed: "negawaku_text")
        poem.position = CGPoint(x: size.width / 2 - 28, y: size.height * 0.50)
        poem.zPosition = 200
        poem.setScale(1.0)
        addChild(poem)

        let poet = SKSpriteNode(imageNamed: "saigyo_shadow")
        poet.position = CGPoint(x: size.width * 0.4, y: size.height / 3)
        poet.zPosition = 200
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
    } // end didmove

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

      // Create sprite
      let blossom = SKSpriteNode(imageNamed: "cherry_blossom")

      // Determine where to spawn the blossom
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
      // Create sprite
        let petal = SKSpriteNode(imageNamed: "cherry_petal")
          // Determine where to spawn the blossom
        let randomX = random(min: -50, max: size.width / 2)

        petal.position = CGPoint(x: randomX, y: size.height - 20)
        petal.physicsBody = SKPhysicsBody(circleOfRadius: petal.size.width)
        petal.physicsBody?.isDynamic = true // 2
        petal.physicsBody?.categoryBitMask = PhysicsCategory.blossom // 3
        petal.physicsBody?.contactTestBitMask = PhysicsCategory.floor // 4
        petal.physicsBody?.collisionBitMask = PhysicsCategory.floor // 5 I changed this to gate from none; again, why?
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

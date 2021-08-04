//
//  Floor.swift
//  KoyaQuest2021
//
//  Created by Kevin K Collins on 2021/04/16.
//

import Foundation
import SpriteKit

class Floor: SKNode {

    override init() {
        super.init()

        self.position = CGPoint(x: 0, y: -UIScreen.main.bounds.height / 2)
        self.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: UIScreen.main.bounds.width * 2, height: 20))
        self.physicsBody?.isDynamic = false
        self.physicsBody?.categoryBitMask = PhysicsCategory.floor
        self.physicsBody?.contactTestBitMask = PhysicsCategory.blossom // 4
        self.physicsBody?.collisionBitMask = PhysicsCategory.blossom // 5

    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

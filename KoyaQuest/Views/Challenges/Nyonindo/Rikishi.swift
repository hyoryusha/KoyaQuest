//
//  Rikishi.swift
//  KoyaQuest
//
//  Created by Kevin K Collins on 2021/06/10.
//

import Foundation
import SpriteKit

class Rikishi: SKSpriteNode {

    override init(texture: SKTexture!, color: UIColor, size: CGSize) {
        let texture = SKTexture(imageNamed: "rikishi2")
        super.init(texture: texture, color: UIColor.clear, size: texture.size())
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func move(touchLocation: CGPoint) {
        if self.calculateAccumulatedFrame().contains(touchLocation) {
            self.position.x = touchLocation.x
        }
    }
}

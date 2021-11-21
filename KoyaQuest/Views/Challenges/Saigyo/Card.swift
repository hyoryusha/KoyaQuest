//
//  Card.swift
//  KoyaQuest
//
//  Created by Kevin K Collins on 2021/06/08.
//

import SpriteKit

enum CardType: Int {
    case sks77kami,
         sks77shimo,
         sks768,
         sks942,
         sks1040
}

class Card: SKSpriteNode {
    let cardType: CardType
    let frontTexture: SKTexture
    let backTexture: SKTexture

    required init?(coder aDecoder: NSCoder) {
        fatalError("NSCoding not supported")
    }

    init(cardType: CardType) {
        self.cardType = cardType
        backTexture = SKTexture(imageNamed: "poem card back texture")
        switch cardType {
        case .sks77kami:
            frontTexture = SKTexture(imageNamed: "SKS 77 kami no ku")
        case .sks77shimo:
            frontTexture = SKTexture(imageNamed: "SKS 77 shimo no ku")
        case .sks768:
            frontTexture = SKTexture(imageNamed: "SKS 768 shimo no ku")
        case .sks942:
            frontTexture = SKTexture(imageNamed: "SKS 942 shimo no ku")
        case .sks1040:
            frontTexture = SKTexture(imageNamed: "SKS 1040 shimo no ku")
        }
        super.init(texture: frontTexture, color: .clear, size: frontTexture.size())
    }
}

//
//  Tiles.swift
//  KoyaQuest
//
//  Created by Kevin K Collins on 2021/06/12.
//

import SpriteKit

enum TileType: Int {
    case temples, choishi, gorinto, lotusPetals,
         haka, meals, templesCount, choishiCount,
         gorintoCount, lotusPetalsCount, hakaCount, mealsCount
}

class Tile: SKSpriteNode {
    let tileType: TileType
    let faceTexture: SKTexture
    let backTexture: SKTexture
    let setID: Int
    let zPos = CGFloat(1.0)
    let isText: Bool
    var faceUp = true

    required init?(coder aDecoder: NSCoder) {
        fatalError("NSCoding not supported")
    }
    // swiftlint:disable function_body_length
    init(tileType: TileType) {
        self.tileType = tileType

        switch tileType {
        case .choishi:
            faceTexture = SKTexture(imageNamed: "choishiText")
            backTexture = SKTexture(imageNamed: "lotus")
            setID = 4
            isText = true
        case .choishiCount:
            faceTexture = SKTexture(imageNamed: "choishiCount")
            backTexture = SKTexture(imageNamed: "lotus")
            setID = 4
            isText = false
        case .temples:
            faceTexture = SKTexture(imageNamed: "templeText")
            backTexture = SKTexture(imageNamed: "lotus")
            setID = 1
            isText = true
        case .templesCount:
            faceTexture = SKTexture(imageNamed: "templeCount")
            backTexture = SKTexture(imageNamed: "lotus")
            setID = 1
            isText = false
        case .gorinto:
            faceTexture = SKTexture(imageNamed: "gorintoText")
            backTexture = SKTexture(imageNamed: "lotus")
            setID = 3
            isText = true
        case .gorintoCount:
            faceTexture = SKTexture(imageNamed: "gorintoCount")
            backTexture = SKTexture(imageNamed: "lotus")
            setID = 3
            isText = false
        case .lotusPetals:
            faceTexture = SKTexture(imageNamed: "lotuspetalText")
            backTexture = SKTexture(imageNamed: "lotus")
            setID = 6
            isText = true
        case .lotusPetalsCount:
            faceTexture = SKTexture(imageNamed: "lotuspetalCount")
            backTexture = SKTexture(imageNamed: "lotus")
            setID = 6
            isText = false
        case .haka:
            faceTexture = SKTexture(imageNamed: "hakaText")
            backTexture = SKTexture(imageNamed: "lotus")
            setID = 2
            isText = true
        case .hakaCount:
            faceTexture = SKTexture(imageNamed: "hakaCount")
            backTexture = SKTexture(imageNamed: "lotus")
            setID = 2
            isText = false
        case .meals:
            faceTexture = SKTexture(imageNamed: "mealText")
            backTexture = SKTexture(imageNamed: "lotus")
            setID = 5
            isText = true
        case .mealsCount:
            faceTexture = SKTexture(imageNamed: "mealCount")
            backTexture = SKTexture(imageNamed: "lotus")
            setID = 5
            isText = false
        }
        super.init(texture: backTexture, color: .clear, size: backTexture.size())
    }
    // swiftlint:enable function_body_length
    func flip() {
        let sound = SKAction.playSoundFileNamed("flip_sound", waitForCompletion: false)
        let firstHalfFlip = SKAction.scaleX(to: 0.0, duration: 0.4)
        let secondHalfFlip = SKAction.scaleX(to: 1.0, duration: 0.4)
        setScale(1.0)
        if faceUp {
            run(firstHalfFlip, completion: {
                self.texture = self.faceTexture

                self.run(secondHalfFlip)
                self.run(sound)
            })
        } else {
            run(firstHalfFlip, completion: {
                self.texture = self.backTexture
                self.run(secondHalfFlip)
            })
        }
        faceUp = !faceUp
    }
}

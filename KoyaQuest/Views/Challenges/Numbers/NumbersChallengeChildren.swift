//
//  NumbersChallengeChildren.swift
//  KoyaQuest
//
//  Created by Kevin K Collins on 2021/06/12.
//

import SwiftUI
import SpriteKit

class NumbersChallengeChildren {

    static let backTileUL = Tile(tileType: .temples)
    static let backTileUC = Tile(tileType: .choishiCount)
    static let backTileUR = Tile(tileType: .meals)

    static let backTile2L = Tile(tileType: .gorintoCount)
    static let backTile2C = Tile(tileType: .mealsCount)
    static let backTile2R = Tile(tileType: .hakaCount)

    static let backTile3L = Tile(tileType: .haka)
    static let backTile3C = Tile(tileType: .templesCount)
    static let backTile3R = Tile(tileType: .gorinto)

    static let backTile4L = Tile(tileType: .lotusPetalsCount)
    static let backTile4C = Tile(tileType: .lotusPetals)
    static let backTile4R = Tile(tileType: .choishi)
// swiftlint:disable:next function_body_length
    static func setupBackTiles(scene: SKScene, tileSize: CGSize, positions: [CGPoint]) {
        backTileUL.size = tileSize
        backTileUL.alpha = 0.8
        backTileUL.position = positions[0]
        backTileUL.name = "UL"
        scene.addChild(backTileUL)

        backTileUC.size = tileSize
        backTileUC.alpha = 0.8
        backTileUC.position = positions[1]
        backTileUC.name = "UC"
        scene.addChild(backTileUC)

        backTileUR.size = tileSize
        backTileUR.alpha = 0.8
        backTileUR.position = positions[2]
        backTileUR.name = "UR"
        scene.addChild(backTileUR)

        backTile2L.size = tileSize
        backTile2L.alpha = 0.8
        backTile2L.position = positions[3]
        backTile2L.name = "2L"
        scene.addChild(backTile2L)

        backTile2C.size = tileSize
        backTile2C.alpha = 0.8
        backTile2C.position = positions[4]
        backTile2C.name = "2C"
        scene.addChild(backTile2C)

        backTile2R.size = tileSize
        backTile2R.alpha = 0.8
        backTile2R.position = positions[5]
        backTile2R.name = "2R"
        scene.addChild(backTile2R)

        backTile3L.size = tileSize
        backTile3L.alpha = 0.8
        backTile3L.position = positions[6]
        backTile3L.name = "3L"
        scene.addChild(backTile3L)

        backTile3C.size = tileSize
        backTile3C.alpha = 0.8
        backTile3C.position = positions[7]
        backTile3C.name = "3C"
        scene.addChild(backTile3C)

        backTile3R.size = tileSize
        backTile3R.alpha = 0.8
        backTile3R.position = positions[8]
        backTile3R.name = "3R"
        scene.addChild(backTile3R)

        backTile4L.size = tileSize
        backTile4L.alpha = 0.8
        backTile4L.position = positions[9]
        backTile4L.name = "4L"
        scene.addChild(backTile4L)

        backTile4C.size = tileSize
        backTile4C.alpha = 0.8
        backTile4C.position = positions[10]
        backTile4C.name = "4C"
        scene.addChild(backTile4C)

        backTile4R.size = tileSize
        backTile4R.alpha = 0.8
        backTile4R.position = positions[11]
        backTile4R.name = "4R"
        scene.addChild(backTile4R)
    }
    // swiftlint:disable:next function_body_length
    static func setUpRowPositions(
        frame: CGRect,
        tileSize: CGSize) -> [CGPoint] {

            let upperRowLPosition = CGPoint(
                x: frame.midX - tileSize.width,
                y: frame.size.height * 0.45 + tileSize.width * 2)
            let upperRowCPosition = CGPoint(
                x: frame.midX,
                y: frame.size.height * 0.45 + tileSize.width*2)
            let upperRowRPosition = CGPoint(
                x: frame.midX + tileSize.width,
                y: frame.size.height * 0.45 + tileSize.width * 2)

            let row2LPosition = CGPoint(
                x: frame.midX - tileSize.width,
                y: frame.size.height * 0.45 + tileSize.width)
            let row2CPosition = CGPoint(
                x: frame.midX,
                y: frame.size.height * 0.45 + tileSize.width)
            let row2RPosition = CGPoint(
                x: frame.midX + tileSize.width,
                y: frame.size.height * 0.45 + tileSize.width)

            let row3LPosition = CGPoint(
                x: frame.midX - tileSize.width,
                y: frame.size.height * 0.45 )
            let row3CPosition = CGPoint(
                x: frame.midX,
                y: frame.size.height * 0.45 )
            let row3RPosition = CGPoint(
                x: frame.midX + tileSize.width,
                y: frame.size.height * 0.45 )

            let row4LPosition = CGPoint(
                x: frame.midX - tileSize.width,
                y: frame.size.height * 0.45 - tileSize.width )
            let row4CPosition = CGPoint(
                x: frame.midX,
                y: frame.size.height * 0.45 - tileSize.width)
            let row4RPosition = CGPoint(
                x: frame.midX + tileSize.width,
                y: frame.size.height * 0.45 - tileSize.width )

            var positions: [CGPoint] = []
            positions.append(upperRowLPosition)
            positions.append(upperRowCPosition)
            positions.append(upperRowRPosition)

            positions.append(row2LPosition)
            positions.append(row2CPosition)
            positions.append(row2RPosition)

            positions.append(row3LPosition)
            positions.append(row3CPosition)
            positions.append(row3RPosition)

            positions.append(row4LPosition)
            positions.append(row4CPosition)
            positions.append(row4RPosition)
            return positions
        }
}

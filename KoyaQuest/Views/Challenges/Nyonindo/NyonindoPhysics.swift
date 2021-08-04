//
//  NyonindoPhysics.swift
//  KoyaQuest
//
//  Created by Kevin K Collins on 2021/06/11.
//

import Foundation

struct NyonindoPhysicsCategory {
    static let none: UInt32 = 0x00000001 << 0 //  1
    static let oni: UInt32 = 0x00000001 << 1  // 2
    static let pilgrim: UInt32 = 0x00000001 << 2  // 4
    static let gate: UInt32 = 0x00000001 << 4   // 8 (i think??)
    static let rikishi: UInt32 = 0x00000001 << 3   // 8 (i think??)
    static let all: UInt32 = UInt32.max
}

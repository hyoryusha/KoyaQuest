//
//  PhysicsCategory.swift
//  KoyaQuest
//
//  Created by Kevin K Collins on 2021/05/30.
//

import Foundation

struct PhysicsCategory {
    static let none     : UInt32 = 0x00000001 << 0 //  1
    static let blossom  : UInt32 = 0x00000001 << 1  // 2
    static let floor    : UInt32 = 0x00000001 << 4   // 8 (i think??)
    static let all      : UInt32 = UInt32.max
}

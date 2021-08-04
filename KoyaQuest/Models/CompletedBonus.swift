//
//  CompletedBonuses.swift
//  KoyaQuest
//
//  Created by Kevin K Collins on 2021/06/17.
//

import Foundation

final class CompletedBonus: Identifiable, Codable, Equatable {

    static func == (lhs: CompletedBonus, rhs: CompletedBonus) -> Bool {
        return lhs.id == rhs.id && lhs.points == rhs.points
    }

    var id: Int
    var points: Int

    init(id: Int, points: Int) {
        self.id = id
        self.points = points
    }
}

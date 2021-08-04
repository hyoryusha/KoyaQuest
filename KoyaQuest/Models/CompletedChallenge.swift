//
//  CompletedChallenge.swift
//  KoyaQuest
//
//  Created by Kevin K Collins on 2021/06/04.
//

import Foundation

final class CompletedChallenge: Identifiable, Codable, Equatable {

    static func == (lhs: CompletedChallenge, rhs: CompletedChallenge) -> Bool {
        return lhs.challenge == rhs.challenge && lhs.points == rhs.points
    }

    var id = UUID()
    var challenge: String
    var points: Int

    init(challenge: String, points: Int) {
        self.challenge = challenge
        self.points = points
    }
}

//
//  LocalRating.swift
//  KoyaQuest
//
//  Created by Kevin K Collins on 2021/06/04.
//

import Foundation

final class LocalRating: Identifiable, Codable, Equatable {

    static func == (lhs: LocalRating, rhs: LocalRating) -> Bool {
        return lhs.landmark == rhs.landmark && lhs.stars == rhs.stars
    }

    var id = UUID()
    var landmark: String
    var stars: Int

    init(landmark: String, stars: Int) {
        self.landmark = landmark
        self.stars = stars
    }
}

//
//  MizumukeChallengeViewModel.swift
//  KoyaQuest
//
//  Created by Kevin K Collins on 2021/06/12.
//

import SwiftUI
import UIKit

class MizumukeChallengeViewModel: ObservableObject {
    @Published var solved: Bool = false
    @Published var attempts: Int = 0
    @Published var points: Int = 0

    var summaryString: String {
        attempts < 2 ? "Excellent!" : "You got it in\n\(attempts) tries."
    }

    var feedbackString: String {
        switch attempts {
        case 1:
            return "That's not it."
        case 2:
            return "Keep trying."
        case 3:
            return "Try again."
        case 4:
            return "Still not there."
        case 5:
            return "Look carefully."
        case 6...:
            return "You're playing for pride now. (Don't give up.)"
        default:
            return ""
        }
    }

    let maxPoints = 20
    var leftCol = 4
    var middleCol = 4
    var rightCol = 4

    func check(columns: [Int]) {
    attempts += 1
        if columns == [1, 2, 0] {
        solved = true
            switch attempts {
            case 1:
                points = maxPoints
            case 2:
                points = maxPoints - 5
            case 3:
                points = maxPoints - 10
            case 4:
                points = maxPoints - 15
            case 5...:
                points = 0
            default:
                points = maxPoints
            }
        }
    }
}

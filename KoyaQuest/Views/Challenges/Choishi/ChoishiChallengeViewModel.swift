//
//  ChoishiGameViewModel.swift
//  KoyaQuest
//
//  Created by Kevin K Collins on 2021/06/19.
//

import SwiftUI

class ChoishiChallengeViewModel: ObservableObject {
    @Published var numbers: [Int] = Array(1...36)
    @Published var gameOver: Bool = false
    @Published var points: Int = 0
    @Published var hintUsed: Bool = false
    @Published var challengeCompleted: Bool = false

    var success: Bool {
        points > 0 ? true : false
    }

    func check(selection: Int) {
        self.gameOver = true
        if selection == 10 {
            if hintUsed {
                self.points = 10
            } else {
                self.points = 20
            }
        } else {
            self.points = 0
        }
    }
}

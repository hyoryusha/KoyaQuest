//
//  GorintoChallengeViewModel.swift
//  KoyaQuest
//
//  Created by Kevin K Collins on 2021/06/12.
//

import SwiftUI

class GorintoChallengeViewModel: ObservableObject {
    @Published var solved: Bool = false
    @Published var points: Int = 0
    @Published var isShowingFeedback = false

    func check(points: Int) {
        self.solved = true
        self.points = points
    }
}

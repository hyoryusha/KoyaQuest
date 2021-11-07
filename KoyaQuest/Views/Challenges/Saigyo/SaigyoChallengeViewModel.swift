//
//  SaigyoChallengeViewModel.swift
//  KoyaQuest
//
//  Created by Kevin K Collins on 2021/06/08.
//

import SwiftUI

class SaigyoChallengeViewModel: ObservableObject {
    @Published var solved: Bool = false
    @Published var points: Int = 0
    @Published var showSummaryScene: Bool = false
    @Published var challengeCompleted: Bool = false

    var statusText: String {
        solved  ? "You completed the poem!" : "Keep trying until you complete the poem!"
    }

    var statusTextColor: Color {
        solved ? Color("SuccessColor") : .white
    }
}

//
//  ShogunsChallengeViewModel.swift
//  KoyaQuest
//
//  Created by Kevin K Collins on 2021/06/11.
//

import SwiftUI

class ShogunsChallengeViewModel: ObservableObject {
    @Published var solved: Bool = false
    @Published var points: Int = 0
    @Published var matches: Int = 0

    var statusText: String {
        solved  ? "You completed the poem!" : ""
    }

    var statusTextColor: Color {
        solved ? .koyaGreen : .white
    }
}

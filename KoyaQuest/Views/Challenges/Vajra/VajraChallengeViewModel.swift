//
//  VajraChallengeViewModel.swift
//  KoyaQuest
//
//  Created by Kevin K Collins on 2021/06/06.
//

import SwiftUI

final class VajraChallengeViewModel: ObservableObject {
    @Published var found: Bool = false
    @Published var zapped: Bool = false
    @Published var distance: Double = 1000.0
    @Published var isShowingModal = false

    var statusText: String {
        found  ? "You found it!" : "Keep searching..."
    }

    var proximity: String {
        "You are \(distance) meters away."
    }

    var statusTextColor: Color {
        found ? .green : .red
    }
}

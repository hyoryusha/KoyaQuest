//
//  KukaiChallengeViewModel.swift
//  KoyaQuest
//
//  Created by Kevin K Collins on 2021/06/10.
//

import SwiftUI

final class KukaiChallengeViewModel: ObservableObject {
    @Published var foundImage = ""
    @Published var success = false

    var statusText: String {
        foundImage.isEmpty ? "Keep searching..." : "You found \(foundImage)"
    }

    var statusTextColor: Color {
        foundImage.isEmpty ? .red : .green
    }
}

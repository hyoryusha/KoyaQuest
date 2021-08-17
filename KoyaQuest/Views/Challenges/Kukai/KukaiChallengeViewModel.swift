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
    @Published var secondsLeft = 10 // 6 min limit before alert
    @Published var showingAlert = false

    var statusText: String {
        foundImage.isEmpty ? "Keep searching..." : "You found \(foundImage)"
    }

    var statusTextColor: Color {
        foundImage.isEmpty ? .red : .green
    }
    var timer = Timer()

    func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true , block: { timer in
            if self.secondsLeft == 0 {
                self.secondsLeft = 0
                self.timer.invalidate()
                self.showingAlert = true
            }
            self.secondsLeft -= 1
        })
    }
    func stopTimer() {
        self.timer.invalidate()
    }
}

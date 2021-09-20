//
//  KenshinChallengeViewModel.swift
//  KoyaQuest2021
//
//  Created by Kevin K Collins on 2021/05/03.
//

import SwiftUI

final class KenshinChallengeViewModel: ObservableObject {
    @Published var didFindGhost = false
    @Published var didConcludeVideo = false
    @Published var didExitChallenge = false
    @Published var success = false
    @Published var instructions: String = ""
    @Published var scannedCode = ""
    @Published var foundLocation = "Keep searching..."
    @Published var foundTakeda = false
    @Published var alertItem: KenshinScannerAlertItem?

    func setSuccess() {
        self.success = true
        print("Set success to true")
    }

    var scannerStatusText: String {
        scannedCode.isEmpty ? "Not yet scanned" : scannedCode
    }

    var scannerStatusTextColor: Color {
        var color: Color = .koyaGreen
        switch foundLocation {
        case "": color = .red
        case "QR-Code does not belong to Mt. Koya": color = .red
        case "Unrecognized QR Code": color = .red
        default: color = .koyaGreen
        }
        return color
    }

    var statusText: String {
        didFindGhost ? "You found the Ghost" : "Keep searching..."
    }

    var statusTextColor: Color {
        didFindGhost ? .koyaGreen : .red
    }
}

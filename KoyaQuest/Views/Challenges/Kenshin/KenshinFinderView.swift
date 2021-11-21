//
//  KenshinFinderView.swift
//  KoyaQuest2021
//
//  Created by Kevin K Collins on 2021/05/03.
//

import SwiftUI

struct KenshinFinderView: UIViewControllerRepresentable {
    @Binding var didFindGhost: Bool
    @Binding var instructions: String
    @Binding var didCompleteVideo: Bool

    func makeUIViewController(context: Context) -> KenshinFinderVC {
        KenshinFinderVC(kenshinFinderDelegate: context.coordinator)
    }

    func updateUIViewController(_ uiViewController: KenshinFinderVC, context: Context) {
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(kenshinFinderView: self)
    }

    final class Coordinator: NSObject, KenshinFinderVCDelegate {

        private let kenshinFinderView: KenshinFinderView
        init(kenshinFinderView: KenshinFinderView) {
            self.kenshinFinderView = kenshinFinderView
        }

        // MARK: - DELEGATE METHODS
        func didFindGhost() {
            kenshinFinderView.didFindGhost = true
        }

        func updateInstructions(instructions: String) {
            kenshinFinderView.instructions = instructions
        }

        func videoCompleted() {
            kenshinFinderView.didCompleteVideo = true
        }
    }
}

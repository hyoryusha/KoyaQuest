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
   // @Binding var didExitChallenge: Bool

    func makeUIViewController(context: Context) -> KenshinFinderVC {
        KenshinFinderVC(kenshinFinderDelegate: context.coordinator)
    }

    func updateUIViewController(_ uiViewController: KenshinFinderVC, context: Context) {
//        if didExitChallenge == true { // this may be redundant as avPlayer.pause() is called on viewWillDisappear
//            //uiViewController.stopVideo()
//        }
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

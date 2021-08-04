//
//  VajraFinderView.swift
//  KoyaQuest
//
//  Created by Kevin K Collins on 2021/06/06.
//

import SwiftUI

struct VajraFinderView: UIViewControllerRepresentable {

    @ObservedObject var viewModel: VajraChallengeViewModel
    @Binding var found: Bool

    func makeUIViewController(context: Context) -> VajraFinderVC {
        let view = VajraFinderVC()
        view.viewModel = viewModel
        return view
    }

    func updateUIViewController(_ uiViewController: VajraFinderVC, context: Context) {
        uiViewController.viewModel = self.viewModel
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(vajraFinderView: self)
    }

    final class Coordinator: NSObject, VajraFinderVCDelegate {

        private let vajraFinderView: VajraFinderView

        init(vajraFinderView: VajraFinderView) {
            self.vajraFinderView = vajraFinderView
        }
    }
}

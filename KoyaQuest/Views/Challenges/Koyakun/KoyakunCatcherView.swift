//
//  KoyakunCatcherView.swift
//  KoyaQuest2021
//
//  Created by Kevin K Collins on 2021/05/01.
//

import SwiftUI

struct KoyakunCatcherView: UIViewControllerRepresentable {

    @ObservedObject var viewModel: KoyakunChallengeViewModel
    @Binding var completed: Bool

    func makeUIViewController(context: Context) -> KoyakunCatcherVC {
        let view = KoyakunCatcherVC()
        view.viewModel = viewModel
        return view
    }

    func updateUIViewController(_ uiViewController: KoyakunCatcherVC, context: Context) {
        uiViewController.viewModel = self.viewModel
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(koyakunCatcherView: self)
    }

    final class Coordinator: NSObject, KoyakunCatcherVCDelegate {
        private let koyakunCatcherView: KoyakunCatcherView
        init(koyakunCatcherView: KoyakunCatcherView) {
            self.koyakunCatcherView = koyakunCatcherView
        }
    }
}

//
//  KukaiFinderView.swift
//  KoyaQuest
//
//  Created by Kevin K Collins on 2021/06/10.
//

import SwiftUI

struct KukaiFinderView: UIViewControllerRepresentable {

    @Binding var foundImage: String
    @Binding var success: Bool

    func makeUIViewController(context: Context) -> KukaiFinderVC {
        KukaiFinderVC(kukaiFinderDelegate: context.coordinator)
    }

    func updateUIViewController(_ uiViewController: KukaiFinderVC, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(kukaiFinderView: self)
    }

    final class Coordinator: NSObject, KukaiFinderVCDelegate {

        private let kukaiFinderView: KukaiFinderView

        init(kukaiFinderView: KukaiFinderView) {
            self.kukaiFinderView = kukaiFinderView
        }

        func didFind(foundImage: String) {
            kukaiFinderView.foundImage = foundImage
            kukaiFinderView.success = true
            print(foundImage)
        }
    }
}

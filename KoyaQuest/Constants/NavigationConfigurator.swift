//
//  NavigationConfigurator.swift
//  KoyaQuest
//
//  Created by Kevin K Collins on 2021/07/08.
//
import SwiftUI

struct NavigationConfigurator: UIViewControllerRepresentable {
    var configure: (UINavigationController) -> Void = { _ in }

    func makeUIViewController(
        context: UIViewControllerRepresentableContext<NavigationConfigurator>) -> UIViewController {
        UIViewController()
    }
    func updateUIViewController(_ uiViewController: UIViewController,
                                context: UIViewControllerRepresentableContext<NavigationConfigurator>) {
        if let navc = uiViewController.navigationController {
            self.configure(navc)
        }
    }
}

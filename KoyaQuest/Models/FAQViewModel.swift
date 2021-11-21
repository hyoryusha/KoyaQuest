//
//  FAQViewModel.swift
//  KoyaQuest
//
//  Created by Kevin K Collins on 2021/07/24.
//

import SwiftUI

final class FAQViewModel: ObservableObject {
    @Published var faq: [FAQ] = []
    @Published var alertItem: AlertItem?
    @Published var isLoading = false

    func getFAQ() {
        isLoading = true
        NetworkManager.shared.getFAQ { [self] result in
            DispatchQueue.main.async {
                isLoading = false
                switch result {
                case .success(let faq): self.faq = faq
                case .failure(let error):
                    print(error.localizedDescription)
                    // not using error messages because local json is used when network fails
                    switch error {
                    case .invalidData:
                        alertItem = AlertContext.invalidData
                    case .invalidURL:
                        alertItem = AlertContext.invalidURL
                    case .invalidResponse:
                        alertItem = AlertContext.invalidResponse
                    case .unableToComplete:
                        alertItem = AlertContext.unableToComplete
                    case .invalidSomething:
                        alertItem = AlertContext.invalidSomething
                    }
                    // if the network call fails, use local info
                    self.faq = FAQ.allFAQ
                }
            }
        }
    }
}

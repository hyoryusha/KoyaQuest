//
//  AboutGameViewModel.swift
//  KoyaQuest
//
//  Created by Kevin K Collins on 2021/06/04.
//
import SwiftUI

final class AboutGameViewModel: ObservableObject {
    @Published var information: [Information] = []
    @Published var alertItem: AlertItem?
    @Published var isLoading = false

    func getInfo() {
        isLoading = true
        NetworkManager.shared.getInfo { [self] result in
            DispatchQueue.main.async {
                isLoading = false
                switch result {
                case .success(let information): self.information = information
                case .failure(let error):
                    print(error.localizedDescription)
                    // not using error messages because local json is used when network fails
//                    switch error {
//                    case .invalidData:
//                        alertItem = AlertContext.invalidData
//                    case .invalidURL:
//                        alertItem = AlertContext.invalidURL
//                    case .invalidResponse:
//                        alertItem = AlertContext.invalidResponse
//                    case .unableToComplete:
//                        alertItem = AlertContext.unableToComplete
//                    case .invalidSomething:
//                        alertItem = AlertContext.invalidSomething
//                    }
                    // if the network call fails, use local info
                    self.information = Information.allInfo
                }
            }
        }
    }
}

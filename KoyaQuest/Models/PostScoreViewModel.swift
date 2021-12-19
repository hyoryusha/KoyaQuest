//
//  PostScoreViewModel.swift
//  KoyaQuest
//
//  Created by Kevin K Collins on 2021/07/15.
//

import SwiftUI
import CoreData
import CloudKit

class PostScoreViewModel: ObservableObject {
    @Published var alertItem: AlertItem?
    @Published var alertActionItem: AlertActionItem?
    @Published var userName: String = ""
    @Published var showingEmptyFormAlert: Bool = false
    @Published var showingActionAlert: Bool = false // username unavailable
    @Published var hideInput: Bool = false
    @Published var readyToPostScore: Bool = false

    var userNameAvailable: Bool = false {
        willSet {
            objectWillChange.send()
        }
    }

    var totalScore: Int16 = 0 {
        willSet {
            objectWillChange.send()
        }
    }

    func saveChanges() {
        guard isValidForm, userNameAvailable else {return}
        // record fact that a score for THIS DEVICE has been recorded:
        UserDefaults.standard.set(true, forKey: "postedScore")
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(userName) {
            UserDefaults.standard.set(encoded, forKey: "userName")
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.hideInput = true
            self.readyToPostScore = true
        }
    }

    var isValidForm: Bool {
        guard !userName.isEmpty else {
            self.showingEmptyFormAlert = true
            return false
        }
        guard userName.count < 13 else {
            self.showingEmptyFormAlert = true
            return false
        }
        return true
    }

    func checkUserNameAvailable(userNamesArray: [String], userNameToTest: String) {
// convert everything to lowercase (array and name to test)
        let lowerCasedNames = userNamesArray.map {
            $0.lowercased()
        }
        let filteredArray = lowerCasedNames.filter {
            $0 == userNameToTest.lowercased()
        }
// filter 
        if filteredArray.isEmpty {
            userNameAvailable = true
        } else {
            showingActionAlert = true
            userNameAvailable = false
        }
    }
}

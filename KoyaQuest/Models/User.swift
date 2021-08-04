//
//  User.swift
//  KoyaQuest
//
//  Created by Kevin K Collins on 2021/07/11.
//

import SwiftUI

class User {
    var userIdentifier: String
    var email: String
    var firstName: String
    var lastName: String

    init(userIdentifier: String, email: String, firstName: String, lastName: String) {
        self.userIdentifier = userIdentifier
        self.email = email
        self.firstName = firstName
        self.lastName = lastName
    }
}

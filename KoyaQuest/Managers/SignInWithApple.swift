//
//  SignInWithApple.swift
//  KoyaQuest
//
//  Created by Kevin K Collins on 2021/07/09.
//

import AuthenticationServices

class SignInWithApple: NSObject, ASAuthorizationControllerDelegate, ObservableObject {
    @Published var isLoggedIn: Bool = false
    func performExistingAccountSetupFlows() {
        print("performing Existing Account SetUp Flows")
        // Prepare requests for both Apple ID and password providers.
        let requests = [ASAuthorizationAppleIDProvider().createRequest(),
                        ASAuthorizationPasswordProvider().createRequest()]
        
        // Create an authorization controller with the given requests.
        let authorizationController = ASAuthorizationController(authorizationRequests: requests)
        authorizationController.delegate = self
        // authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }
    
    func handleAuthorizationAppleIDButtonPress() {
        print("Handling Authorization Apple ID Button Press")
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        // authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        print("Called did complete with authorization")

//        switch authorization.credential {
//        case let appleIDCredential as ASAuthorizationAppleIDCredential:
            
//            // Create an account in your system.
//            let userIdentifier = appleIDCredential.user
//            if let fullName = appleIDCredential.fullName,
//            let email = appleIDCredential.email {
//                // Store the `userIdentifier` in UserDefaults
//                self.saveToUserDefaults(fullName: fullName, email: email)
//            } else {
//                print("not calling save to user defaults")
//            }
            
            
//
//        case let passwordCredential as ASPasswordCredential:
//
//            // Sign in using an existing iCloud Keychain credential.
//            let username = passwordCredential.user
//            let password = passwordCredential.password
//
//            // Show the password credential as an alert?
//
//        default:
//            break
       // }
    }
}


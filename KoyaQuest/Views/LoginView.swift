//
//  LoginView.swift
//  KoyaQuest
//
//  Created by Kevin K Collins on 2021/07/08.
//

import SwiftUI
import AuthenticationServices
import CoreData

struct LoginView: View {
    @AppStorage("login") private var login = false // added from github example
    @Environment(\.managedObjectContext) var viewContext: NSManagedObjectContext
    @EnvironmentObject var appData: AppData
    @Environment(\.sizeCategory) var sizeCategory: ContentSizeCategory
    var signIn = SignInWithApple()
    var body: some View {
        VStack {
            TitleView(fullCaption: false)
                .padding(.bottom, 30)
            // Spacer()
            Text("To enjoy the full features of this game, it is recommended that you sign in with your Apple ID")
                .font(.headline)
                .multilineTextAlignment(.center)
            SignInWithAppleButton(
                onRequest: { request in
                    request.requestedScopes = [.fullName, .email]
                },
                // Once user complete, get result
                onCompletion: { result in
                    // Switch result
                    switch result {
                        // Auth Success
                        case .success(let authResults):

                        switch authResults.credential {
                            case let appleIDCredential as ASAuthorizationAppleIDCredential:
                                let userID = appleIDCredential.user
                                if let firstName = appleIDCredential.fullName?.givenName,
                                    let lastName = appleIDCredential.fullName?.familyName,
                                    let email = appleIDCredential.email{
                                    // For New user to signup, and
                                    // save the 3 records to CloudKit
                                    UserData.createWith(
                                        userIdentifier: userID,
                                        firstName: firstName,
                                        lastName: lastName,
                                        email: email,
                                        using: self.viewContext)
                                    // Save to local
                                    UserDefaults.standard.set(userID, forKey: "userID")
                                    UserDefaults.standard.set(email, forKey: "email")
                                    UserDefaults.standard.set(firstName, forKey: "firstName")
                                    UserDefaults.standard.set(lastName, forKey: "lastName")
                                    
                                    // Change login state
                                    appData.gameState = .active
                                    self.login = true
                                } else {
                                    // For returning user to signin,
                                    // fetch the saved records from Cloudkit
                                    let fetchRequest = UserData.fetchRequestByUserID(userID: userID)
                                    var userData: FetchedResults<UserData> {
                                        fetchRequest.wrappedValue
                                    }
                                    if userData.count == 1 {
                                        let email = userData[0].email
                                        let firstName = userData[0].firstName
                                        let lastName = userData[0].lastName
                                        let userID = userData[0].userIdentifier
                                        
                                        UserDefaults.standard.set(userID, forKey: "userID")
                                        UserDefaults.standard.set(email, forKey: "email")
                                        UserDefaults.standard.set(firstName, forKey: "firstName")
                                        UserDefaults.standard.set(lastName, forKey: "lastName")
                                        appData.gameState = .active
                                        
                                        self.login = true
                                    }
                                    // if results : update userdefaults with the values from the fetch request
                                }
                            
                            // default break (don't remove)
                            default:
                                break
                            }
                        case .failure(let error):
                            print("failure", error)
                    }
                }
            )
            .frame(width: 260, height: 60, alignment: .center)
            .padding()
            Button {
               // appData.gameStarted = true
                appData.changeGameState(newState: .active)
               
            } label: {
            Text("Start without Sign In".uppercased())
                .font(.title3)
                .bold()
                .padding(10)
                .frame(width: wideElement(sizeCategory: sizeCategory) ? 330 : 260, height: 60, alignment: .center)
                .border(Color.white)
                .foregroundColor(Color.white)
            }
        }
        
        .background(Image("mtns")
        .scaledToFill()
        .edgesIgnoringSafeArea([.all])
        )
        .onAppear {
            signIn.performExistingAccountSetupFlows()
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

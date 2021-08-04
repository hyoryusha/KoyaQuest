//
//  UserView.swift
//  KoyaQuest
//
//  Created by Kevin K Collins on 2021/06/04.
//

import SwiftUI
import CoreData

struct UserView: View {
    @EnvironmentObject var appData: AppData
    @EnvironmentObject var signIn: SignInWithApple
    @Environment(\.sizeCategory) var sizeCategory: ContentSizeCategory
    @Environment(\.managedObjectContext) var viewContext: NSManagedObjectContext
    @State private var isShowingTempUserView = false

    var body: some View {
        VStack {
            Button(action: {
                isShowingTempUserView.toggle()
            }, label: {
                Text(isShowingTempUserView ? "Hide Temp User View" : "Show Temp User View")
            })

            if signIn.isLoggedIn {
                Text("Logged in")
            
            } else {
                Text("Not logged in")
            }
            Text(UserDefaults.standard.object(forKey: "firstName") as? String ?? "First Name")
            Text(UserDefaults.standard.object(forKey: "lastName") as? String ?? "Last Name")
            Text(UserDefaults.standard.object(forKey: "email") as? String ?? "Email")
        }
        .sheet(isPresented: $isShowingTempUserView, onDismiss: {}, content: {
            TempUserDataView(isShowingTempUserView: $isShowingTempUserView)
                .environment(\.managedObjectContext, self.viewContext)
        })
    }

}

struct UserView_Previews: PreviewProvider {
    static var previews: some View {
        UserView()
    }
}

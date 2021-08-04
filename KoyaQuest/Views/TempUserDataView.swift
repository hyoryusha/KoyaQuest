//
//  TempUserDataView.swift
//  KoyaQuest
//
//  Created by Kevin K Collins on 2021/07/09.
//

import SwiftUI
import CoreData

struct TempUserDataView: View {
    @Environment(\.managedObjectContext) var viewContext: NSManagedObjectContext
    @Binding var isShowingTempUserView: Bool
    @FetchRequest(entity: UserData.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \UserData.lastName, ascending: true)])
    var users: FetchedResults<UserData>
    var body: some View {
        // see if there are userData in CoreData
        VStack {
            List {
                ForEach(users, id: \.self) { user in
                    HStack {
                        Text(user.email ?? "Unknown")
                        Text(user.userIdentifier ?? "No ID")
                    }
                }
                .onDelete(perform: removeUser)
            }
            Button("Add") {

            let newUser = User(userIdentifier: "test", email: "kkcollins@me.com", firstName: "Kevin", lastName: "Collins")
                // need to make sure the newUser is not an existing user
                let fetchRequest: NSFetchRequest<UserData> = UserData.fetchRequest()
                fetchRequest.predicate = NSPredicate(format: "userIdentifier = %@", newUser.userIdentifier)
                do {
                    let existingUser = try viewContext.fetch(fetchRequest)
                    if existingUser.count == 0 { // the user
                        UserData.createWith(userIdentifier: newUser.userIdentifier, firstName: newUser.firstName, lastName: newUser.lastName, email: newUser.email, using: viewContext)
                        }
                    }
                    catch {
                        print(error.localizedDescription)
                    }
            }
        }
    }
    func removeUser(at offsets: IndexSet) {
        for index in offsets {
            let user = users[index]
            viewContext.delete(user)
        }
        do {
            try viewContext.save()
        } catch {
            // handle the Core Data error
            print(error.localizedDescription)
        }
    }
}

struct TempUserDataView_Previews: PreviewProvider {
    static var previews: some View {
        TempUserDataView(isShowingTempUserView: .constant(true))
    }
}

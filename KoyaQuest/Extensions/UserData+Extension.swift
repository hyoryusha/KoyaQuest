//
//  UserData+Extension.swift
//  KoyaQuest
//
//  Created by Kevin K Collins on 2021/07/09.
//

import CoreData
import SwiftUI

extension UserData {
    
    static func createWith(userIdentifier: String,
       firstName: String,
       lastName: String,
       email: String,
       using viewContext: NSManagedObjectContext) {
            let newUser = UserData(context: viewContext)
            newUser.userIdentifier = userIdentifier
            newUser.firstName = firstName
            newUser.lastName = lastName
            newUser.email = email

            do {
                try viewContext.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }

    // return a SwiftUI object - wrapper:
    static func basicFetchRequest() -> FetchRequest<UserData> {
        FetchRequest(entity: UserData.entity(), sortDescriptors: [])
    }
    
    static func fetchRequestByUserID(userID: String) -> FetchRequest<UserData> {
        let userPredicate = NSPredicate(format: "userIdentifier = %@", userID)
        return FetchRequest(entity: UserData.entity(), sortDescriptors: [],
                            predicate: userPredicate
                            )
    }
    
}
/*
let publicDatabase = CKContainer.default().publicCloudDatabase
publicDatabase.fetch(withRecordID: CKRecord.ID(recordName: userID)) { (record, error) in
 if let fetchedInfo = record {
     let email = fetchedInfo["email"] as? String
     let firstName = fetchedInfo["firstName"] as? String
     let lastName = fetchedInfo["lastName"] as? String
 */

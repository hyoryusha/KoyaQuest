//
//  Rating+Extension.swift
//  KoyaQuest
//
//  Created by Kevin K Collins on 2021/05/31.
//

import CoreData
import SwiftUI

extension Rating {
//    @NSManaged var landmark: String
//    @NSManaged var rating: Int16
//    @NSManaged var userID: Int16
//    @NSManaged var date: Date
    
    
    static func createWith(landmark: String,
                           rating: Int16,
                           userID: Int16,
                           date: Date,
                           using viewContext: NSManagedObjectContext) {
    
    let newRating = Rating(context: viewContext)
    newRating.landmark = landmark
    newRating.rating = rating
    newRating.date = date
    newRating.userID = userID
    
    do {
        try viewContext.save()
    } catch {
        let nserror = error as NSError
        fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
    }
}
    //return a SwiftUI object - wrapper:
    static func basicFetchRequest() -> FetchRequest<Rating> {
        FetchRequest(entity: Rating.entity(), sortDescriptors: [])
    }
    
    static func sortedFetchRequest() -> FetchRequest<Rating> {
        let dateSortDescriptor = NSSortDescriptor(key: "date", ascending: false)
        return FetchRequest(entity: Rating.entity(), sortDescriptors: [dateSortDescriptor])
    }
    
    static func fetchRequestSortedByDateAndPlace() -> FetchRequest<Rating> {
        let dateSortDescriptor = NSSortDescriptor(key: "date", ascending: true)
        let placeSortDescriptor = NSSortDescriptor(key: "landmark", ascending: true)
        return FetchRequest(entity: Rating.entity(), sortDescriptors: [placeSortDescriptor, dateSortDescriptor])
    }
    ///FILTER
    //note the format specifiers in NSPredicate: %K is the key %@ is the value; they are associated with following arguments (respectively)
}

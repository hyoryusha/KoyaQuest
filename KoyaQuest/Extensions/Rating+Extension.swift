//
//  Rating+Extension.swift
//  KoyaQuest
//
//  Created by Kevin K Collins on 2021/05/31.
//

import CoreData
import SwiftUI

extension Rating {

    var ratingDate: Date {
        date ?? Date()
    }
    var ratingLandmark: String {
        landmark ?? ""
    }

    static var example: Rating {// for use with previews?
        let controller = DataController(inMemory: true)
        let viewContext = controller.container.viewContext

        let rating = Rating(context: viewContext)
        rating.landmark = "Example Landmark"
        rating.rating = 2
        rating.date = Date()

        return rating
    }

    static func createWith(landmark: String,
                           rating: Int16,
                           date: Date,
                           using viewContext: NSManagedObjectContext) {
                                let newRating = Rating(context: viewContext)
                                newRating.landmark = landmark
                                newRating.rating = rating
                                newRating.date = date

                                do {
                                    try viewContext.save()
                                } catch {
                                    let nserror = error as NSError
                                    fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
                                }
    }
    // return a SwiftUI object - wrapper:
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
}

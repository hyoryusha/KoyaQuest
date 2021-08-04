//
//  FinalScore+Extension.swift
//  KoyaQuest
//
//  Created by Kevin K Collins on 2021/07/09.
//

import CoreData
import SwiftUI

extension FinalScore {

    var scoreDate: Date {
        submitDate ?? Date()
    }

    static func createWith(userIdentifier: String,
                           userName: String,
                           score: Int16,
                           submitDate: Date,
                           using viewContext: NSManagedObjectContext) {
                                let newScore = FinalScore(context: viewContext)
                                newScore.userIdentifier = userIdentifier
                                newScore.userName = userName
                                newScore.score = score
                                newScore.submitDate = submitDate

                                do {
                                    try viewContext.save()
                                } catch {
                                    let nserror = error as NSError
                                    fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
                                }
    }

    // return a SwiftUI object - wrapper:

    static func basicFetchRequest() -> FetchRequest<FinalScore> {
        return FetchRequest<FinalScore>(entity: FinalScore.entity(), sortDescriptors: [])
    }

    static func basicFetchRequestByScore() -> FetchRequest<FinalScore> {
        let scoreSortDescriptor = NSSortDescriptor(key: "score", ascending: false)
        return FetchRequest<FinalScore>(entity: FinalScore.entity(), sortDescriptors: [scoreSortDescriptor])
    }

    static func fetchByScoreAndDate() -> FetchRequest<FinalScore> {
        let scoreSortDescriptor = NSSortDescriptor(key: "score", ascending: false)
        let dateSortDescriptor = NSSortDescriptor(key: "submitDate", ascending: false)
        return FetchRequest<FinalScore>(entity: FinalScore.entity(), sortDescriptors: [scoreSortDescriptor, dateSortDescriptor])
    }
// this works!
    static func fetchTodaysScores() -> FetchRequest<FinalScore> {
        let scoreSortDescriptor = NSSortDescriptor(key: "score", ascending: false)
        let dateSortDescriptor = NSSortDescriptor(key: "submitDate", ascending: false)
        let calendar = Calendar.current
        let dateFrom = calendar.startOfDay(for: Date())
        let dateTo = calendar.date(byAdding: .day, value: 1, to: dateFrom)
        //let predicate = NSPredicate(format : "submitDate <= %@", dateFrom as CVarArg) // this give all before today, excluding
        let predicate = NSPredicate(format : "submitDate <= %@ AND submitDate >= %@", dateTo! as CVarArg, dateFrom as CVarArg)
//above predicate gives today only (from start of day to end)
        return FetchRequest<FinalScore>(entity: FinalScore.entity(), sortDescriptors: [scoreSortDescriptor, dateSortDescriptor], predicate: predicate)
    }
// possible?
    // pass the number of days from today as a var and use it where value: 1 is now
}

struct FinalScoreRecord: Identifiable {
    let id = UUID()
    let userName: String
    let date: Date
    let score: Int16
}

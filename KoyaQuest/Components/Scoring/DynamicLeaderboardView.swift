//
//  DynamicLeaderboardView.swift
//  KoyaQuest
//
//  Created by Kevin K Collins on 2021/07/22.
//

import SwiftUI

struct DynamicLeaderboardView: View {
    var fetchRequest: FetchRequest<FinalScore>

    init(fetchFilter: FinalScoreFilter) {
        switch fetchFilter {
        case .allTime:
            let scoreSortDescriptor = NSSortDescriptor(key: "score", ascending: false)
            let dateSortDescriptor = NSSortDescriptor(key: "submitDate", ascending: false)
            fetchRequest = FetchRequest<FinalScore>(
                entity: FinalScore.entity(),
                sortDescriptors: [scoreSortDescriptor, dateSortDescriptor]
            )

        case .today:
            let calendar = Calendar.current
            let dateFrom = calendar.startOfDay(for: Date())
            let dateTo = calendar.date(byAdding: .day, value: 1, to: dateFrom)
            fetchRequest = FetchRequest<FinalScore>(
                entity: FinalScore.entity(),
                sortDescriptors: [NSSortDescriptor(key: "score", ascending: false),
                                  NSSortDescriptor(key: "submitDate", ascending: false)]
                ,
                predicate: NSPredicate(
                    format: "submitDate <= %@ AND submitDate >= %@",
                    dateTo! as CVarArg,
                    dateFrom as CVarArg
                )
            )
        } // end init

    }
    var finalScores: FetchedResults<FinalScore> {
        fetchRequest.wrappedValue
    }

    var body: some View {
        ScrollView {
            ForEach(finalScores, id: \.self) { finalScore in
                let ordinal: Int = finalScores.firstIndex(of: finalScore)! + 1
                FinalScoreRow(finalScore: finalScore, ordinal: ordinal)
                    .frame(height: 28)
            }
        }
    }
}

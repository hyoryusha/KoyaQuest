//
//  LeaderboardView.swift
//  KoyaQuest
//
//  Created by Kevin K Collins on 2021/07/14.
//

import SwiftUI

enum FinalScoreFilter: String, Equatable, CaseIterable {
    case allTime = "All Time"
    case today = "Today"
    var localizedName: LocalizedStringKey { LocalizedStringKey(rawValue) }
}

struct LeaderboardView: View {
    @EnvironmentObject var appData: AppData
    @Environment(\.sizeCategory) var sizeCategory: ContentSizeCategory
    @State var fetchFilter: FinalScoreFilter
    let fetchRequest = FinalScore.fetchByScoreAndDate()
    var allFinalScores: FetchedResults<FinalScore> {
        fetchRequest.wrappedValue
    }

    var body: some View {
        ZStack {
            VStack {
                Group {
                    Text("Total Scores Submitted: \(allFinalScores.count)")
                        .font(wideElement(sizeCategory: sizeCategory) ? .footnote : .footnote)
                        .foregroundColor(.secondary)
                    + Text(" (as of \(Date().addingTimeInterval(60 * 60 * 1), style: .date))")
                        .font(wideElement(sizeCategory: sizeCategory) ? .footnote : .footnote)
                        .foregroundColor(.secondary)
                }
                .padding(.bottom, 6)
                // add a view for the current user if can be found?
                Divider()
                    .border(Color.koyaOrange)
                ColumnLabelRowView()
                DynamicLeaderboardView(fetchFilter: fetchFilter)
                SearchFilterPickerView(fetchFilter: $fetchFilter)
            } // end V
        } // end Z
    }
}

struct LeaderboardView_Previews: PreviewProvider {
    static var previews: some View {
        LeaderboardView(fetchFilter: FinalScoreFilter.allTime)
            .environmentObject(AppData())
    }
}

struct SearchFilterPickerView: View {
    @Binding var fetchFilter: FinalScoreFilter
    var body: some View {
        Divider()
        Text("Search scores by:")
            .font(.headline)
            .foregroundColor(.koyaDarkText)
        Picker("Search by:", selection: $fetchFilter) {
            ForEach(FinalScoreFilter.allCases, id: \.self) { value in
                Text(value.localizedName).tag(value)
            }
        }
        .pickerStyle(SegmentedPickerStyle())
        .padding(10)
    }
}

struct ColumnLabelRowView: View {
    var body: some View {
        HStack {
            ScoreLabel(labelText: "#", width: 10, alignment: .trailing)
            Spacer()
            ScoreLabel(labelText: "Player", width: 66, alignment: .leading)
            Spacer()
            ScoreLabel(labelText: "Score", width: 60, alignment: .center)
            Spacer()
            ScoreLabel(labelText: "Date", width: 80, alignment: .center)
            // Spacer()
        }
        .multilineTextAlignment(.leading)
        .padding()
    }
}

//
//  ScoreSummaryView.swift
//  KoyaQuest
//
//  Created by Kevin K Collins on 2021/06/04.
//

import SwiftUI

struct ScoreSummaryView: View {
    @EnvironmentObject var appData: AppData
    @Environment(\.sizeCategory) var sizeCategory: ContentSizeCategory
    @Binding var scoreSummaryIsVisible: Bool
    var body: some View {
            VStack {
                ScoreSummaryTopView(scoreSummaryIsVisible: $scoreSummaryIsVisible)
                Text("Score Summary")
                    .font(.title)
                    .bold()
                    .foregroundColor(Color.koyaDarkText)
                Text("Total Score: \(appData.totalScore)")
                    .font(wideElement(sizeCategory: sizeCategory) ? .caption : .headline)
                    .foregroundColor(.secondary)
                    .padding([.bottom, .top], 2)
                Text("\(appData.progressString) for \(appData.challengeScore) points")
                    .font(wideElement(sizeCategory: sizeCategory) ? .caption : .footnote)
                    .foregroundColor(.koyaGreen)
                Divider()
                    .padding()
                HStack {
                    ScoreLabel(labelText: "Challenge", width: 200, alignment: .leading)
                    Spacer()
                    ScoreLabel(labelText: "Points", width: 80, alignment: .trailing)
                }
                .multilineTextAlignment(.leading)
                List {
                    ForEach(completedItems) { item in
                        ScoreSummaryRow(
                            challenge: item.challenge,
                            points: item.points)
                    }
                }
                Text("Bonus Points: \(appData.bonusScore)")
                    .font(.headline)
                    .foregroundColor(.secondary)

                Text("\(appData.bonusProgressString)")
                    .font(.footnote)
                    .foregroundColor(.koyaGreen)
                    .padding(.bottom)
            }
            .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
    }
    var completedItems: [CompletedChallenge] {
        appData.completedChallengeSummary
    }
}

struct ScoreLabel: View {
    @Environment(\.sizeCategory) var sizeCategory: ContentSizeCategory
    var labelText = ""
    var width: CGFloat
    var alignment: Alignment
    var body: some View {
        Text(labelText.uppercased())
            .font(wideElement(sizeCategory: sizeCategory) ? .caption2 : .subheadline)
            .bold()
            .frame(width: width, alignment: alignment)
            .padding([.leading, .trailing], 20)
    }
}

struct ScoreSummaryView_Previews: PreviewProvider {
    static var previews: some View {
        ScoreSummaryView(scoreSummaryIsVisible: .constant(true))
            .environmentObject(AppData())
    }
}

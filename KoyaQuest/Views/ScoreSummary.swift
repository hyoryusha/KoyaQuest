//
//  ScoreSummary.swift
//  KoyaQuest
//
//  Created by Kevin K Collins on 2021/09/25.
//

import SwiftUI

struct ScoreSummary: View {
    @EnvironmentObject var appData: AppData
    @Environment(\.sizeCategory) var sizeCategory: ContentSizeCategory
    @State var shareScreen: Bool = false
    // @Binding var scoreSummaryIsVisible: Bool
   // @State private var showingAlert = false

    let wideScreenColumns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    let narrowScreenColumns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    var body: some View {
        ZStack {
            BackgroundView()
                .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            VStack {
                ScoreSummaryTopView()
                Text("Score Summary")
                    .font(.title)
                    .bold()
                    .foregroundColor(Color.white)
                Text("Total Score: \(appData.totalScore)")
                    .font(wideElement(sizeCategory: sizeCategory) ? .caption : .headline)
                    .foregroundColor(.koyaGreen)
                    .padding([.bottom, .top], 2)
                Text("\(appData.progressString) for \(appData.challengeScore) points")
                    .font(wideElement(sizeCategory: sizeCategory) ? .caption : .footnote)
                    .foregroundColor(.gray)
                

                GeometryReader { geo in
                    if isNarrowScreen(geo: geo) {
                        ScrollView {
                            LazyVGrid(columns: narrowScreenColumns, spacing: 8) {
                                ForEach(allChallenges) { item in
                                    ScoreBadgeView(challenge: item.name,
                                                   complete: didCompleteChallenge(challenge: item),
                                                   points: getScoreForCompletedChallenge(challenge: item)
                                    )
                                }
                            }
                            .padding()
                        }
                    } else {
                        ScrollView {
                            LazyVGrid(columns: wideScreenColumns, spacing: 20) {
                                ForEach(allChallenges) { item in
                                    ScoreBadgeView(challenge: item.name,
                                                   complete: didCompleteChallenge(challenge: item),
                                                   points: getScoreForCompletedChallenge(challenge: item)
                                    )
                                } 
                            }
                        }
                        .padding()
                    }
                }

                Text("Bonus Points: \(appData.bonusScore)")
                    .font(.headline)
                    .foregroundColor(.koyaGreen)

                Text("\(appData.bonusProgressString)")
                    .font(.footnote)
                    .foregroundColor(.gray)
                    .padding(.bottom)
            }
            .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
        }
    }
    func isNarrowScreen(geo: GeometryProxy) -> Bool {
        return geo.size.width <= 375
    }

    var completedItems: [CompletedChallenge] {
        appData.completedChallengeSummary
    }
    func didCompleteChallenge(challenge: Challenge) -> Bool {
        if completedItems.contains(where: {$0.challenge == challenge.name}) {
            return true
        } else {
            return false
        }
    }

    func getScoreForCompletedChallenge(challenge: Challenge) -> Int {
        if appData.completedChallengeSummary.contains(where: {$0.challenge == challenge.name}) {
            if let index = appData.completedChallengeSummary.firstIndex(where: { $0.challenge == challenge.name }) {
                return appData.completedChallengeSummary[index].points
            } else {
                return 0
            }
        } else {
            return 0
        }
    }
}


struct ScoreSummary_Previews: PreviewProvider {
    static var previews: some View {
        ScoreSummary()
            .environmentObject(AppData())
    }
}

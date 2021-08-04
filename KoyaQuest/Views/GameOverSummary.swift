//
//  GameOverSummary.swift
//  KoyaQuest
//
//  Created by Kevin K Collins on 2021/07/14.
//

import SwiftUI

struct GameOverSummary: View {
    @Environment(\.sizeCategory) var sizeCategory: ContentSizeCategory
    @EnvironmentObject var appData: AppData
    @Binding var isShowingForm: Bool
    @Binding var hidePostScoreButton: Bool
    @Binding var scoreSummaryIsVisible: Bool
    @Binding var activeSheet: ActiveSheet?

    var body: some View {
        ZStack {
            VStack {
                Text("Final Score: \(appData.totalScore) points")
                    .font(wideElement(sizeCategory: sizeCategory) ? .footnote : .title2)
                    .bold()
                    .foregroundColor(Color.koyaGreen)
                    .padding(.top, 10)
                HStack {
                    Spacer()
                    Button(action: {
                        scoreSummaryIsVisible = true
                        activeSheet = .second
                    },
                        label: {
                            HStack {
                                Text("Score Summary")
                                    .font(.footnote)
                                    .foregroundColor(.koyaGreen)
                                Image(systemName: "list.bullet")
                                    .font(.body)
                                    .foregroundColor(Color.koyaGreen)
                            }
                    })
                    .padding([.top, .trailing, .bottom], 3)
                    }
                .padding(.trailing, 6)

            Divider()
                .padding(.bottom, 4)
                VStack (alignment: .leading, spacing: 1) {
                    Text("You have earned the rank of:")
                        .font(.body)
                        .foregroundColor(.koyaPurple)
                        .italic()
                        .multilineTextAlignment(.leading)
                        .padding([.top, .bottom], 4)
                    ForEach(Level.allCases) { value in
                        if value == appData.level {
                            HStack {
                                Image(systemName: "circlebadge.fill")
                                    .foregroundColor(.koyaGreen)
                                    .padding(.leading, 10)
                                Text(value.rawValue)
                                    .font(.callout)
                                    .foregroundColor(.koyaDarkText)
                                    .multilineTextAlignment(.leading)
                            }
                        } else {
                            HStack {
                                Image(systemName: "circlebadge")
                                    .foregroundColor(.secondary)
                                    .padding(.leading, 10)
                                Text(value.rawValue)
                                    .font(.callout)
                                    .foregroundColor(.secondary)
                                    .multilineTextAlignment(.leading)
                            }
                        }
                    }
                }
                .padding(.bottom, 10)
                if !appData.scorePosted {
                    if !hidePostScoreButton {
                        Group {
                            Text("You can upload your score to the public leaderboard:")
                                .font(.caption)
                                .italic()
                                .padding(.bottom, 4)
                                .multilineTextAlignment(.center)
                            Button {
                                isShowingForm = true
                                activeSheet = .first
                            } label: {
                                HStack {
                                    Text("Post Score".uppercased())
                                .font(.title3)
                                .bold()
                                .padding(10)
                                Spacer()
                                    Image(systemName: "icloud.and.arrow.up" )
                                        .font(.title3)
                            }
                            .padding()
                            .frame(width: wideElement(sizeCategory: sizeCategory) ? 330 : 220, height: 50, alignment: .center)
                                .background(Color.koyaGreen)
                                .foregroundColor(Color.koyaLightText)
                            .buttonStyle(ScaleButtonStyle())
                            }
                        } // end group
                        .padding(.bottom, 10)
                    }
                }
            } // end VStack frame
            .frame(width: 360, alignment: .center)
            .background(Color.koyaSky.opacity(0.6))
            } // end ZStack
        }
    }

struct GameOverSummary_Previews: PreviewProvider {
    static var previews: some View {
        GameOverSummary(isShowingForm: .constant(false), hidePostScoreButton: .constant(false), scoreSummaryIsVisible: .constant(false), activeSheet: .constant(.first))
            .environmentObject(AppData())
    }
}

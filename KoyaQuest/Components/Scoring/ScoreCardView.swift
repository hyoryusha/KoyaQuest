//
//  ScoreCardView.swift
//  KoyaQuest
//
//  Created by Kevin K Collins on 2021/06/04.
//

import SwiftUI

struct ScoreCardView: View {
    @EnvironmentObject var appData: AppData
    @Environment(\.sizeCategory) var sizeCategory: ContentSizeCategory
    @Binding var scoreSummaryIsVisible: Bool
    var text: String
    var body: some View {

        VStack {
            Text("\(text) Score: \(appData.totalScore) points")
                .font(wideElement(sizeCategory: sizeCategory) ? .footnote : .title2)
                .bold()
                .foregroundColor(Color.koyaGreen)
                .padding(wideElement(sizeCategory: sizeCategory) ? 4 : 0)

        Divider()
            Text("\(appData.progressString)")
                .font(wideElement(sizeCategory: sizeCategory) ? .caption2 : .body)
                    .multilineTextAlignment(/*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/)
                .foregroundColor(.gray)
            HStack {
                if appData.kukaiChallengeState == .paused || UserDefaults.standard.bool(forKey: "KukaiSaved") == true {
                    HStack {
                        Image(systemName: "paperclip")
                        Text("Kukai Challenge Paused")
                    }
                    .font(.caption2)
                    .foregroundColor(.koyaOrange)
                }
                    Spacer()

                Button(action: {
                    scoreSummaryIsVisible = true
                },
                    label: {
                        HStack {
                            Text("Score Summary")
                                .font(.footnote)
                                .foregroundColor(.koyaGreen)
                            Image(systemName: "list.bullet")
                                .font(.footnote)
                                .foregroundColor(Color.koyaGreen)
                        }
                })
                .padding([.top, .trailing, .bottom], 3)
                }
            }
        .frame(width: 300, height: wideElement(sizeCategory: sizeCategory) ? 78 : 88)
                .padding()
                .background(Color("LightBlue"))
                .cornerRadius(8)
                // .shadow(radius: 40)
        }
    }

struct ScoreCardView_Previews: PreviewProvider {
    static var previews: some View {
        ScoreCardView(scoreSummaryIsVisible: .constant(false),
                      text: "Total")
            .environmentObject(AppData())
    }
}

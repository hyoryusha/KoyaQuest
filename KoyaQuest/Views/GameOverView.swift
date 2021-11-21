//
//  GameOverView.swift
//  KoyaQuest
//
//  Created by Kevin K Collins on 2021/06/28.
//

import SwiftUI
import CoreData

struct GameOverView: View {
    @EnvironmentObject var appData: AppData
    @Environment(\.sizeCategory) var sizeCategory: ContentSizeCategory
    @Environment(\.managedObjectContext) var viewContext: NSManagedObjectContext
    @State private var scoreSummaryIsVisible = false
    @State private var isShowingForm = false
    @State var activeSheet: ActiveSheet?
    @State private var hidePostScoreButton: Bool = false

    var body: some View {
        VStack {
            TitleView(fullCaption: false)
            Group {
                Text("Congratulations!".uppercased())
                    .font(.title2)
                    .bold()
                    .padding(8)
                    .foregroundColor(Color.white)
                Text("You have completed all \(allChallenges.count) challenges.")
                    .font(.body)
                    .foregroundColor(.koyaPurple)
                    .italic()
                    .multilineTextAlignment(.center)
            }

            GameOverSummary(isShowingForm: $isShowingForm,
                            hidePostScoreButton: $hidePostScoreButton,
                            scoreSummaryIsVisible: $scoreSummaryIsVisible,
                            activeSheet: $activeSheet
            )
                .padding(.bottom, 8)

            Divider()

            Text("What's next?")
                .font(.system(wideElement(sizeCategory: sizeCategory) ? .body : .title2, design: .serif))
                .italic()
                .bold()
                .foregroundColor(Color.koyaPurple)
                .padding(.top, 4)
            // swiftlint:disable:next line_length
            Text("Once completed, the game cannot be replayed. However, you can continue to use this app as a guide to Mt. Kōya by tapping the button below:")
                .font(.caption)
                .italic()
                .padding(4)
                .multilineTextAlignment(.center)

            Button {
                appData.changeGameState(newState: .exited)
            } label: {
                Text("Use App as a Guide".uppercased())
                    .font(.title3)
                    .bold()
                    .padding(10)
                    .frame(width: wideElement(sizeCategory: sizeCategory) ? 330 : 220, height: 50, alignment: .center)
                    .border(Color.white)
                    .foregroundColor(Color.white)
            }
            .buttonStyle(ScaleButtonStyle())
            .padding(.bottom, 20)
        }
        .sheet(item: $activeSheet) { item in
            switch item {
            case .first:
                PostScoreView(isShowingForm: $isShowingForm,
                              // swiftlint:disable:next line_length
                              hidePostScoreButton: $hidePostScoreButton).environmentObject(appData) .environment(\.managedObjectContext, viewContext)
            case .second:
                ScoreSummaryView(scoreSummaryIsVisible: $scoreSummaryIsVisible)
            case .third:
                EmptyView()
            case .none:
                EmptyView()
            }
        }
        .background(Image("mtns")
                        .scaledToFill()
                        .edgesIgnoringSafeArea([.all]))
        .statusBar(hidden: true)
    }
}

struct GameOverView_Previews: PreviewProvider {
    static var previews: some View {
        GameOverView()
            .environmentObject(AppData())
    }
}

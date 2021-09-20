//
//  AppInfoView.swift
//  KoyaQuest
//
//  Created by Kevin K Collins on 2021/09/18.
//

import SwiftUI

struct AppInfoView: View {
    @Binding var isShowingInfo: Bool
    var body: some View {
        VStack {
            List {
                NavigationLink(
                    destination: AboutGameView().navigationBarTitle("About KoyaQuest"),
                    label: {
                        HStack {
                            Image(systemName: "questionmark.diamond")
                            Text("What is KoyaQuest?")
                        }
                        .foregroundColor(.koyaDarkText)
                    })
                NavigationLink(
                    destination: LeaderboardView(viewModel: LeaderboardViewModel(), fetchFilter: FinalScoreFilter.allTime).navigationBarTitle("Leaderboard"),
                    label: {
                        HStack {
                            Image(systemName: "sparkles")
                            Text("LeaderBoard")
                        }.foregroundColor(.koyaDarkText)

                    })
                NavigationLink(
                    destination: FAQFilteredScrollView().navigationBarTitle("FAQ"),
                    label: {
                        HStack {
                            Image(systemName: "folder.badge.questionmark")
                            Text("FAQ")
                        }
                        .foregroundColor(.koyaDarkText)

                    })
            }
        }
            .navigationBarItems(leading: Text("Back to Main Menu"))
    }
}

struct AppInfoView_Previews: PreviewProvider {
    static var previews: some View {
        AppInfoView(isShowingInfo: .constant(true))
    }
}

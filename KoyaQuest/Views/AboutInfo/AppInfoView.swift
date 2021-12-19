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
                        AboutViewRow(
                            icon: "info.circle",
                            title: "What is KoyaQuest?",
                            blurb: "Explore the features of this app...")
                    })
                NavigationLink(
                    destination: LeaderboardView(
                        // viewModel: LeaderboardViewModel(),
                        // swiftlint:disable:next line_length
                                                 fetchFilter: FinalScoreFilter.allTime).navigationBarTitle("Leaderboard"),
                    label: {
                        AboutViewRow(
                            icon: "list.number",
                            title: "LeaderBoard",
                            blurb: "Check out scores and rankings...")
                    })
                NavigationLink(
                    destination: FAQFilteredScrollView().navigationBarTitle("FAQ"),
                    label: {
                        AboutViewRow(
                            icon: "folder.badge.questionmark",
                            title: "FAQ",
                            blurb: "Find out more about Mt. Kōya...")

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

struct AboutViewRow: View {
    var icon: String
    var title: String
    var blurb: String

    var body: some View {
        HStack {
            Image(systemName: icon)
                .font(.title)
                .foregroundColor(.koyaOrange)
            VStack(alignment: .leading, spacing: 6) {
                Text(title)
                    .font(.title3)
                    .bold()
                    .foregroundColor(.koyaDarkText)
                Text(blurb)
                    .font(.subheadline)
                    .italic()
                    .foregroundColor(.secondary)
            }
        }
    }
}

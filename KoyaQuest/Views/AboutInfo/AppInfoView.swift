//
//  AppInfoView.swift
//  KoyaQuest
//
//  Created by Kevin K Collins on 2021/06/04.
//

import SwiftUI

struct AppInfoView: View {
    @Binding var isShowingInfo: Bool

    var body: some View {
        ZStack {
            BackgroundView()
            VStack {
                InfoTopView(isShowingInfo: $isShowingInfo)
                TabView {
                    AboutGameView()
                        .tabItem {
                            Image(systemName: "questionmark.diamond")
                            Text("What is KoyaQuest?")
                        }
                    LeaderboardView(viewModel: LeaderboardViewModel(), fetchFilter: FinalScoreFilter.allTime)
                        .tabItem {
                            Image(systemName: "sparkles")
                            Text("LeaderBoard")
                        }
                    FAQView()
                        .tabItem {
                            Image(systemName: "folder.badge.questionmark")
                            Text("FAQ")
                        }
                }
                .accentColor(Color.koyaOrange)
                .onAppear {
                    UITabBar.appearance().barTintColor = UIColor(
                        red: 230 / 255,
                        green: 240 / 255,
                        blue: 248 / 255,
                        alpha: 1.0)
                }
            }
            .background(Color.koyaPurple)
            .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
        }
    }
}

struct AppInfoView_Previews: PreviewProvider {
    static var previews: some View {
        AppInfoView(isShowingInfo: .constant(true))
            .environmentObject(AppData())
    }
}

//
//  AppInfoView.swift
//  KoyaQuest
//
//  Created by Kevin K Collins on 2021/06/04.
//

import SwiftUI

struct AppInfoTabView: View {
    @Binding var isShowingInfo: Bool

    var body: some View {
        ZStack {
            BackgroundView()
            VStack {
                InfoTopView(isShowingInfo: $isShowingInfo)
                TabView {
                    NavigationView {
                        AboutGameView()
                            .navigationBarTitle("About KoyaQuest")
                    }

                        .tabItem {
                            Image(systemName: "questionmark.diamond")
                            Text("What is KoyaQuest?")
                        }
                    NavigationView{
                        LeaderboardView(viewModel: LeaderboardViewModel(), fetchFilter: FinalScoreFilter.allTime)
                            .navigationBarTitle("Leaderboard")
                    }

                        .tabItem {
                            Image(systemName: "sparkles")
                            Text("LeaderBoard")
                        }
                    NavigationView{
                        FAQFilteredScrollView()
                            .navigationBarTitle("FAQ")
                    }

                        .tabItem {
                            Image(systemName: "folder.badge.questionmark")
                            Text("FAQ")
                        }

                }

                //.edgesIgnoringSafeArea(.top)
                .accentColor(Color.koyaOrange)
                .onAppear {
                    UITabBar.appearance().barTintColor = UIColor(
                        red: 230 / 255,
                        green: 240 / 255,
                        blue: 248 / 255,
                        alpha: 1.0)
                }
            }
            .navigationBarTitle("Back to Main Menu", displayMode: .inline)
            .navigationBarHidden(false)
            .background(Color.koyaPurple)
            .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
        }
    }
}

struct AppInfoTabView_Previews: PreviewProvider {
    static var previews: some View {
        AppInfoTabView(isShowingInfo: .constant(true))
            .environmentObject(AppData())
    }
}

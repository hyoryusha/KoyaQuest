//
//  ContentView.swift
//  KoyaQuest
//
//  Created by Kevin K Collins on 2021/05/30.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @EnvironmentObject var appData: AppData
     @EnvironmentObject var dataContoller: DataController
    @StateObject var locationManager = LocationManager()
    @StateObject var challengeManager = ChallengeDisplayViewModel()

@ViewBuilder
    var body: some View {
            switch appData.gameState {
            case .initial:
                WelcomeView(locationManager: locationManager).alert(item: $locationManager.alertItem) { alertItem in
                    Alert(title: alertItem.title,
                          message: alertItem.message,
                          dismissButton: alertItem.dismissButton)
                }
//                Button("Add Sample Leaderboard Data") {
//                    try? dataContoller.createSampleLeaderBoard()
//                }
            case .login:
                LoginView()
            case .active, .idle, .exited:
                MainMenuView(landmark: Landmark.allLandmarks[0])
            case .complete:
                GameOverView()
            }
        }
    }

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(AppData())
            .environmentObject(LocationManager())
    }
}

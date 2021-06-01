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
    @StateObject var locationManager = LocationManager()
    @StateObject var challengeManager = ChallengeDisplayManager()

@ViewBuilder
    var body: some View {
        if appData.gameStarted == true {
            MainMenuView(challengeManager: ChallengeDisplayManager(), landmark: Landmark.allLandmarks[0])
        } else {
            WelcomeView(locationManager: locationManager)
            .alert(item: $locationManager.alertItem) { alertItem in
                Alert(title: alertItem.title,
                      message: alertItem.message,
                      dismissButton: alertItem.dismissButton)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

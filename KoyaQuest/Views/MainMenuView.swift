//
//  MainMenuView.swift
//  KoyaQuest
//
//  Created by Kevin K Collins on 2021/05/31.
//

import SwiftUI

struct MainMenuView: View {
    @EnvironmentObject var appData: AppData
    @EnvironmentObject var locationManager: LocationManager
    //@Environment(\.managedObjectContext) var viewContext : NSManagedObjectContext
    @EnvironmentObject var dataController : DataController
    @StateObject var viewModel = MainMenuViewModel()
    @ObservedObject var challengeManager : ChallengeDisplayManager
    @State var landmark: Landmark
    @State var selection: Int? = nil
    @State private var isShowingScorecard = true
    @State private var isShowingInfo = false
    @State private var scoreSummaryIsVisible = false
    
    
    var body: some View {
        LandmarkListView(locationManager: locationManager)
    }
}

struct MainMenuView_Previews: PreviewProvider {
    static var previews: some View {
        MainMenuView( challengeManager: ChallengeDisplayManager(), landmark: Landmark.allLandmarks[0])
            //.environmentObject(AppData())
           // .environmentObject(LocationManager())
    }
}

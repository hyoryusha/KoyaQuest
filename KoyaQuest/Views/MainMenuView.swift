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
    @EnvironmentObject var dataController: DataController
    @Environment(\.sizeCategory) var sizeCategory: ContentSizeCategory
    @StateObject var viewModel = MainMenuViewModel()
    @State var landmark: Landmark
    @State var selection: Int?
    // @State private var isShowingScorecard = true
    @State private var isShowingInfo = false
    @State private var scoreSummaryIsVisible = false
    @State private var isShowingBonusList = false

    var body: some View {
            ZStack { // ZStack added when ContentView used @ViewBuilder
                NavigationView {
                    VStack {
                        if appData.gameState != .exited{
                            gamePlayControls
                        }
                        TitleView(fullCaption: false)
                        // MARK: - First NavLink
                        NavigationLink(
                            destination: LandmarkDetailView(
                                        locationManager: locationManager,
                                        landmark: landmark).environmentObject(appData), tag: 1,
                                        selection: $selection) { EmptyView() }
                                Button {
                                    self.selection = 1
                                } label: {
                                    TitleImageView(landmark: landmark)
                                }
                        CaptionView(text: landmark.details.headerOne)
                        // MARK: - Second NavLink
                        NavigationLink(
                            destination: MapView(target: landmark),
                            tag: 2,
                            selection: $selection) { EmptyView() }
                        Group {
                            mapButton
                            if appData.gameState != .exited{
                            scoreBox
                            } else {
                                Spacer()
                            }
                                if !appData.isPlayingGame {
                                    DisabledMessageView()
                                }
                            }
                        MainMenuScrollView(selection: $landmark)
                        // MARK: - LINK TO LIST
                        HStack {
                            NavigationLink(destination: LandmarkListView(locationManager: locationManager)) {
                                Image(systemName: "list.dash")
                                    .font(wideElement(sizeCategory: sizeCategory) ? .caption : .headline)
                                    .foregroundColor(Color.koyaSky)
                                Text("See List".uppercased())
                                    .font(wideElement(sizeCategory: sizeCategory) ? .caption : .headline)
                                    .foregroundColor(Color.koyaSky)
                                 }
                            .navigationTitle("")
                            .navigationBarHidden(true)
                            Spacer()
                                .frame(width: 110)
                            NavigationLink(destination: AppInfoView(isShowingInfo: $isShowingInfo)) {
                                Image(systemName: "info.circle.fill")
                                .font(.headline)
                                    .foregroundColor(Color.koyaSky)
                                Text("About".uppercased())
                                    .font(wideElement(sizeCategory: sizeCategory) ? .caption : .headline)
                                    .foregroundColor(Color.koyaSky)
                                 }
                            .navigationTitle("")
                            .navigationBarTitle(Text(""))
                            .navigationBarHidden(true)
                        }
                    } // end vstack
                    .padding(.bottom, 14)
                    .navigationBarTitle(Text(""))
                    .navigationBarHidden(true)
                    .background(Image("mtns"))
                .sheet(isPresented: $scoreSummaryIsVisible, onDismiss: {}, content: {
                    ScoreSummaryView(scoreSummaryIsVisible: $scoreSummaryIsVisible)
                })
                }

                .navigationViewStyle(StackNavigationViewStyle())
                .statusBar(hidden: true)
                .animation(.easeInOut(duration: 0.8))
                .blur(radius: showChallenge() ? 16 : 0)
                .onAppear() {
                    if appData.gameState != .exited {
                        appData.checkForGameOver()
                    }
                }
                if showChallenge() {
                    ChallengeDisplayView(isPlayingGame: $appData.isPlayingGame,
                                         enteredZone: locationManager.activeTargetZone!)
                            .animation(.easeInOut(duration: 0.8))
                    }
                if showBonus() {
                    BonusDisplayView(isPlayingGame: $appData.isPlayingGame, isShowingBonusList: $isShowingBonusList)
                            .animation(.easeOut(duration: 0.8))
                    }
        } // end zstack
    } // end body view

// MARK: - LOGIC
    func showChallenge() -> Bool {
        if locationManager.isInTargetZone && appData.isPlayingGame && appData.isShowingChallenge {
            let challenge = locationManager.activeArea?.challenge
                if !appData.completedChallengeSummary.contains(where: { item in
                    item.challenge == challenge!.name
                }) {
                    return true
                } else {
                    return false
                }
            } else {
            return false
        }
    }

    func showBonus() -> Bool {
        locationManager.isInTargetZone &&
            appData.isShowingBonus &&
//            isShowingBonusList &&
            appData.isPlayingGame
    }
    // MARK: - VIEW PROPERTIES
    var gamePlayControls: some View {
        HStack {
            if appData.isPlayingGame == false {
                Text("Current Score: \(appData.totalScore)")
                    .font(wideElement(sizeCategory: sizeCategory) ? .caption2 : .subheadline)
                    // .bold()
                    .foregroundColor(.koyaGreen)
                    .padding(.leading, 10)
            }
            Spacer()
            GamePlayToggleView(isPlayingGame: $appData.isPlayingGame)
        }
    }

    var mapButton: some View {
        Button {
             self.selection = 2
        } label: {
        HStack(alignment: .center, spacing: 8) {
            Image(systemName: "mappin.and.ellipse")
            .font(.system(size: 16))
                .foregroundColor(.koyaSky)
            Text("View on Map")
                .font(.system(size: 16))
                .foregroundColor(.koyaSky)
        }
        .padding([.bottom, .top], 6)
        }
    }

    var scoreBox: some View {
        Group {
            if appData.isPlayingGame {
                ScoreCardView(scoreSummaryIsVisible: $scoreSummaryIsVisible, text: "Total").padding(.top, 20)
                }
            Spacer()
        }
    }
}

struct MainMenuView_Previews: PreviewProvider {
    static var previews: some View {
        MainMenuView(landmark: Landmark.allLandmarks[0])
            .environmentObject(AppData())
            .environmentObject(LocationManager())
    }
}

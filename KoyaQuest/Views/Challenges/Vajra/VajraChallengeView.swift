//
//  VajraChallengeView.swift
//  KoyaQuest
//
//  Created by Kevin K Collins on 2021/06/04.
//

import SwiftUI

struct VajraChallengeView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var appData: AppData
    @EnvironmentObject var locationManager: LocationManager
    @StateObject var viewModel = VajraChallengeViewModel()

    var body: some View {
        ZStack {
            BackgroundView()
                .ignoresSafeArea(.all)
            VStack {
                XDismissButtonRight()
                    .padding(.top, 4)
                    .padding(.trailing, 8)
                HStack {
                    // Image(systemName: "eyes")
                    Text("Search for the Vajra!")
                        .bold()
                }
                .frame(
                    minWidth: 320,
                    idealWidth: 420,
                    maxWidth: 420,
                    minHeight: 32,
                    idealHeight: 50,
                    maxHeight: 52,
                    alignment: .center
                )
                .foregroundColor(.koyaOrange)
                .font(.title)
                .padding(.bottom, 6)
                Spacer()
                ZStack{
                    VajraFinderView(viewModel: self.viewModel, found: $viewModel.found)
                   // Rectangle()
                        //.foregroundColor(.white)
                        //.edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                        .frame(
                            minWidth: 320,
                            idealWidth: 400,
                            maxWidth: 412,
                            minHeight: 320,
                            idealHeight: 520,
                            maxHeight: 536,
                            alignment: .center
                        )
                        //.padding(.bottom, 20)
                    VStack {
                        Spacer()
                        Spacer()
                        Spacer()
                        Spacer()
                        Spacer()
                        Text("Move around the area where you think it might be.\nFor best results, hold your phone upright.")
                            .padding(.top, 8)
                            .padding(.bottom, 8)
                            .frame(minWidth: 320, maxWidth: 412)
                            .background(Color.gray.opacity(0.6))
                            .font(.subheadline)
                            .multilineTextAlignment(.center)
                        Spacer()
                    }
                }

                if viewModel.found {
                    Text("Line up the sight and tap the target to capture the Vajra.")
                        .font(.callout)
                        .foregroundColor(.koyaOrange)
                        .italic()
                }
                Text(viewModel.statusText)
                    .font(.title3)
                    .foregroundColor(viewModel.statusTextColor)
                Text("Distance and Direction to target:")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()

                    DirectionDistanceIndicator(
                        isVajraChallenge: true,
                        distance: viewModel.distance,
                        rotation: viewModel.rotation,
                        color: viewModel.distanceIndicatorColor)

            } // end VStack
            .overlay(viewModel.isShowingModal ? MountainOverlayView() : nil)
            .navigationBarTitle(Text(""))
            .navigationBarHidden(true)
            if viewModel.isShowingModal {
                ChallengeFeedbackView(
                    appData: appData,
                    locationManager: locationManager,
                    challenge: vajraChallenge,
                    text: viewModel.zapped ? "Nice Job!" : "Too bad",
                    points: vajraChallenge.maxPoints,
                    success: viewModel.zapped ? true : false)
                .offset(x: 0.0, y: -40.0)
            }
        } // end ZStack
        .statusBar(hidden: true)
    }
}

struct VajraChallengeView_Previews: PreviewProvider {
    static var previews: some View {
        VajraChallengeView()
            .environmentObject(AppData())
            .environmentObject(LocationManager())
            .preferredColorScheme(.light)
    }
}

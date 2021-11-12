//
//  KukaiChallengeView.swift
//  KoyaQuest
//
//  Created by Kevin K Collins on 2021/06/04.
//

import SwiftUI

struct KukaiChallengeView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var appData: AppData
    @EnvironmentObject var locationManager: LocationManager
    @StateObject var viewModel = KukaiChallengeViewModel()

    var body: some View {
        ZStack {
            BackgroundView()
                .ignoresSafeArea(.all)
            VStack {
                XDismissButtonRight()
                    .padding(.top, 0)
                    .padding(.trailing, 16)
                HStack {
                    Image(systemName: "camera.viewfinder")
                    Text("Find Kūkai")
                }
                .font(.title)
                .foregroundColor(.orange)
                .padding(.bottom, 6)

                Text("Point your camera at the image when you find it.")
                    .font(.footnote)
                    .foregroundColor(.white)
                    KukaiFinderView(foundImage: $viewModel.foundImage, success: $viewModel.success)
                        // Rectangle()
                        .frame(height: 380)
                            .padding(.bottom, 6)
                    Text(viewModel.statusText)
                        .font(.title3)
                        .foregroundColor(viewModel.statusTextColor)
                        .padding()
            } // End VStack
            .blur(radius: viewModel.success ? 6 : 0)
            .navigationBarTitle(Text(""))
            .navigationBarHidden(true)
            if viewModel.success {
                ChallengeFeedbackView(
                    appData: appData,
                    locationManager: locationManager,
                    challenge: kukaiChallenge, text: "Well Done",
                    points: kukaiChallenge.maxPoints,
                    success: viewModel.success)
            }

        } // End ZStack?
        .onAppear() {
            if viewModel.success {
                viewModel.stopTimer()
            } else {
                viewModel.startTimer()
            }
        }
        .navigationBarTitle(Text(""))
        .navigationBarHidden(true)
        .statusBar(hidden: true)
        .alert(isPresented: $viewModel.showingAlert) {
            Alert(
                title: Text("Taking a long time?"),
                               message: Text("You can pause this challenge and resume later (when you find the target)."),
                primaryButton: .default(Text("Save for Later")) {
                                appData.kukaiChallengeState = .paused
                                appData.isPlayingGame = false
                                locationManager.resumeRegionMonitoring()
                               },
                secondaryButton: .cancel(Text("I'll keep looking")) {
                    viewModel.secondsLeft = 10
                    viewModel.startTimer()
                }
            )
        }
    }
}

struct KukaiChallengeView_Previews: PreviewProvider {
    static var previews: some View {
        KukaiChallengeView()
            .preferredColorScheme(.light)
    }
}

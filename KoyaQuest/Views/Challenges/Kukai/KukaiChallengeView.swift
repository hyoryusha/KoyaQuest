//
//  KukaiChallengeView.swift
//  KoyaQuest
//
//  Created by Kevin K Collins on 2021/06/04.
//

import SwiftUI

struct KukaiChallengeView: View {
    @Environment(\.sizeCategory) var sizeCategory: ContentSizeCategory
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
                .frame(
                    minWidth: 320,
                    idealWidth: 420,
                    maxWidth: 420,
                    minHeight: 32,
                    idealHeight: 50,
                    maxHeight: 52,
                    alignment: .center
                )
                .font(.title)
                .foregroundColor(.koyaOrange)
                .padding(.bottom, 6)

                Text("Point your camera at the image when you find it.")
                    .font(.footnote)
                    .foregroundColor(.white)
                KukaiFinderView(
                    foundImage: $viewModel.foundImage,
                    success: $viewModel.success
                )
                    .frame(
                        minWidth: 320,
                        idealWidth: 400,
                        maxWidth: 412,
                        minHeight: 320,
                        idealHeight: 520,
                        maxHeight: 536,
                        alignment: .center
                    )
                    .padding(.bottom, 6)
                Text(viewModel.statusText)
                    .font(.title3)
                    .foregroundColor(viewModel.statusTextColor)
                    .padding()
                if viewModel.success {
                    Button {
                        viewModel.challengeComplete = true
                    } label: {
                        Text("Got it!")
                            .font(FontSwap.caption2ForTitle3(for: sizeCategory))
                            .bold()
                            .frame(
                                minWidth: 210,
                                idealWidth: 220,
                                maxWidth: 230,
                                minHeight: 50,
                                idealHeight: 60,
                                maxHeight: 70,
                                alignment: .center
                            )
                            .padding([.top, .bottom], 2 )
                            .padding([.leading, .trailing], 12 )
                            .background(Color.koyaGreen )
                            .foregroundColor(.white)
                            .cornerRadius(6)
                    }
                    .buttonStyle(ScaleButtonStyle())
                }
            } // End VStack

            .overlay(viewModel.challengeComplete ? MountainOverlayView() : nil)
            .navigationBarTitle(Text(""))
            .navigationBarHidden(true)
            if viewModel.challengeComplete {
                ChallengeFeedbackView(
                    appData: appData,
                    locationManager: locationManager,
                    challenge: kukaiChallenge, text: "Well Done",
                    points: kukaiChallenge.maxPoints,
                    success: viewModel.success)
                .offset(x: 0.0, y: -40.0)
            }
        } // ZStack root

        .statusBar(hidden: true)
    }
}

struct KukaiChallengeView_Previews: PreviewProvider {
    static var previews: some View {
        KukaiChallengeView()
            .environmentObject(AppData())
            .environmentObject(LocationManager())
            .preferredColorScheme(.light)
    }
}

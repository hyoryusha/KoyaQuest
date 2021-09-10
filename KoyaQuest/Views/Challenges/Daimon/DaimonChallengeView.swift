//
//  DaimonChallengeView.swift
//  KoyaQuest
//
//  Created by Kevin K Collins on 2021/06/04.
//

import SwiftUI

struct DaimonChallengeView: View {
    @EnvironmentObject var appData: AppData
    @EnvironmentObject var locationManager: LocationManager
    @State private var showingGameScene = false
    @State private var gameOver = false
    @State private var points = 0
    @ObservedObject var viewModel = DaimonGameViewModel()
    var buttonText = "Ready to Solve!"
    var body: some View {
        NavigationView {
            ZStack {
                Group {
                    VStack {
                            Text("What's wrong with this picture?")
                                .font(.title2)
                                .foregroundColor(.primary)
                                .padding(.top, 20)
                        Text("Instructions:")
                                .font(.title3)
                                .foregroundColor(.koyaOrange)
                                .bold()
                                .padding(.bottom, 4)
                        Group {
                            // swiftlint:disable:next line_length
                            Text("Zoom and pan around the image, comparing it to the actual Daimon Gate.\nWhen you think you have found the difference, tap the ")
                                    .font(.body)
                                    .foregroundColor(.primary)
                                + Text(buttonText.uppercased())
                                    .font(.body)
                                    .bold()
                                    .foregroundColor(.koyaOrange)
                                    .italic()
                            + Text(" button below to move to the next screen.")
                                .font(.body)
                                .foregroundColor(.primary)
                        }
                        .padding()

                        DaimonZoomableScrollView {
                            Image("daimon_whats_wrong")
                                .resizable()
                                .scaledToFit()
                            Spacer()
                        }

                    }
                }
                .blur(radius: viewModel.isShowingModal ? 6 : 0)
                if viewModel.isShowingModal {
                    ChallengeFeedbackView(
                        appData: appData,
                        locationManager: locationManager,
                        challenge: daimonChallenge,
                        text: viewModel.tapOnTarget ? "Nice Job!" : "Too bad",
                        points: viewModel.points,
                        success: viewModel.tapOnTarget ? true : false)
                }

                VStack {
                    XDismissButtonRight()
                        .padding(.top, 4)
                        .padding(.trailing, 12)
                    Spacer()
                    if !gameOver {
                        NavigationLink(destination: DaimonGameView(
                                        viewModel: viewModel,
                                        gameOver: $gameOver,
                                        points: $points)) {
                            ActionButton(color: Color.koyaOrange, text: buttonText)
                        }
                        .buttonStyle(ScaleButtonStyle())
                        .padding(.bottom, 80)
                    }
                }
                .blur(radius: viewModel.isShowingModal ? 6 : 0)
                Spacer()
                Spacer()
            }
            // .navigationBarTitle(Text(""))
            .navigationBarHidden(true)
            .statusBar(hidden: true)
        }
    }
}

struct DaimonChallengeView_Previews: PreviewProvider {
    static var previews: some View {
        DaimonChallengeView(viewModel: DaimonGameViewModel())
            .environmentObject(AppData())
            .environmentObject(LocationManager())
            .preferredColorScheme(.light)
    }
}

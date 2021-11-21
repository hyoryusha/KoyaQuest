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
    @State private var challengeCompleted: Bool = false
    @State private var success: Bool = false

    var buttonText = "Ready to Solve!"
    var body: some View {
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
                .blur(radius: challengeCompleted ? 6 : 0)

                VStack {
                    XDismissButtonRight()
                        .padding(.top, 4)
                        .padding(.trailing, 12)
                    Spacer()
                    if !gameOver {
                        NavigationLink(destination: DaimonGameView(
                            gameOver: $gameOver,
                            challengeCompleted: $challengeCompleted,
                            success: $success)) {
                                ActionButton(color: Color.koyaOrange, text: buttonText)
                            }
                            .buttonStyle(ScaleButtonStyle())
                            .padding(.bottom, 80)
                    }

                }
                .overlay(challengeCompleted ? MountainOverlayView() : nil)
                Spacer()
                Spacer()
                if challengeCompleted {
                    ChallengeFeedbackView(
                        appData: appData,
                        locationManager: locationManager,
                        challenge: daimonChallenge,
                        text: success ? "Nice Job!" : "Too bad",
                        points: success ? daimonChallenge.maxPoints : 0 ,
                        success: success ? true : false)
                }
            } // end Zstack
            .navigationBarTitle(Text(""))
            .navigationBarHidden(true)
            .statusBar(hidden: true)
    }
}

struct DaimonChallengeView_Previews: PreviewProvider {
    static var previews: some View {
        DaimonChallengeView()
            .environmentObject(AppData())
            .environmentObject(LocationManager())
            .preferredColorScheme(.light)
    }
}

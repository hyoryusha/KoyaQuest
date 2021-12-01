//
//  GenericChallengeViewWithGameScene.swift
//  KoyaQuest
//
//  Created by Kevin K Collins on 2021/11/10.
//

import SwiftUI
import SpriteKit

struct GenericChallengeWithGameSceneView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var appData: AppData
    @EnvironmentObject var locationManager: LocationManager
    @State private var pointsEarned: Int = 0
    @State private var challengeCompleted: Bool = false
    var challenge: Challenge // passed in as param from portal

    var gameScene: SKScene {
        let scene = chooseScene(for: challenge)
        return scene
    }
    var body: some View {
        ZStack {
            GeometryReader { geometry in
                SpriteView(scene: gameScene,
                           transition: .crossFade(
                            withDuration: 1.0
                           )
                )
                    .frame(
                        width: geometry.size.width,
                        height: geometry.size.height
                    )
            }
            .edgesIgnoringSafeArea(.all)
            .blur(radius: challengeCompleted ? 6 : 0)
            .overlay(challengeCompleted ? MountainOverlayView() : nil)

            VStack {
                XDismissButtonRight()
                    .padding(.top, 12)
                    .padding(.trailing, 24)
                Spacer()
            }

            .navigationBarTitle(Text(""))
            .navigationBarHidden(true)
            .statusBar(hidden: true)

            if challengeCompleted {
                ChallengeFeedbackView(
                    appData: appData,
                    locationManager: locationManager,
                    challenge: challenge, text: "Well Done!",
                    points: pointsEarned,
                    success: determineSuccess(pointsEarned: pointsEarned)
                )
            }
        }
    } // end body
    func chooseScene(for challenge: Challenge) -> SKScene {
        switch challenge {
        case saigyoChallenge:
            return SaigyoGameScene($challengeCompleted,
                                   $pointsEarned)
        case nyonindoChallenge:
            return NyonindoGameScene($challengeCompleted,
                                     $pointsEarned)
        case shogunsChallenge:
            return ShogunsGameScene($challengeCompleted,
                                    $pointsEarned)
        case gorintoChallenge:
            return GorintoGameScene($challengeCompleted,
                                    $pointsEarned)
        case numbersChallenge:
            return NumbersChallengeGameScene($challengeCompleted,
                                             $pointsEarned)
        default:
            return SaigyoGameScene($challengeCompleted,
                                   $pointsEarned) // or something else?
        }
    }
    func determineSuccess(pointsEarned: Int) -> Bool {
        if pointsEarned > 0 {
            return true
        } else {
            return false
        }
    }
}

struct GenericChallengeWithGameSceneView_Previews: PreviewProvider {
    static var previews: some View {
        GenericChallengeWithGameSceneView(challenge: numbersChallenge)
    }
}

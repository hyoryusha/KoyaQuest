//
//  NyonindoChallengeView.swift
//  KoyaQuest
//
//  Created by Kevin K Collins on 2021/06/04.
//

import SwiftUI
import SpriteKit

struct NyonindoChallengeView: View {
    @EnvironmentObject var appData: AppData
    @EnvironmentObject var locationManager: LocationManager
    @State private var earnedPoints: Int = 0
    @State private var challengeCompleted: Bool = false

    var gameScene: SKScene {
        let scene = NyonindoGameScene($challengeCompleted, $earnedPoints)
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
//            let earnedPoints = earnedPoints
           // let points = min(nyonindoChallenge.maxPoints, earnedPoints) // gets the lower of the two
            ChallengeFeedbackView(
                appData: appData,
                locationManager: locationManager,
                challenge: nyonindoChallenge, text: "Well Done!",
                points: earnedPoints,
                success: true
            )
        }
    }
}
}

struct NyonindoChallengeView_Previews: PreviewProvider {
    static var previews: some View {
        NyonindoChallengeView()
            .environmentObject(AppData())
            .environmentObject(LocationManager())
    }
}

//
//  SaigyoChallengeView.swift
//  KoyaQuest
//
//  Created by Kevin K Collins on 2021/06/04.
//

import SwiftUI
import SpriteKit

struct SaigyoChallengeView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var appData: AppData
    @EnvironmentObject var locationManager: LocationManager
    @State private var pointsEarned: Int = 0
    @State private var challengeCompleted: Bool = false

    var gameScene: SKScene {
        let scene = SaigyoGameScene($challengeCompleted, $pointsEarned)
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

                    ChallengeFeedbackView(
                        appData: appData,
                        locationManager: locationManager,
                        challenge: saigyoChallenge, text: "Well Done!",
                        points: pointsEarned,
                        success: true
                    )
                }
            }
        } // end body
    }


struct SaigyoChallengeView_Previews: PreviewProvider {
    static var previews: some View {
        SaigyoChallengeView()
            .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
    }
}

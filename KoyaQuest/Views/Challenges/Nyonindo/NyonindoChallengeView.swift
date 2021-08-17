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
    @ObservedObject var viewModel = NyonindoChallengeViewModel()

    var gameScene: SKScene {
        let scene = NyonindoGameScene(
            size: CGSize(
                width: UIScreen.main.bounds.width,
                height: UIScreen.main.bounds.height
            )
        )
        scene.viewModel = self.viewModel
        scene.scaleMode = .aspectFill
        return scene
        }

    var startEndScene: SKScene {
        let scene = NyonindoSummaryScene(size: CGSize(
                                            width: UIScreen.main.bounds.width,
                                            height: UIScreen.main.bounds.height
            )
        )
        scene.viewModel = self.viewModel
        scene.scaleMode = .aspectFill
        return scene
        }

var body: some View {
    ZStack {
        GeometryReader { geometry in
            SpriteView(scene: chooseScene(
                        for: viewModel.completed),
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

        VStack {
            XDismissButtonRight()
                .padding(.top, 4)
                .padding(.trailing, 12)
            Spacer()

        }
        // .blur(radius: viewModel.completed ? 6 : 0)
        .navigationBarTitle(Text(""))
        .navigationBarHidden(true)
        .statusBar(hidden: true)

        if viewModel.completed {
            let earnedPoints = UserDefaults.standard.integer(forKey: "NyonindoHighScore")
            let points = min(nyonindoChallenge.maxPoints, earnedPoints) // gets the lower of the two
            ChallengeFeedbackView(
                appData: appData,
                locationManager: locationManager,
                challenge: nyonindoChallenge, text: "Well Done!",
                points: points,
                success: true
            )
        }
    }
}
    func chooseScene(for completed: Bool) -> SKScene {
        completed ? startEndScene : gameScene
    }
}

struct NyonindoChallengeView_Previews: PreviewProvider {
    static var previews: some View {
        NyonindoChallengeView()
            .environmentObject(AppData())
            .environmentObject(LocationManager())
    }
}

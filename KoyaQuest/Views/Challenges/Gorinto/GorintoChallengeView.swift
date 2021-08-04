//
//  GorintoChallengeView.swift
//  KoyaQuest
//
//  Created by Kevin K Collins on 2021/06/04.
//

import SwiftUI
import SpriteKit

struct GorintoChallengeView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var appData: AppData
    @EnvironmentObject var locationManager: LocationManager
    @ObservedObject var viewModel = GorintoChallengeViewModel()

    var gameScene: SKScene {
        let scene = GorintoGameScene(
            size: CGSize(
                width: UIScreen.main.bounds.width,
                height: UIScreen.main.bounds.height
            )
        )
        scene.viewModel = self.viewModel
        scene.scaleMode = .aspectFill
        return scene
        }

    var summaryScene: SKScene {
        let scene = GorintoSummaryScene(
            size: CGSize(
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
        GeometryReader { proxy in
            SpriteView(
                scene: chooseScene(for: viewModel.solved) ,
                transition: .crossFade(withDuration: 1.0
                )
            )
                .frame(width: proxy.size.width, height: proxy.size.height)
            }
            .edgesIgnoringSafeArea(.all)

        VStack {
            XDismissButtonRight()
                .padding(.trailing, 16)
                .padding(.top, 0)
            Spacer()
        }
        .blur(radius: viewModel.isShowingFeedback ? 6 : 0)
        .navigationBarTitle(Text(""))
        .navigationBarHidden(true)

        if viewModel.isShowingFeedback {
            ChallengeFeedbackView(
                appData: appData,
                locationManager: locationManager,
                challenge: gorintoChallenge, text: "Success",
                points: viewModel.points,
                success: viewModel.solved
            )
        }
    }
}
    func chooseScene(for solved: Bool) -> SKScene {
        solved ? summaryScene: gameScene
    }
}

struct GorintoChallengeView_Previews: PreviewProvider {
    static var previews: some View {
        GorintoChallengeView()
    }
}

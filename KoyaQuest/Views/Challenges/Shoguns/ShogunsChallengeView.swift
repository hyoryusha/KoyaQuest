//
//  ShogunsChallengeView.swift
//  KoyaQuest
//
//  Created by Kevin K Collins on 2021/06/04.
//

import SwiftUI
import SpriteKit

struct ShogunsChallengeView: View {
    @EnvironmentObject var appData: AppData
    @EnvironmentObject var locationManager: LocationManager
    @ObservedObject var viewModel = ShogunsChallengeViewModel()

        var gameScene: SKScene {
            let scene = ShogunsGameScene(
                size: CGSize(width: UIScreen.main.bounds.width,
                             height: UIScreen.main.bounds.height)
            )
            scene.viewModel = self.viewModel
            scene.scaleMode = .aspectFill
            return scene
            }

        var summaryScene: SKScene {
            let scene = ShogunsSummaryScene(
                size: CGSize(width: UIScreen.main.bounds.width,
                             height: UIScreen.main.bounds.height)
            )
            scene.viewModel = self.viewModel
            scene.scaleMode = .aspectFill
            return scene
            }

    var body: some View {
        ZStack {
            SpriteView(
                scene: chooseScene(for: viewModel.solved),
                transition: .crossFade(withDuration: 1.5)
            )
                .edgesIgnoringSafeArea(.all)
            .blur(radius: viewModel.solved ? 6 : 0)
            VStack {
                XDismissButtonRight()
                    .offset(x: -4, y: -6 )
                    .padding(.top, 10)
                    .padding(.trailing, 10)
                Spacer()
            }
            .blur(radius: viewModel.solved ? 6 : 0)
            if viewModel.solved {
                ChallengeFeedbackView(
                    appData: appData,
                    locationManager: locationManager,
                    challenge: shogunsChallenge,
                    text: viewModel.matches > 0 ? "Well Done": "Too bad",
                    points: viewModel.points,
                    success: viewModel.matches > 0 ? true : false
                )
            }
        }
        .navigationBarTitle(Text(""))
        .navigationBarHidden(true)

    }
    func chooseScene(for solved: Bool) -> SKScene {
        solved ?  summaryScene : gameScene
        }
    }

struct ShogunsChallengeView_Previews: PreviewProvider {
    static var previews: some View {
        ShogunsChallengeView()
            .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
    }
}

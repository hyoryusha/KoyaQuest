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
    @ObservedObject var viewModel = SaigyoChallengeViewModel()
    @State private var isShowingModal = false

    var gameScene: SKScene {
        let scene = SaigyoGameScene(
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
        let scene = SaigyoSummaryScene(
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
            SpriteView(scene: chooseScene(
                        for: viewModel.solved),
                       transition: .crossFade(withDuration: 1.5)
            )
                .edgesIgnoringSafeArea(.all)
            .blur(radius: isShowingModal ? 6 : 0)
            VStack {
                XDismissButtonRight()
                    .offset(x: 0, y: -14)
                    .padding(.top, 0)
                    .padding(.trailing, 10)
                Spacer()
                if viewModel.solved
                    && !isShowingModal {
                    Text("Success!".uppercased())
                        .font(.title)
                        .foregroundColor(.koyaGreen)
                    Button {
                        isShowingModal = true
                    } label: {
                        ActionButton(color: .koyaOrange, text: "Got it!")
                    }
                }
                if isShowingModal {
                    ChallengeFeedbackView(appData: appData,
                                      locationManager: locationManager,
                                      challenge: saigyoChallenge,
                                      text: viewModel.solved ? "Nice work" : "Zannen!",
                                      points: viewModel.points,
                                      success: viewModel.solved ? true : false)
                    Spacer()
                    }
            }
            .navigationBarTitle(Text(""))
            .navigationBarHidden(true)
            .statusBar(hidden: true)
        }
    }
    func chooseScene(for solved: Bool) -> SKScene {
        solved ?  summaryScene : gameScene
    }
}

struct SaigyoChallengeView_Previews: PreviewProvider {
    static var previews: some View {
        SaigyoChallengeView()
            .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
    }
}

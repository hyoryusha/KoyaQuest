//
//  NumbersChallengeView.swift
//  KoyaQuest
//
//  Created by Kevin K Collins on 2021/06/04.
//

import SwiftUI
import SpriteKit

struct NumbersChallengeView: View {
    @Environment(\.sizeCategory) var sizeCategory: ContentSizeCategory
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var appData: AppData
    @EnvironmentObject var locationManager: LocationManager
    @ObservedObject var viewModel = NumbersChallengeViewModel()

    var gameScene: SKScene {
        let scene = NumbersChallengeGameScene(
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
            BackgroundView()
            if !viewModel.complete {
                GeometryReader { geometry in
                    SpriteView( scene: gameScene)
                        .frame(width: geometry.size.width, height: geometry.size.height)
                    }
                    .edgesIgnoringSafeArea(.all)
            }

            VStack {
                XDismissButtonRight()
                    .padding(.trailing, 16)
                    .padding(.top, 0)
                Spacer()
                //.frame(height: 420)
                    Text("Tap on a tile to reveal the other side.\nMatch tiles to remove and score points.")
                        .font(wideElement(sizeCategory: sizeCategory) ? .caption2 : .body)
                        .multilineTextAlignment(.center)
                        .foregroundColor(.white)
                        .padding(.bottom, 80)

                //Spacer()
            }
            // .blur(radius: viewModel.complete ? 6 : 0)
            .navigationBarTitle(Text(""))
            .navigationBarHidden(true)

            if viewModel.complete {
                ChallengeFeedbackView(
                    appData: appData,
                    locationManager: locationManager,
                    challenge: numbersChallenge, text: "Success",
                    points: viewModel.points,
                    success: viewModel.complete
                )
            }
        }
}

}
struct NumbersChallengeView_Previews: PreviewProvider {
    static var previews: some View {
        NumbersChallengeView()
            .preferredColorScheme(.dark)
    }
}

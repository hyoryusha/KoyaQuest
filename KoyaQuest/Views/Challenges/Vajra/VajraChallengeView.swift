//
//  VajraChallengeView.swift
//  KoyaQuest
//
//  Created by Kevin K Collins on 2021/06/04.
//

import SwiftUI

struct VajraChallengeView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var appData: AppData
    @EnvironmentObject var locationManager: LocationManager
    // @ObservedObject var challengeDisplayViewModel: ChallengeDisplayViewModel
    @StateObject var viewModel = VajraChallengeViewModel()

    var body: some View {
        ZStack {
            BackgroundView()
                .ignoresSafeArea(.all)
            VStack {
                
                XDismissButtonRight()
                    .padding(.top, 4)
                    .padding(.trailing, 8)
                HStack {
                    Image(systemName: "eyes") //camera.viewfinder
                    Text("Search for the Vajra!")
                }
                .frame(
                    minWidth: 320,
                    idealWidth: 420,
                    maxWidth: 420,
                    minHeight: 32,
                    idealHeight: 50,
                    maxHeight: 52,
                    alignment: .center
                )
                .foregroundColor(.koyaOrange)
                .font(.title)
                .padding(.bottom, 6)
                Spacer()
                VajraFinderView(viewModel: self.viewModel, found: $viewModel.found)
                    .foregroundColor(.gray)
                    .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                    .frame(
                        minWidth: 320,
                        idealWidth: 400,
                        maxWidth: 412,
                        minHeight: 320,
                        idealHeight: 520,
                        maxHeight: 536,
                        alignment: .center
                    )
                    .padding(.bottom, 20)

                Text("Move around the area where you think the sceptre might be.")
                    .font(.footnote)
                    .foregroundColor(.white)
                    .padding(.bottom, 6)
                Text(viewModel.statusText)
                    .font(.title3)
                    .foregroundColor(viewModel.statusTextColor)
                if viewModel.found {
                    Text("Line up the sight and tap the target to capture the Vajra.")
                        .font(.callout)
                        .foregroundColor(.koyaOrange)
                        .italic()
                }
                Text("Distance to target:")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding(.top)
                ZStack {
                    //Color.red.frame(width: 210, height: 66)
                    Text(viewModel.distance == 0 ? "" : viewModel.proximity)
                        .font(.largeTitle)
                        .foregroundColor(.white)
                        .frame(
                            width: 210,
                            height: 66,
                            alignment: .center
                        )
                        .background(viewModel.distanceIndicatorColor)
                        .padding(.top, 10)

                }

            } // end VStack
            .blur(radius: viewModel.isShowingModal ? 6 : 0)
            .navigationBarTitle(Text(""))
            .navigationBarHidden(true)
            if viewModel.isShowingModal {
                ChallengeFeedbackView(
                    appData: appData,
                    locationManager: locationManager,
                    challenge: vajraChallenge,
                    text: viewModel.zapped ? "Nice Job!" : "Too bad",
                    points: vajraChallenge.maxPoints,
                    success: viewModel.zapped ? true : false)
            }
        } // end ZStack
        .statusBar(hidden: true)
    }
}

struct VajraChallengeView_Previews: PreviewProvider {
    static var previews: some View {
        VajraChallengeView()
            .preferredColorScheme(.light)
    }
}

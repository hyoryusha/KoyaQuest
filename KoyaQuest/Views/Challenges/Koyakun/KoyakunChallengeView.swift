//
//  KoyakunChallengeView.swift
//  KoyaQuest
//
//  Created by Kevin K Collins on 2021/06/04.
//

import SwiftUI

struct KoyakunChallengeView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var appData: AppData
    @EnvironmentObject var locationManager: LocationManager
    @StateObject var viewModel = KoyakunChallengeViewModel()

    var body: some View {
        ZStack {
            KoyakunCatcherView(viewModel: self.viewModel,
                               completed: $viewModel.completed)
                // Rectangle()
            VStack {
                XDismissButtonRight()
                    .offset(x: 0, y: 0 )
                    .padding(.top, 20)
                    .padding(.trailing, 30)
                Spacer()
            }
            //.blur(radius: viewModel.completed ? 6 : 0)
            if viewModel.completed {
                let earnedPoints = viewModel.points
                let points = min(koyakunChallenge.maxPoints, earnedPoints)
                ChallengeFeedbackView(
                    appData: appData,
                    locationManager: locationManager,
                    challenge: koyakunChallenge, text: "Nice job!",
                    points: points,
                    success: viewModel.completed
                )
            }
        }
        .ignoresSafeArea(.all)
        .navigationBarTitle(Text(""))
        .navigationBarHidden(true)
    }
}

struct KoyakunChallengeView_Previews: PreviewProvider {
    static var previews: some View {
        KoyakunChallengeView()
            .environmentObject(AppData())
            .environmentObject(LocationManager())
            .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
    }
}

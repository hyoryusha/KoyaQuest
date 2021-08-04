//
//  KukaiChallengeView.swift
//  KoyaQuest
//
//  Created by Kevin K Collins on 2021/06/04.
//

import SwiftUI

struct KukaiChallengeView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var appData: AppData
    @EnvironmentObject var locationManager: LocationManager
    @StateObject var viewModel = KukaiChallengeViewModel()

    var body: some View {
        ZStack {
            VStack {
                XDismissButtonRight()
                    .padding(.top, 4)
                    .padding(.trailing, 8)

                HStack {
                    Image(systemName: "camera.viewfinder")
                    Text("Find Kūkai")
                }
                .font(.title)
                .foregroundColor(.orange)
                .padding(.bottom, 6)

                Text("Point your camera at the image when you find it.")
                    .font(.footnote)
                    .foregroundColor(.secondary)
                    KukaiFinderView(foundImage: $viewModel.foundImage, success: $viewModel.success)
                        // Rectangle()
                        .frame(height: 380)
                            .padding(.bottom, 6)
                    Text(viewModel.statusText)
                        .font(.title3)
                        .foregroundColor(viewModel.statusTextColor)
                        .padding()
                    Spacer()
            } // End VStack
            .blur(radius: viewModel.success ? 6 : 0)
            .navigationBarTitle(Text(""))
            .navigationBarHidden(true)
            
            if viewModel.success {
                ChallengeFeedbackView(
                    appData: appData,
                    locationManager: locationManager,
                    challenge: kukaiChallenge, text: "Well Done",
                    points: kukaiChallenge.maxPoints,
                    success: viewModel.success)
            }
        } // End ZStack?
    }
}

struct KukaiChallengeView_Previews: PreviewProvider {
    static var previews: some View {
        KukaiChallengeView()
            .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
    }
}

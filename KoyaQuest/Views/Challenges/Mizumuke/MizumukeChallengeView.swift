//
//  MizumukeChallengeView.swift
//  KoyaQuest
//
//  Created by Kevin K Collins on 2021/06/04.
//

import SwiftUI
import UIKit

struct MizumukeChallengeView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var appData: AppData
    @EnvironmentObject var locationManager: LocationManager
    @ObservedObject var viewModel = MizumukeChallengeViewModel()
    @State private var columns: [Int] = []
       var body: some View {
        ZStack {
                BackgroundView()
                    .ignoresSafeArea(.all)
            
            VStack {
                XDismissButtonRight()
                    .padding(.top, 12)
                    .padding(.trailing, 18)

                Text("Mizumuke Jizō Challenge")
                    .font(.title)
                    .bold()
                    .foregroundColor(.koyaOrange)
                Text("Place the Images in Order")
                    .font(.title3)
                    .bold()
                    .foregroundColor(.white)

                Text("Test your powers of observation.")
                    .font(.headline)
                    .foregroundColor(.koyaOrange)
                    .italic()
                    .multilineTextAlignment(.center)
                Text("Find the matching statues alongside the river.")
                    .font(.body)
                    .foregroundColor(.white)
                    .italic()
                    .multilineTextAlignment(.center)
                    .padding()

                SilhouettePickerView(cols: $columns)
                    .frame(width: 310, height: 200, alignment: .center)
                    .padding(.bottom, 30)

                Text("Swipe images up or down to put the them in the correct order")
                    .font(.body)
                    .foregroundColor(.koyaDarkText)
                    .italic()
                    .multilineTextAlignment(.center)
                    .padding()

                    Button {
                        viewModel.check(columns: columns)
                    } label: {
                        ActionButton(color: .koyaOrange, text: "Check")
                    }
                    Text(viewModel.feedbackString)
                            .font(.caption)
                            .foregroundColor(.secondary)
                            .animation(.easeIn(duration: 0.3))
                Spacer()
                }
            .blur(radius: viewModel.solved ? 6 : 0)
            .navigationBarTitle(Text(""))
            .navigationBarHidden(true)
            // .statusBar(hidden: true)

            if viewModel.solved {
                ChallengeFeedbackView(
                    appData: appData,
                    locationManager: locationManager,
                    challenge: mizumukeChallenge,
                    text: viewModel.summaryString,
                    points: viewModel.points,
                    success: viewModel.solved
                )
            }
        } // end ZStack
       }
}
struct MizumukeChallengeView_Previews: PreviewProvider {
    static var previews: some View {
        MizumukeChallengeView()
            .environmentObject(AppData())
            .environmentObject(LocationManager())
            .preferredColorScheme(.light)
    }
}

//
//
//  Created by Kevin K Collins on 2021/05/29.
//

import SwiftUI

struct ChallengeFeedbackView: View {
    @Environment(\.sizeCategory) var sizeCategory: ContentSizeCategory
    var appData: AppData
    var locationManager: LocationManager
    var challenge: Challenge
    var text: String
    var points: Int
    var success: Bool

    var body: some View {

        VStack {
            Image(FeedbackConstants.randomImage())
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 360, height: 200)
                .clipped()
                .overlay(FeedbackOverlayView(type: .challenge, success: success))
                .foregroundColor(.white)
            Button {
                appData.showChallenge()
                appData.recordCompletedChallenge(challenge: challenge, points: points)
                locationManager.resumeRegionMonitoring()
                appData.challengeState = .idle
                challenge.completed = true
                if challenge == kukaiChallenge {
                    appData.isShowingResumeKukaiChallenge = false
                }
            } label: {

                if #available(iOS 15.0, *) {
                    Text("Tap to claim \(points) Points")
                        .font(.title3)
                        .bold()
                        .frame(
                            minWidth: 180,
                            idealWidth: 200,
                            maxWidth: 210,
                            minHeight: 50,
                            idealHeight: 60,
                            maxHeight: 70,
                            alignment: .center
                        )
                        .padding([.top, .bottom], 2 )
                        .padding([.leading, .trailing], 12 )
                        .background(Color.koyaOrange)
                        .foregroundColor(.white)
                        .cornerRadius(6)
                } else {
                    // Fallback on earlier versions
                    Text("Tap to claim \(points) Points")
                        .font(.title3)
                        .bold()
                        .frame(
                            minWidth: 180,
                            idealWidth: 200,
                            maxWidth: 210,
                            minHeight: 50,
                            idealHeight: 60,
                            maxHeight: 70,
                            alignment: .center
                        )
                        .padding([.top, .bottom], 2 )
                        .padding([.leading, .trailing], 12 )
                        .background(success ? Color.koyaOrange : .koyaRed)
                        .foregroundColor(.white)
                        .cornerRadius(6)
                }
            }
            .buttonStyle(ScaleButtonStyle())
            .padding()
            Spacer()
        }

        .background(Color.black)
        .frame(width: 320, height: 320)
        .cornerRadius(12)
        .shadow(color: .koyaPurple.opacity(0.35), radius: 0.5, x: 12, y: 12 )
    }
}

struct FeedbackModalView_Previews: PreviewProvider {
    static var previews: some View {
        ChallengeFeedbackView(
            appData: AppData(),
            locationManager: LocationManager(),
            challenge: daimonChallenge, text: "Success",
            points: 10,
            success: true
        )
    }
}

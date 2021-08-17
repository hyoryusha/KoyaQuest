//
//
//  Created by Kevin K Collins on 2021/05/29.
//

import SwiftUI

struct ChallengeFeedbackView: View {
    @Environment(\.sizeCategory) var sizeCategory: ContentSizeCategory
    var appData: AppData
    var locationManager: LocationManager
    // var challengeDisplayViewModel: ChallengeDisplayViewModel
    var challenge: Challenge
    var text: String
    var points: Int
    var success: Bool

    var body: some View {
        VStack {
            Image(success ? "correct_banner" : "fail_banner")
                .resizable()
                .frame(height: 100)
                .cornerRadius(0)
                .overlay(FeedbackBannerOverlay(text: text))
            Spacer()
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
                Text("Exit with \(points) Points")
                    .font(wideElement(sizeCategory: sizeCategory) ? .caption : .title3)
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
            .buttonStyle(ScaleButtonStyle())
            Spacer()
        }
        .frame(width: 300, height: 200)
        .background(Color.koyaSky)
        .cornerRadius(12)
        .shadow(radius: 40)
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

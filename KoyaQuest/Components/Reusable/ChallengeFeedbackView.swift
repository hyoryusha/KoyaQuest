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

    var feedbackImages = ["fb_oku-no-in", "fb_bronze_komainu" , "fb_lone_priest" , "fb_six_priests" , "fb_shojingu_snow" , "fb_daito_interior" , "fb_gobyo_bridge" , "fb_four_lanterns"]

    var body: some View {

            VStack {
                Image(randomImage())
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 360, height: 200)
                    .clipped()
                    .overlay(FeedbackOverlayView(success: success))
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
                        Text("Exit with \(points) Points")
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
                        Text("Exit with \(points) Points")
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
                Spacer()
                Text("(tap above button to continue)")
                    .font(.caption2)
                    .foregroundColor(.gray)
                    .padding(.bottom)
                //.buttonStyle(ScaleButtonStyle())

            }

            .background(Color.black)
         //   .background(
           //     LinearGradient(gradient: Gradient(colors: [.black, .purple, .black]), //startPoint: .top, endPoint: .bottom)
          //      )
            .frame(width: 360, height: 320)
            .cornerRadius(12)
            .shadow(color: .black, radius: 20, x: 10, y: 10)
    }
    func randomImage() -> String {
        let index = Int.random(in: 0...feedbackImages.count - 1)
        return feedbackImages[index]
    }
}
//    var body: some View { ORIGINAL
//        VStack {
//            Image(success ? "correct_banner" : "fail_banner")
//                .resizable()
//                .frame(height: 100)
//                .cornerRadius(0)
//                .overlay(FeedbackBannerOverlay(text: text))
//            Spacer()
//            Button {
//                appData.showChallenge()
//                appData.recordCompletedChallenge(challenge: challenge, points: points)
//                locationManager.resumeRegionMonitoring()
//                appData.challengeState = .idle
//                challenge.completed = true
//                if challenge == kukaiChallenge {
//                    appData.isShowingResumeKukaiChallenge = false
//                }
//            } label: {
//                Text("Exit with \(points) Points")
//                    .font(wideElement(sizeCategory: sizeCategory) ? .caption : .title3)
//                    .bold()
//                    .frame(
//                        minWidth: 180,
//                        idealWidth: 200,
//                        maxWidth: 210,
//                        minHeight: 50,
//                        idealHeight: 60,
//                        maxHeight: 70,
//                        alignment: .center
//                    )
//                    .padding([.top, .bottom], 2 )
//                    .padding([.leading, .trailing], 12 )
//                    .background(success ? Color.koyaOrange : .koyaRed)
//                    .foregroundColor(.white)
//                    .cornerRadius(6)
//            }
//            .buttonStyle(ScaleButtonStyle())
//            Spacer()
//        }
//        .frame(width: 300, height: 200)
//        .background(Color.koyaSky)
//        .cornerRadius(12)
//        .shadow(radius: 40)
//        }
//    }

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

//
//  ChallengePortalView.swift
//  KoyaQuest
//
//  Created by Kevin K Collins on 2021/06/04.
//

import SwiftUI

struct ChallengePortalView: View {
    @EnvironmentObject var appData: AppData
    @EnvironmentObject var locationManager: LocationManager
    @Binding var isShowingChallengePortal: Bool
    var challenge: Challenge
    var body: some View {
    NavigationView {
        ZStack {
            BackgroundView()

            VStack(spacing: 20) {
                HStack {
                    Spacer()
                    Button(action: hideChallenge) {
                        Image(systemName: "xmark")
                            .font(.caption2)
                            .foregroundColor(Color.white)
                            .frame(
                                width: 24,
                                height: 24,
                                alignment: .center
                            )
                            .foregroundColor(Color.white)
                            .background(
                                Circle()
                                    .fill(Color.koyaOrange)
                            )
                            .padding(.top, 10)
                            .padding(.trailing, 16)
                            .padding(.bottom, 0)
                    }
                }
                ScrollView {
                    Text(challenge.name)
                        .foregroundColor(.white)
                        .font(.title)
                        .bold()
                        .multilineTextAlignment(.center)
                    Text(challenge.details.teaser)
                        .foregroundColor(.gray)
                        .font(.body)
                        .bold()
                        .italic()
                        .multilineTextAlignment(.center)
                        .padding()
                    if challenge.details.imageName != "" {
                        Image(challenge.details.imageName)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 260)
                    }

                    Text(challenge.details.instructions)
                        .bodyStyle(color: .white)
                    if challenge.details.extra != "" {
                        Divider()
                            .background(Color.koyaOrange)
                        Text(challenge.details.extra)
                            .bodyStyle(color: .white)
                        }
                    } // end scroll
                .padding([.leading, .trailing, .bottom], 8)
                NavigationLink(destination: subView()) {
                    ActionButton(color: Color.koyaOrange, text: "Begin Challenge")
                        .buttonStyle(ScaleButtonStyle())
                }
                .simultaneousGesture(TapGesture().onEnded {
                    appData.challengeState = .active
                    locationManager.pauseRegionMonitoring()
                })
                Spacer()
                    .frame(height: 24)
            }// end vstack
        }
        .navigationBarTitle(Text(""))
        .navigationBarHidden(true)
    }
        .statusBar(hidden: true)
    }
    func subView() -> some View {
        switch challenge {
        case daimonChallenge:
            return AnyView(DaimonChallengeView())
        case vajraChallenge:
            return AnyView(VajraChallengeView())
        case nyonindoChallenge:
            return AnyView(NyonindoChallengeView())
        case gorintoChallenge:
            return AnyView(GorintoChallengeView())
        case mizumukeChallenge:
            return AnyView(MizumukeChallengeView())
        case kukaiChallenge:
            return AnyView(KukaiChallengeView())
        case saigyoChallenge:
            return AnyView(SaigyoChallengeView())
        case choishiChallenge:
            return AnyView(ChoishiChallengeView())
        case numbersChallenge:
            return AnyView(NumbersChallengeView())
        case shogunsChallenge:
            return AnyView(ShogunsChallengeView())
        case koyakunChallenge:
            return AnyView(KoyakunChallengeView())
        case kenshinChallenge:
            return AnyView(KenshinChallengeView())
        default:
            return AnyView(MainMenuView(landmark: Landmark.allLandmarks[0])) // is EmptyView okay?
        }
    }
    func hideChallenge() {
        isShowingChallengePortal = false
        locationManager.resumeRegionMonitoring()
    }
}

struct ChallengePortalView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ChallengePortalView(
                isShowingChallengePortal: .constant(true),
                challenge: numbersChallenge
            )
                .preferredColorScheme(.dark)
        }
    }
}

//
//  KenshinChallengeView.swift
//  KoyaQuest
//
//  Created by Kevin K Collins on 2021/06/04.
//

import SwiftUI

struct KenshinChallengeView: View {
    @Environment(\.sizeCategory) var sizeCategory: ContentSizeCategory
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var appData: AppData
    @EnvironmentObject var locationManager: LocationManager
    @StateObject var viewModel = KenshinChallengeViewModel()
    @State var activeSheet: ActiveSheet?

    var body: some View {
        ZStack {
            //Color(.black)
            BackgroundView()
                .ignoresSafeArea(.all)
            VStack {
                XExitButtonRight(didExitChallenge: $viewModel.didExitChallenge)
                    .padding(.trailing, 16)
                HStack {
                    Image(systemName: "camera.viewfinder")
                    Text(viewModel.didFindGhost ? "You Found the Ghost" : "Look for the Ghost")
                }
                .font(.title)
                .foregroundColor(.koyaOrange)
                .padding([.bottom, .top], 6)

                Text(viewModel.didFindGhost ? "" : "The spirit of Uesugi Kenshin has a message for you!")
                    .font(.callout)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.white)
                    .padding()

                if viewModel.didConcludeVideo {
                    Image(viewModel.success ? "uesugi_summary": "takeda shingen haka")
                        .resizable()
                        .aspectRatio(contentMode: .fit)

                    .frame(width: 320)
                        .padding(.bottom, 6)
                        .animation(.easeIn(duration: 0.8), value: true)
                    Text(viewModel.success ? "Well done!" : "Your next destination")
                        .font(.callout)
                        .foregroundColor(.white)
                        .padding(.bottom, 6)
                } else {
                    KenshinFinderView(
                        didFindGhost: $viewModel.didFindGhost,
                        instructions: $viewModel.instructions,
                        didCompleteVideo: $viewModel.didConcludeVideo
                    )
                        // Rectangle()
                        .frame(height: 380) // previous 380
                        .transition(.move(edge: .leading))
                        .padding(.bottom, 6)

                    Text(viewModel.didFindGhost ? "Listen for your instructions.\nMove closer for better viewing." : viewModel.instructions)
                        .multilineTextAlignment(.center)
                        .font(.caption)
                        .foregroundColor(.white)
                        .padding()
                }

                if viewModel.didConcludeVideo && viewModel.success == false { // found Uesugi & watched video
                            Button {
                                // viewMission = true
                                activeSheet = .first
                            } label: {
                                HStack {
                                    Image(systemName: "signpost.right")
                                        .font(.body)
                                        .foregroundColor(.koyaOrange)

                                    Text("Review Your Mission")
                                        .font(.body)
                                        .foregroundColor(.koyaOrange)
                                        .bold()
                                }
                            }
                            .padding(.bottom, 6)

                            Button {
                                activeSheet = .second
                            } label: {
                                HStack {
                                    Image(systemName: "figure.walk")
                                        .foregroundColor(.green)
                                    Text("Proceed to Next Step".uppercased())
                                        .font(.title3)
                                        .bold()
                                        .foregroundColor(.green)
                                }
                            }
                        }
                                if viewModel.success {
                                    Button {
                                        self.presentationMode.wrappedValue.dismiss()
                                        appData.recordCompletedChallenge(
                                            challenge: kenshinChallenge,
                                            points: kenshinChallenge.maxPoints
                                        )
                                        appData.challengeState = .idle
                                        locationManager.resumeRegionMonitoring()
                                    } label: {
                                        Text("Exit and Claim \(kenshinChallenge.maxPoints) Points".uppercased())
                                            .font(wideElement(sizeCategory: sizeCategory) ? .caption2 : .title3)
                                            .bold()
                                            .frame(
                                                minWidth: 235,
                                                idealWidth: 300,
                                                maxWidth: 342,
                                                minHeight: 50,
                                                idealHeight: 50,
                                                maxHeight: 50,
                                                alignment: .center
                                            )
                                            .padding([.top, .bottom], 2 )
                                            .padding([.leading, .trailing], 14 )
                                            .background(Color.koyaGreen)
                                            .foregroundColor(.white)
                                            .padding()
                                    }

                                } else {
                                    EmptyView()
                                        .frame(
                                            minHeight: 50,
                                            idealHeight: 50,
                                            maxHeight: 50,
                                            alignment: .center
                                        )
                                }
                Spacer()
            } // end vstack
            .padding(.top, 10)
        }
        .fullScreenCover(item: $activeSheet) { item in
            switch item {
            case .first, .none: // added "none" when creating GameOverView
                KenshinMissionView()
                    .transition(.move(edge: .bottom))
            case .second:
                TakedaChallengeView(success: $viewModel.success)
                    .transition(.move(edge: .trailing))
            case .third:
                KenshinMoreInfoView()
                    .transition(.move(edge: .bottom))
            }
        }
        .navigationBarTitle(Text(""))
        .navigationBarHidden(true)
        .statusBar(hidden: true)
    }
}

struct KenshinChallengeView_Previews: PreviewProvider {
    static var previews: some View {
        KenshinChallengeView()
            .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
    }
}

//
//  ChoishiChallengeView.swift
//  KoyaQuest
//
//  Created by Kevin K Collins on 2021/06/19.
//

import SwiftUI

struct ChoishiChallengeView: View {
    @Environment(\.sizeCategory) var sizeCategory: ContentSizeCategory
    @EnvironmentObject var appData: AppData
    @EnvironmentObject var locationManager: LocationManager
    @ObservedObject var viewModel = ChoishiChallengeViewModel()
    @State private var selection = 16
    @State private var isShowingHint = false
    @State private var isShowingAlert = false

    var body: some View {
        ZStack {
            BackgroundView()
                .ignoresSafeArea(.all)
            VStack {
                if viewModel.gameOver {
                    Image("choishi_solution")
                        .resizable()
                        .scaledToFit()
                        .cornerRadius(3.0)
                    Button {
                        appData.showChallenge()
                        appData.recordCompletedChallenge(challenge: choishiChallenge, points: viewModel.points)
                        locationManager.resumeRegionMonitoring()
                        appData.challengeState = .idle
                        choishiChallenge.completed = true
                    } label: {
                        Text("Exit \(viewModel.feedbackString) \(viewModel.points) Points")
                            .font(wideElement(sizeCategory: sizeCategory) ? .caption2 : .title3)
                            .bold()
                            .frame(
                                minWidth: 210,
                                idealWidth: 220,
                                maxWidth: 230,
                                minHeight: 50,
                                idealHeight: 60,
                                maxHeight: 70,
                                alignment: .center
                            )
                            .padding([.top, .bottom], 2 )
                            .padding([.leading, .trailing], 12 )
                            .background(viewModel.points > 0 ? Color.koyaGreen : Color.koyaRed)
                            .foregroundColor(.white)
                            .cornerRadius(6)
                    }
                    .buttonStyle(ScaleButtonStyle())

                } else {
                    Text("Chōishi Challenge")
                        .font(wideElement(sizeCategory: sizeCategory) ? .caption : .title)
                        .foregroundColor(.koyaOrange)
                        .bold()
                    ChoishiStarterView(isShowingAlert: $isShowingAlert, selection: $selection, viewModel: viewModel)
                }

            } // end vstack
            .sheet(isPresented: $isShowingHint, onDismiss: {}, content: {
                ChoishiHintView(isShowingHint: $isShowingHint)
            })
            .alert(isPresented: $isShowingAlert) {
                Alert(
                    title: Text("Warning"),
                    // swiftlint:disable:next line_length
                    message: Text("If you choose to use a hint, you will not be able to earn full points for this challenge."),
                    primaryButton: .destructive(Text("Show Hint")) {
                        isShowingHint = true
                        viewModel.hintUsed = true
                    },
                    secondaryButton: .cancel(Text("No, thank you."))
                )
            }
            .padding(.top, 32)
        } // end zStack
        .statusBar(hidden: true)
    }
}

struct ChoishiChallengeView_Previews: PreviewProvider {
    static var previews: some View {
        ChoishiChallengeView()
            .preferredColorScheme(.light)
    }
}

struct ChoishiStarterView: View {
    @Environment(\.sizeCategory) var sizeCategory: ContentSizeCategory
    @Binding var isShowingAlert: Bool
    @Binding var selection: Int
    var viewModel: ChoishiChallengeViewModel
    var body: some View {
        Text("Decipher the number of the stone column.")
            .font(wideElement(sizeCategory: sizeCategory) ? .caption2 : .subheadline)
            .foregroundColor(.white)
        Image("choishi_?")
            .resizable()
            .scaledToFit()
            .frame(height: wideElement(sizeCategory: sizeCategory) ? 140 : 180)
        // swiftlint:disable:next line_length
        Text("The chōishi seen above is one of thirty-six that lead from the Danjō Garan to Oku-no-in.\nFind it and determine which number it is.\nChoose from the picker view below.")
            .font(wideElement(sizeCategory: sizeCategory) ? .caption2 : .subheadline)
            .multilineTextAlignment(.center)
            .padding(4)

            Button {
                isShowingAlert = true
            } label: {
                HStack {
                    Image(systemName: "key.fill")
                    Text("View Hint")
                        .bold()

                }
                .font(wideElement(sizeCategory: sizeCategory) ? .caption2 : .headline)
                .foregroundColor(.koyaRed)
                .padding(2)
            }
            .buttonStyle(ScaleButtonStyle())
        ZStack {
            Image("choishi_white_on_gray")
                .resizable()
                .scaledToFit()
            Picker("", selection: $selection) {
                ForEach(viewModel.numbers, id: \.self) {
                                Text("\($0)")
                                    .foregroundColor(.black)
                            }
                        }

            }
        Button {
            viewModel.check(selection: selection)
        } label: {
        ActionButton(color: Color.koyaOrange, text: "Check Answer")
        }
    }
}

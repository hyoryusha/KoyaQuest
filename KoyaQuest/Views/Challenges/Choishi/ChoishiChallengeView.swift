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
                XDismissButtonRight()
                    .padding(.top, 0)
                    .padding(.trailing, 16)
                if viewModel.gameOver {
                    Image("choishi_solution")
                        .resizable()
                        .scaledToFit()
                        .cornerRadius(3.0)
                    Button {
                        viewModel.challengeCompleted = true
                    } label: {
                        Text("Got it!")
                            .font(FontSwap.caption2ForTitle3(for: sizeCategory))
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
                    Text("Ch??ishi Challenge")
                        .font(FontSwap.caption2ForTitle(for: sizeCategory))
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
            .overlay(viewModel.challengeCompleted ? MountainOverlayView() : nil)
            if viewModel.challengeCompleted {
                ChallengeFeedbackView(
                    appData: appData,
                    locationManager: locationManager,
                    challenge: choishiChallenge,
                    text: viewModel.success ? "Nice Job!" : "Too bad",
                    points: viewModel.points,
                    success: viewModel.success ? true : false
                )
                .offset(x: 0.0, y: -40.0)
            }
        } // end zStack
        .navigationBarTitle(Text(""))
        .navigationBarHidden(true)
        .statusBar(hidden: true)
    }
}

struct ChoishiChallengeView_Previews: PreviewProvider {
    static var previews: some View {
        ChoishiChallengeView()
            .preferredColorScheme(.dark)
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
            .frame(height: wideElement(sizeCategory: sizeCategory) ? 120 : 140)
        // swiftlint:disable:next line_length
        Text("The ch??ishi seen above is one of thirty-six that lead from the Danj?? Garan to Oku-no-in.\nFind it and determine which number it is.\nChoose from the picker view below.")
            .font(wideElement(sizeCategory: sizeCategory) ? .caption2 : .caption)
            .foregroundColor(.white)
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
            .font(FontSwap.caption2ForSubheadline(for: sizeCategory))
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
            .pickerStyle(.wheel)
        }
        Button {
            viewModel.check(selection: selection)
        } label: {
            ActionButton(color: Color.koyaOrange, text: "Check Answer")
        }
        .navigationBarTitle(Text(""))
        .navigationBarHidden(true)
    }
}

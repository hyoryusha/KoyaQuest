//
//  Buttons.swift
//  KoyaQuest
//
//  Created by Kevin K Collins on 2021/05/31.

import SwiftUI

struct ChallengeButton: View {
    @Environment(\.sizeCategory) var sizeCategory: ContentSizeCategory
    var challenge: Challenge
    var completed: Bool = false
    @Binding var isShowingChallengePortal: Bool
    // @Binding var isShowingChallenge: Bool
    var body: some View {

            Button {
                self.isShowingChallengePortal = true
            } label: {
                HStack {
                    Text(challenge.name)
                        .font(wideElement(sizeCategory: sizeCategory) ? .caption2: .body)
                        .bold()
                    if !wideElement(sizeCategory: sizeCategory) {
                        Spacer()
                        Image(systemName: completed ?  "checkmark.circle" : "arrowshape.turn.up.right.circle")
                    }
                }

                .frame(
                    minWidth: 250,
                    idealWidth: 270,
                    maxWidth: 280,
                    minHeight: 30,
                    idealHeight: 38,
                    maxHeight: 42,
                    alignment: .center
                )
                .padding([.top, .bottom], 4 )
                .padding([.leading, .trailing], 14 )
                .background(Color.koyaOrange)
                .foregroundColor(.white)
                // .cornerRadius(6)
                // .shadow(color: Color(.black), radius: 1, x: 2, y: 2 )
                .fullScreenCover(
                    isPresented: $isShowingChallengePortal,
                    onDismiss: {},
                    content: {
                    ChallengePortalView(isShowingChallengePortal: $isShowingChallengePortal, challenge: challenge)
                    }
                )
            }
            .buttonStyle(ScaleButtonStyle())
            .padding(.bottom, 6)
        }
    }




struct ActionButton: View {
    @Environment(\.sizeCategory) var sizeCategory: ContentSizeCategory
    var color: Color
    var text: String = "Let's Go!"
    var body: some View {
        Text(text.uppercased())
            .font(wideElement(sizeCategory: sizeCategory) ? .caption2 : .title3)
            .bold()
            .frame(
                minWidth: 180,
                idealWidth: 200,
                maxWidth: 210,
                minHeight: 30,
                idealHeight: 44,
                maxHeight: 46,
                alignment: .center
            )
            .buttonStyle(ScaleButtonStyle())
            .padding([.top, .bottom], 2 )
            .padding([.leading, .trailing], 14 )
            .background(color)
            .foregroundColor(.white)
            // .cornerRadius(6)
    }
}

struct BackButton: View { 
    var buttonText: String
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.sizeCategory) var sizeCategory: ContentSizeCategory
    var body: some View {
        Button(action: {
                self.presentationMode.wrappedValue.dismiss()
        // swiftlint:disable:next multiple_closures_with_trailing_closure
        }) {
            HStack {
                Image(systemName: "arrowshape.turn.up.left.circle")
                    .padding(.leading, 16)
                Spacer()
                Text(buttonText.uppercased())
                    .font(wideElement(sizeCategory: sizeCategory) ? . caption2 : .body)
                    .bold()
                    .padding(.trailing, 20)
            }
            .frame(minWidth: 100, idealWidth: 120,
                   maxWidth: 140,
                   minHeight: 28,
                   idealHeight: 30,
                   maxHeight: 32,
                   alignment: .center
            )
            .padding([.top, .bottom], 2 )
            .padding([.leading, .trailing], 6 )
            .background(Color.koyaOrange)
            .foregroundColor(.white)
            // .cornerRadius(4)
        }.buttonStyle(ScaleButtonStyle())
    }
}

struct XDismissButton: View {
    @Environment(\.sizeCategory) var sizeCategory: ContentSizeCategory
    var body: some View {
        ZStack {
            Circle()
                .frame(width: 28, height: 28)
                .foregroundColor(.white)
                .opacity(0.6)
            Image(systemName: "xmark")
                .font(wideElement(sizeCategory: sizeCategory) ? .caption2 : .footnote)
                .imageScale(.small)
                .frame(width: 36, height: 36)
                .foregroundColor(.black)
        }
    }
}

struct DisableGamePlayButton: View {
    var body: some View {
        Text("Disable Gameplay".uppercased())
            .font(.footnote)
            .bold()
            .frame(
                width: 132,
                height: 18,
                alignment: .center
            )
            .buttonStyle(ScaleButtonStyle())
            .padding([.top, .bottom], 2 )
            .padding([.leading, .trailing], 2)
            .background(Color.koyaRed)
            .foregroundColor(.white)
            .cornerRadius(4.0)
            .shadow(
                color: .black,
                radius: 2,
                x: 0.0,
                y: 0.0
            )
    }
}

struct XDismissButtonRight: View {
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.sizeCategory) var sizeCategory: ContentSizeCategory
    var body: some View {

        HStack {
            Spacer()
            Button {
                self.presentationMode.wrappedValue.dismiss()
            } label: {
                Image(systemName: "xmark")
                    .font(.caption2)
                    .foregroundColor(Color.white)
                    .frame(width: 20, height: 20, alignment: .center)
                    .foregroundColor(Color.white)
                    .background(
                        Circle()
                            .fill(Color.red)
                    )
                    // .padding([.top,.trailing], 20)
            }
        }
    }
}

struct XExitButtonRight: View {
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.sizeCategory) var sizeCategory: ContentSizeCategory
    @Binding var didExitChallenge: Bool
    var body: some View {

        HStack {
            Spacer()
            Button {
                self.presentationMode.wrappedValue.dismiss()
                didExitChallenge = true

            } label: {
                Image(systemName: "xmark")
                    .font(.caption2)
                    .foregroundColor(Color.white)
                    .frame(width: 20, height: 20, alignment: .center)
                    .foregroundColor(Color.white)
                    .background(
                        Circle()
                            .fill(Color.red)
                    )
                    // .padding([.top,.trailing], 20)
            }
        }
    }
}

struct ScaleButtonStyle: ButtonStyle {
        func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .foregroundColor(.white)
            .scaleEffect(configuration.isPressed ? 1.1 : 1.0)
            .animation(.easeOut(duration: 0.2))
    }
}

struct Buttons_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 10) {
            ChallengeButton(challenge: daimonChallenge, completed: false, isShowingChallengePortal: .constant(false))
            XDismissButtonRight()
        }
    }
}

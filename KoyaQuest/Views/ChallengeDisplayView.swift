//
//  ChallengeDisplayView.swift
//  KoyaQuest
//
//  Created by Kevin K Collins on 2021/06/04.
//

import SwiftUI
import CoreHaptics

struct ChallengeDisplayView: View {
    @EnvironmentObject var appData: AppData
    @StateObject var hapticEngine = HapticEngine()
    @Binding var isPlayingGame: Bool

    var enteredZone: Area
    var body: some View {
        VStack {
            Image("challenge_banner")
                .resizable()
                .cornerRadius(0)
            Spacer()
            ChallengeDescriptionView(
                challenge: enteredZone.challenge!
            )
                .padding()
        }
        .onAppear {
            hapticEngine.vibrationAlert()
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                hapticEngine.vibrationAlert()
            }
        }
        .frame(width: 300, height: 472)
        .background(Color.koyaSky)
        .statusBar(hidden: true)
        .cornerRadius(12)
        .overlay(Button {
            isPlayingGame = false
        } label: {
            HStack {
                XDismissButton()
                Text("Disable Gameplay")
                    .baselineOffset(6.0)
                    .font(.footnote)
                    .foregroundColor(.gray)
            }

        }, alignment: .topLeading)
    }
}

struct ChallengeDisplayView_Previews: PreviewProvider {
    static var previews: some View {
        ChallengeDisplayView(isPlayingGame: .constant(true), enteredZone: daimonArea)
            .preferredColorScheme(.dark)
    }
}

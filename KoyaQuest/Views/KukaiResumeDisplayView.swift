//
//  KukaiResumeDisplayView.swift
//  KoyaQuest
//
//  Created by Kevin K Collins on 2021/08/09.
//

import SwiftUI

struct KukaiResumeDisplayView: View {
    @EnvironmentObject var appData: AppData
    @Binding var isPlayingGame: Bool

    var body: some View {
        VStack {
            Image("challenge_banner")
                .resizable()
                .cornerRadius(0)
            Spacer()
            ChallengeDescriptionView(
                challenge: kukaiChallenge
            )
                .padding()
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

struct KukaiResumeDisplayView_Previews: PreviewProvider {
    static var previews: some View {
        KukaiResumeDisplayView( isPlayingGame: .constant(true))
    }
}

//
//  ChallengeDescriptionView.swift
//  KoyaQuest
//
//  Created by Kevin K Collins on 2021/06/04.
//

import SwiftUI

struct ChallengeDescriptionView: View {
    @Environment(\.sizeCategory) var sizeCategory: ContentSizeCategory
    var challenge: Challenge
    @EnvironmentObject var appData: AppData
    @State private var isShowingChallengePortal = false

    var body: some View {

        VStack(spacing: 20) {

            Text("Tap below to accept the following challenge:")
                .font(FontSwap.caption2ForSubheadline(for: sizeCategory))
                .italic()
                .multilineTextAlignment(.center)
                .foregroundColor(.koyaPurple)

            ChallengeButton(
                challenge: challenge ,
                isShowingChallengePortal: $isShowingChallengePortal
            )
            Text(challenge.details.teaser)
                .font(FontSwap.caption2ForSubheadline(for: sizeCategory))
                .kerning(0.2)
                .italic()
                .multilineTextAlignment(.center)
                .foregroundColor(.koyaPurple)
        }
    }
}

struct ChallengeDescriptionView_Previews: PreviewProvider {
    static var previews: some View {
        ChallengeDescriptionView(challenge: gorintoChallenge)
            .preferredColorScheme(.dark)
    }
}

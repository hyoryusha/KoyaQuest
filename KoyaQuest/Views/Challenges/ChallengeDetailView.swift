//
//  ChallengeDetailView.swift
//  KoyaQuest
//
//  Created by Kevin K Collins on 2021/06/03.
//

import SwiftUI

struct ChallengeDetailView: View {
    var challenge: Challenge
    var body: some View {
        ZStack {
            BackgroundView()
                ScrollView {
                    Text(challenge.name)
                        .foregroundColor(Color.koyaOrange)
                        .font(.title)
                        .bold()
                        .multilineTextAlignment(.center)
                        .padding()
                    Text(challenge.details.teaser)
                        .foregroundColor(Color.gray)
                        .font(.body)
                        .bold()
                        .italic()
                        .multilineTextAlignment(.center)
                        .padding()
                    if challenge.details.imageName.isEmpty == false {
                        Image(challenge.details.imageName)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 260)
                    }

                    Text(challenge.details.synopsis)
                        .bodyStyle(color: .white)
                        .padding(.top)
                    Divider()
                    Text("Maximum points available: ")
                        .foregroundColor(.white)
                        .font(.body)
                        .bold()
                    + Text(" \(challenge.maxPoints)")
                        .foregroundColor(Color.koyaOrange)
                        .font(.body)
                        .bold()
                    }
                .padding([.leading, .trailing, .bottom], 8)
            }
        }
    }

struct ChallengeDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ChallengeDetailView(challenge: vajraChallenge)
    }
}

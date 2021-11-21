//
//  ChallengeListView.swift
//  KoyaQuest
//
//  Created by Kevin K Collins on 2021/06/03.
//

import SwiftUI

struct ChallengeListView: View {
    @EnvironmentObject var appData: AppData
    var body: some View {
        VStack {
            List {
                ForEach(allChallenges) { challenge in
                    NavigationLink(
                        destination: ChallengeDetailView(challenge: challenge)
                    ) {
                        HStack {
                            Image(systemName: checkCompleted(
                                challenge: challenge) ? "checkmark.seal.fill" : "circle")
                                .resizable()
                                .foregroundColor(
                                    checkCompleted(challenge: challenge) ? .koyaGreen : .gray
                                )
                                .frame(width: 20, height: 20)
                                .cornerRadius(/*@START_MENU_TOKEN@*/3.0/*@END_MENU_TOKEN@*/)
                            Text(challenge.name)
                                .font(.body)
                                .foregroundColor(.koyaDarkText)
                        }
                    }
                }
            }
            .navigationBarTitle(Text("Challenges"))
            Text("Completed challenges are marked with a green seal.")
                .font(.footnote)
                .padding(.bottom, 8)
        }
    }
    func checkCompleted(challenge: Challenge) -> Bool {
        appData.completedChallengeSummary.contains { item in
            item.challenge == challenge.name
        }
    }
}

struct ChallengeListView_Previews: PreviewProvider {
    static var previews: some View {
        ChallengeListView()
    }
}

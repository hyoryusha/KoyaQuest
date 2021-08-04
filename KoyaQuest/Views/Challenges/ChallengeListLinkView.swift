//
//  ChallengeListLinkView.swift
//  KoyaQuest
//
//  Created by Kevin K Collins on 2021/06/03.
//

import SwiftUI

struct ChallengeListLinkView: View {
    var body: some View {
        NavigationLink(destination: ChallengeListView()) {
            Image(systemName: "list.dash")
            .font(.headline)
                .foregroundColor(.koyaOrange)
            Text("See List of All \(allChallenges.count) Challenges".uppercased())
            .font(.body)
                .foregroundColor(.white)
         }
    }
}

struct ChallengeListLinkView_Previews: PreviewProvider {
    static var previews: some View {
        ChallengeListLinkView()
    }
}

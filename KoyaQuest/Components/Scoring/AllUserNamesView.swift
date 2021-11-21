//
//  AllUserNamesView.swift
//  KoyaQuest
//
//  Created by Kevin K Collins on 2021/07/15.
//

import SwiftUI

struct AllUserNamesView: View {
    var userNamesArray: [String] // passed in from PostScoreView()

    var body: some View {

        VStack {
            Text("All Usernames")
                .font(.title)
                .foregroundColor(.koyaOrange)
                .bold()
                .padding()
            Text("Note: usernames are case insensitive.")
                .font(.headline)
                .italic()
            Text("(\"Player\" would be the same as \"player.\")")
                .font(.caption)
                .italic()
            Divider()

            VStack {
                List(userNamesArray, id: \.self) { existingName in
                    Text(existingName)
                }
            }
        }
    }
}

struct AllUserNamesView_Previews: PreviewProvider {
    static var previews: some View {
        AllUserNamesView(userNamesArray: ["bart", "homer", "lisa"])
    }
}

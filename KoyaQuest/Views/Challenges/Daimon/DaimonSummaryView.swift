//
//  DaimonSummaryView.swift
//  KoyaQuest
//
//  Created by Kevin K Collins on 2021/06/05.
//

import SwiftUI

struct DaimonSummaryView: View {
    @State private var isShowingMore = false
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Image(systemName: "checkmark.seal.fill")
                Text("You've completed this challenge.")
                    .padding(.top, 12)
            }
            .font(.title2)
            .foregroundColor(.green)
            .padding(.top, 20)

                Button {
                    isShowingMore.toggle()
                } label: {
                    HStack {
                        Image(systemName: "book.fill")
                        Text("Click to Learn More")
                    }
                    .font(.title2)
                    .foregroundColor(.orange)
                    .padding()
                }
            Spacer()

        }
        .sheet(isPresented: $isShowingMore, onDismiss: {}, content: {
            DaimonLearnMoreView(isShowingMore: $isShowingMore )
        })
    }
}

struct DaimonSummaryView_Previews: PreviewProvider {
    static var previews: some View {
        DaimonSummaryView()
            .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
    }
}

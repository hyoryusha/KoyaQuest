//
//  FAQDetailView.swift
//  KoyaQuest
//
//  Created by Kevin K Collins on 2021/07/24.
//

import SwiftUI

struct FAQDetailView: View {
    var contents: FAQ
    @Binding var isShowingAnswer: Bool
    var body: some View {
        ZStack {
            Color(.black)
                .ignoresSafeArea()
            VStack {
                ScrollView {
                    Text(contents.body.headerOne)
                        .font(.title2)
                        .multilineTextAlignment(.center)
                        .foregroundColor(.koyaOrange)
                        .padding()
                    Text(contents.body.bodyOne)
                        .font(.body)
                        .foregroundColor(.white)
                        .padding()
                }
                .navigationBarTitle(contents.title, displayMode: .inline)
                .truncationMode(.head)
                // Spacer()
            }
            .padding()
            .onDisappear {
                isShowingAnswer = false
            }
        }
    }
}

struct FAQDetailView_Previews: PreviewProvider {
    static var previews: some View {
        FAQDetailView(contents: FAQ.allFAQ[0], isShowingAnswer: .constant(true))
    }
}

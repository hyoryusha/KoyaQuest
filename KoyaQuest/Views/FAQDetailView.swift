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
        ZStack{
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
            .onDisappear() {
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


/*struct FAQDetailView: View {
    var contents: FAQ
    var body: some View {

        ZStack {
            BackgroundView()
            VStack {
                Text(contents.title)
                    .font(.system(.largeTitle, design: .serif))
                    .foregroundColor(.white)
                    .bold()
                    .multilineTextAlignment(.center)
                    .padding(.top, 20)
                ScrollView {
                    HeaderText(text: contents.body.headerOne,
                               color: Color.koyaOrange)
                        .navigationBarTitle("About Kōya Quest", displayMode: .inline)

                    BodyText(text: contents.body.bodyOne,
                             color: .white)
                }
                // Spacer()
                if contents.id == 1004 {
                    ChallengeListLinkView()
                        .padding(.top, 30)
                        .padding(.bottom, 10)
                }
                Spacer()
            }
            .padding()
        }
        .statusBar(hidden: true)
    }
}

struct FAQDetailView_Previews: PreviewProvider {
    static var previews: some View {
        FAQDetailView(contents: FAQ.allFAQ[0])
    }
}
*/

//
//  AboutGameDetailView.swift
//  KoyaQuest
//
//  Created by Kevin K Collins on 2021/06/04.
//

import SwiftUI

struct AboutKoyaQuestView: View {
    var contents: Information
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
                    HeaderText(text: contents.body.headerTwo,
                               color: Color.koyaOrange)
                    BodyText(text: contents.body.bodyTwo,
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
    }
}

struct AboutGameDetailView_Previews: PreviewProvider {
    static var previews: some View {
        AboutKoyaQuestView(contents: Information.allInfo[2])
    }
}

//
//  WelcomeIntroView.swift
//  KoyaQuest
//
//  Created by Kevin K Collins on 2021/05/31.
//

import SwiftUI

struct WelcomeIntroView: View {
    @Binding var isShowingInfo: Bool
    var contents = Information.allInfo[0]
    var body: some View {
        ZStack {
            Color.koyaPurple
                .ignoresSafeArea()
            VStack {
                InfoTopView(isShowingInfo: $isShowingInfo)
                Text(contents.title)
                    .font(.system(.largeTitle, design: .serif))
                    .foregroundColor(.white)
                    .bold()
                    .padding(.top, 20)
                VStack {
                    HeaderText(text: contents.body.headerOne, color: Color.koyaOrange)
                    BodyText(text: contents.body.bodyOne, color: Color.koyaLightText)
                    HeaderText(text: contents.body.headerTwo, color: Color.koyaOrange)
                    BodyText(text: contents.body.bodyTwo, color: Color.koyaLightText)
                }
                .padding()
                
                Spacer()
            }
        }
    }
}

struct WelcomeIntroView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeIntroView(isShowingInfo: .constant(true))
    }
}

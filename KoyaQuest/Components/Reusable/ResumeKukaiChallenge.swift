//
//  ResumeKukaiChallenge.swift
//  KoyaQuest
//
//  Created by Kevin K Collins on 2021/08/09.
//

import SwiftUI

struct ResumeKukaiChallenge: View {
    @EnvironmentObject var appData: AppData
    @Environment(\.sizeCategory) var sizeCategory: ContentSizeCategory
    @Binding var isShowingResumeKukaiChallenge: Bool
    var body: some View {
            Button {
                appData.kukaiChallengeState = .active
                isShowingResumeKukaiChallenge = true
            } label: {
                HStack {
                    Text("Resume Kukai Challenge")
                        .font(wideElement(sizeCategory: sizeCategory) ? .caption2: .caption)
                        .bold()
                    if !wideElement(sizeCategory: sizeCategory) {
                        Spacer()
                        Image(systemName: "arrowshape.zigzag.right")
                    }
                }

                .frame(
                    minWidth: 160,
                    idealWidth: 170,
                    maxWidth: 200,
                    minHeight: 20,
                    idealHeight: 24,
                    maxHeight: 32,
                    alignment: .center
                )
                .padding([.top, .bottom], 3 )
                .padding([.leading, .trailing], 8 )
                .border(Color.white, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
                //.background(Color.white)
                .foregroundColor(Color.white)
                // .cornerRadius(8)
            }
            .buttonStyle(ScaleButtonStyle())
            .padding(.bottom, 6)
        }
    }


struct ResumeKukaiChallenge_Previews: PreviewProvider {
    static var previews: some View {
        ResumeKukaiChallenge( isShowingResumeKukaiChallenge: .constant(false))
    }
}

//
//  ChoishiHintView.swift
//  KoyaQuest
//
//  Created by Kevin K Collins on 2021/06/19.
//

import SwiftUI

struct ChoishiHintView: View {
    @Binding var isShowingHint: Bool
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button {
                    isShowingHint = false
                } label: {
                    XDismissButton()
                        .padding(.trailing, 10)
                }
            }
            Image("kanji-1-10")
                .resizable()
                .scaledToFit()
                .padding()
        }
    }
}

struct HintView_Previews: PreviewProvider {
    static var previews: some View {
        ChoishiHintView(isShowingHint: .constant(true))
    }
}

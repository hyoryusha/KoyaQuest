//
//  InfoTopView.swift
//  KoyaQuest
//
//  Created by Kevin K Collins on 2021/05/31.
//

import SwiftUI

struct InfoTopView: View {
    @Binding var isShowingInfo: Bool
    var body: some View {
        HStack {
            Spacer()
            CancelButton(isShowingInfo: $isShowingInfo)
        }
    }
}

struct InfoTopView_Previews: PreviewProvider {
    static var previews: some View {
        InfoTopView(isShowingInfo: .constant(true))
    }
}

struct CancelButton: View {
    @Binding var isShowingInfo: Bool
    var body: some View {
        Button {
            isShowingInfo = false
        } label: {
            Image(systemName: "xmark")
                .font(.headline)
                .foregroundColor(Color.koyaLightText)
                .frame(width: 26, height: 26, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .foregroundColor(Color.koyaLightText)
                .background(
                    Circle()
                        .fill(Color.gray)
                )
                .padding(.top, 20)
                .padding(.trailing, 30)
        } .accessibilityIdentifier("welcome view close button")
    }
}

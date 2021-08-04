//
//  DisabledMessageView.swift
//  KoyaQuest
//
//  Created by Kevin K Collins on 2021/06/08.
//

import SwiftUI

struct DisabledMessageView: View {
    @Environment(\.sizeCategory) var sizeCategory: ContentSizeCategory
    var body: some View {
        ZStack {
            Rectangle()
                .frame(
                    maxWidth: .infinity,
                    maxHeight: wideElement(sizeCategory: sizeCategory) ? 66 : 32,
                    alignment: .center
                )
                .foregroundColor(.black)
            HStack {
                VStack {
                    Text("Gameplay has been disabled.\n(Use toggle switch in top-right corner to resume.)")
                        .font(wideElement(sizeCategory: sizeCategory) ? .caption2 : .footnote)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                }
                Image(systemName: "gamecontroller")
                    .font(wideElement(sizeCategory: sizeCategory) ? .caption2 : .footnote)
                    .foregroundColor(.white)
                    .padding(.leading, 10)
            }
        }
    }
}

struct DisabledMessageView_Previews: PreviewProvider {
    static var previews: some View {
        DisabledMessageView()
    }
}

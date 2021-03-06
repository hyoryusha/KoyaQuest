//
//  NearGobyoWarningView.swift
//  KoyaQuest
//
//  Created by Kevin K Collins on 2021/08/26.
//

import SwiftUI

struct NearGobyoWarningView: View {
    @Environment(\.sizeCategory) var sizeCategory: ContentSizeCategory
    var body: some View {
        ZStack {
            Rectangle()
                .frame(
                    maxWidth: .infinity,
                    maxHeight: wideElement(sizeCategory: sizeCategory) ? 80 : 60,
                    alignment: .center
                )
                .foregroundColor(.koyaRed)
            HStack {
                Image(systemName: "exclamationmark.triangle.fill")
                    .font(wideElement(sizeCategory: sizeCategory) ? .caption2 : .title2)
                    .foregroundColor(.white)
                    .padding(.leading, 10)
                VStack {
                    // swiftlint:disable:next line_length
                    Text("You are near the Mausoleum of Kōbō Daishi.\nPlease observe the prohibition of electronic devices beyond the Gobyō Bridge")
                        .font(FontSwap.caption2ForCaption(for: sizeCategory))
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                }
            }
        }
    }
}

struct NearGobyoWarningView_Previews: PreviewProvider {
    static var previews: some View {
        NearGobyoWarningView()
    }
}

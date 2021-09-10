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
                        maxHeight: wideElement(sizeCategory: sizeCategory) ? 80 : 36,
                        alignment: .center
                    )
                    .foregroundColor(.koyaRed)
                HStack {
                    Image(systemName: "exclamationmark.triangle.fill")
                        .font(wideElement(sizeCategory: sizeCategory) ? .caption2 : .caption)
                        .foregroundColor(.white)
                        .padding(.leading, 10)
                    VStack {
                        Text("You are near the Mausoleum of Kōbō Daishi.\nUse of electronic devices is prohibited in this area.")
                            .font(wideElement(sizeCategory: sizeCategory) ? .caption2 : .caption)
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

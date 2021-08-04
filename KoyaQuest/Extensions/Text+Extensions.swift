//
//  Text+Extensions.swift
//  KoyaQuest
//
//  Created by Kevin K Collins on 2021/05/31.
//

import SwiftUI

extension Text {
    func bodyStyle(color: Color) -> some View {
        self
            .font(.body)
            .frame(idealWidth: 320, maxWidth: 380, alignment: .leading)
            .foregroundColor(color)
            .multilineTextAlignment(.leading)
            .lineSpacing(1.75)
    }

    func italicHeader(color: Color) -> some View {
        self
        .font(.system(.title, design: .serif))
        .italic()
        .bold()
        .padding([.top, .bottom], 8)
            .foregroundColor(color)
        .multilineTextAlignment(.center)
    }
}

//
//  Text+Extensions.swift
//  KoyaQuest
//
//  Created by Kevin K Collins on 2021/05/31.
//

import SwiftUI

extension Text {
    func bodyStyle() -> some View {
        self
            .font(.body)
            .frame(idealWidth: 320, maxWidth: 380 , alignment: .leading)
            .foregroundColor(Color(.white))
            .multilineTextAlignment(.leading)
            .lineSpacing(1.75)
    }
    
    func italicHeader() -> some View {
        self
        .font(.system(.title, design: .serif))
        .italic()
        .bold()
        .padding([.top, .bottom] , 8)
            .foregroundColor(Color.koyaOrange)
        .multilineTextAlignment(.center)
    }
}

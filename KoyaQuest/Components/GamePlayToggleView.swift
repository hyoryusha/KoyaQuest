//
//  GamePlayToggleView.swift
//  KoyaQuest
//
//  Created by Kevin K Collins on 2021/06/04.
//

import SwiftUI

struct GamePlayToggleView: View {
    @Environment(\.sizeCategory) var sizeCategory: ContentSizeCategory
    @Binding var isPlayingGame: Bool

    var body: some View {
        VStack {
            Toggle(isOn: $isPlayingGame, label: {
                Image(systemName: "gamecontroller")
                    .foregroundColor(Color.koyaDarkText)
                    .font(wideElement(sizeCategory: sizeCategory) ? .caption2 : .subheadline)
                Text("Play Game:")
                    .font(wideElement(sizeCategory: sizeCategory) ? .caption2 : .subheadline)
                    .foregroundColor(Color.koyaDarkText)
            })
            .padding()
            .toggleStyle(SwitchToggleStyle(tint: Color.koyaGreen))
        }
        .frame(width: 200, height: 32, alignment: .trailing)
    }
}

struct GamePlayToggleView_Previews: PreviewProvider {
    static var previews: some View {
        GamePlayToggleView(isPlayingGame: .constant(true))
    }
}

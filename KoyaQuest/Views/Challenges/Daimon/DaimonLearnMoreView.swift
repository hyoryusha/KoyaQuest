//
//  DaimonLearnMoreView.swift
//  KoyaQuest
//
//  Created by Kevin K Collins on 2021/06/05.
//

import SwiftUI

struct DaimonLearnMoreView: View {
    @Binding var isShowingMore: Bool
    var body: some View {
        VStack {
            XDismissButtonRight()
                .padding(.top, 10)
                .padding(.trailing, 12)
            ScrollView {
                HeaderText(text: "The meaning of the name \n\"Kōyasan\"", color: Color.koyaOrange)
                // swiftlint:disable:next line_length
                BodyText(text: "Mt. Kōya in Japanese is \"Kōyasan\". It is written with the Chinese characters 高 kō - 野 ya - 山 san, which mean \"high,\" \"field,\" and \"mountain,\" respectively.", color: .koyaDarkText)
                HeaderText(text: "Right-to-left? \nLeft-to-right?", color: .koyaOrange)
                // swiftlint:disable:next line_length
                BodyText(text: "Until the modern era, Japanese was written vertically from right to left. To read or write, you would start in the upper right-hand corner of the page – or scroll, as the case may be – and then read down each column until you reached the lower left-hand corner.\nAfter the Meiji Restoration (1868) and until World War II, most texts were written this way. The only exceptions were works dealing with the natural sciences or western culture.\nSince World War II, the preference for writing horizontally from left to right has increased steadily. Government documents, road signs, in-company memos and most textbooks are now written horizontally, left to right. Prominent exceptions include novels, Japanese language textbooks and newspapers (though headlines, if horizontal, are left to right).\nThe three Chinese characters for Mt. Kōya on the Daimon follow the traditional arrangement. The argument can be made that they are not arranged horizontally, per se. In other words, one could say that they are, in fact, written vertically but in single-character columns!", color: .koyaDarkText)
            }
            .padding(8)
        }
    }
}
struct DaimonLearnMoreView_Previews: PreviewProvider {
    static var previews: some View {
        DaimonLearnMoreView(isShowingMore: .constant(true))
    }
}

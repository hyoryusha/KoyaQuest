//
//  CaptionView.swift
//  KoyaQuest
//
//  Created by Kevin K Collins on 2021/06/04.
//

import SwiftUI

struct CaptionView: View {
    var text: String
    var body: some View {
        Text(text)
            .font(.system(.caption2, design: .serif))
            .italic()
            .foregroundColor(Color.koyaDarkText)
            .multilineTextAlignment(.leading)
    }
}

struct CaptionView_Previews: PreviewProvider {
    static var previews: some View {
        CaptionView(text: "Caption Goes Here")
    }
}

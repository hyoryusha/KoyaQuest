//
//  ScoreSummaryRow.swift
//  KoyaQuest
//
//  Created by Kevin K Collins on 2021/06/04.
//

import SwiftUI

struct ScoreSummaryRow: View {
    @Environment(\.sizeCategory) var sizeCategory: ContentSizeCategory
    var challenge: String
    var points: Int
    var body: some View {
        HStack {
            Image(systemName: "checkmark.seal.fill")
                .foregroundColor(.koyaGreen)
                .font(wideElement(sizeCategory: sizeCategory) ? . caption2 : .body)
            Text(challenge)
                .frame(width: 200, alignment: .leading)
                .font(wideElement(sizeCategory: sizeCategory) ? . caption2 : .body)
                .padding(.leading, 20)
            Spacer()
            Text("\(points)")
                .frame(width: 80, alignment: .trailing)
                .font(wideElement(sizeCategory: sizeCategory) ? . caption2 : .body)
                .padding(.trailing, 20)
        }
    }
}

struct ScoreSummaryRow_Previews: PreviewProvider {
    static var previews: some View {
        ScoreSummaryRow(challenge: "Daimon Challenge", points: 20)
    }
}

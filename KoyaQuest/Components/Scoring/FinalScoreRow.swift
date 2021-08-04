//
//  FinalScoreRow.swift
//  KoyaQuest
//
//  Created by Kevin K Collins on 2021/07/18.
//

import SwiftUI

struct FinalScoreRow: View {
    @Environment(\.sizeCategory) var sizeCategory: ContentSizeCategory
    var finalScore: FinalScore
    var ordinal: Int
    var body: some View {
        HStack {
            Text(verbatim: "\(ordinal)")
                .frame(width: 60, alignment: .trailing)
                .font(wideElement(sizeCategory: sizeCategory) ? . caption2 : .body)
                .foregroundColor(.koyaGreen)
                .padding(.leading, 6)
            Text(finalScore.userName ?? "")
                .frame(width: 110, alignment: .leading)
                .font(wideElement(sizeCategory: sizeCategory) ? . caption2 : .body)
                .padding(.leading, 10)
            Spacer()
            Text("\(finalScore.score)")
                .frame(width: 60, alignment: .leading)
                .font(wideElement(sizeCategory: sizeCategory) ? . caption2 : .body)
                //.padding(.leading, 6)
            Spacer()
            Text("\(finalScore.submitDate!.addingTimeInterval(0), style: .date)")
                .frame(width: 110, alignment: .leading)
                .font(wideElement(sizeCategory: sizeCategory) ? . caption2 : .footnote)
                //.padding(.trailing, 4)
        }
        .padding([.leading, .trailing], 10)
    }
}


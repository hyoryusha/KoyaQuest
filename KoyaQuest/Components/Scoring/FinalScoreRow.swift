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
                .frame(width: 30, alignment: .trailing)
                .font(wideElement(sizeCategory: sizeCategory) ? . caption2 : .caption)
                .foregroundColor(.koyaGreen)
                .padding(.leading, 6)
            Text(finalScore.userName ?? "")
                .frame(width: 120, alignment: .leading)
                .font(wideElement(sizeCategory: sizeCategory) ? . caption2 : .caption)
                .padding(.leading, 10)
            Spacer()
            Text("\(finalScore.score)")
                .frame(width: 50, alignment: .leading)
                .font(wideElement(sizeCategory: sizeCategory) ? . caption2 : .caption)
                //.padding(.leading, 6)
            Spacer()
            //Text("\(finalScore.submitDate!.addingTimeInterval(0), style: .date)")
            Text(convertDate(date:finalScore.submitDate!.addingTimeInterval(0)))
                .frame(width: 110, alignment: .leading)
                .font(wideElement(sizeCategory: sizeCategory) ? . caption2 : .caption)
                //.padding(.trailing, 4)
        }
        .padding([.leading, .trailing], 10)
    }

    func convertDate(date: Date) -> String {
        let formatter = DateFormatter()
        //formatter.dateStyle = .short
        formatter.dateFormat = "MMM. d, y"
        return formatter.string(from: date)
    }
}


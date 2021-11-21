//
//  ScoreSummaryTopView.swift
//  KoyaQuest
//
//  Created by Kevin K Collins on 2021/06/04.
//

import SwiftUI

struct ScoreSummaryTopView: View {
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.sizeCategory) var sizeCategory: ContentSizeCategory
    @Binding var scoreSummaryIsVisible: Bool
    var body: some View {
        HStack {
            Spacer()
            Button {
                scoreSummaryIsVisible = false
                self.presentationMode.wrappedValue.dismiss()
            } label: {
                Image(systemName: "xmark")
                    .font(wideElement(sizeCategory: sizeCategory) ? .caption2 : .headline)
                    .foregroundColor(Color.white)
                    .frame(width: 26, height: 26, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .foregroundColor(Color.white)
                    .background(
                        Circle()
                            .fill(Color.koyaOrange)
                    )
                    .padding(.top, 50)
                    .padding(.trailing, 30)
            }
            .buttonStyle(ScaleButtonStyle())
        }
    }
}

struct ScoreSummaryTopView_Previews: PreviewProvider {
    static var previews: some View {
        ScoreSummaryTopView(scoreSummaryIsVisible: .constant(true))
    }
}

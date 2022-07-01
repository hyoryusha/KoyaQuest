//
//  LandmarkRowView.swift
//  KoyaQuest
//
//  Created by Kevin K Collins on 2021/05/30.
//

import SwiftUI

struct LandmarkRowView: View {
    @Environment(\.sizeCategory) var sizeCategory: ContentSizeCategory
    var landmark: Landmark

    var body: some View {
        HStack {
            if !wideElement(sizeCategory: sizeCategory) {
                Image(landmark.imageName)
                    .resizable()
                    .frame(width: 77, height: 55)
            }
            VStack(alignment: .leading) {
                HStack {
                    Text(landmark.jname)
                        .font(FontSwap.caption2ForSubheadline(for: sizeCategory))
                        .foregroundColor(.koyaDarkText)
                    Spacer()
                    RatingsView(filter: landmark.name)
                }

                Text(landmark.romaji)
                    //.font(FontSwap.caption2ForSubheadline(for: sizeCategory))
                    .font(.caption)
                    .foregroundColor(.secondary)

                Text(landmark.name)
                    .font(FontSwap.caption2ForSubheadline(for: sizeCategory))
                    .foregroundColor(.koyaDarkText)
                    .italic()
            }
        }
    }
}

struct LandmarkRowView_Previews: PreviewProvider {
    static var previews: some View {
        LandmarkRowView(landmark: Landmark.allLandmarks[10])
            .preferredColorScheme(.dark)
    }
}

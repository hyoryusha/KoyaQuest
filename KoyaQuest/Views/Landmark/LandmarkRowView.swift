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
                    .frame(width: 70, height: 50)
            }
            VStack(alignment: .leading) {
                Text(landmark.jname)
                    .font(FontSwap.caption2ForTitle3(for: sizeCategory))
                    .foregroundColor(.koyaDarkText)
                Text(landmark.name)
                    .font(FontSwap.caption2ForSubheadline(for: sizeCategory))
                    .italic()
                    .foregroundColor(.secondary)
            }
            Spacer()
            RatingsView(filter: landmark.name)
        }
    }
}

struct LandmarkRowView_Previews: PreviewProvider {
    static var previews: some View {
        LandmarkRowView(landmark: Landmark.allLandmarks[0])
            .preferredColorScheme(.dark)
    }
}

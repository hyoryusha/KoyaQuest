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
                    .font(wideElement(sizeCategory: sizeCategory) ? .caption2 : .title3)
                    .foregroundColor(.koyaDarkText)
                Text(landmark.name)
                    .font(wideElement(sizeCategory: sizeCategory) ? .caption2 : .subheadline)
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

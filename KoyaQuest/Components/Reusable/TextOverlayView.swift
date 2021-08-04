//
//  TextOverlayView.swift
//  KoyaQuest
//
//  Created by Kevin K Collins on 2021/06/04.
//

import SwiftUI

struct TextOverlayView: View {
    @Environment(\.sizeCategory) var sizeCategory: ContentSizeCategory
        var landmark: Landmark
        var body: some View {
            Spacer()
            ZStack(alignment: .bottomLeading) {
                VStack(alignment: .leading) {
                    HStack {
                        Text(landmark.name)
                            .font(wideElement(sizeCategory: sizeCategory) ? .caption2: .title2)
                            .bold()
                            .padding(.leading, 40)
                            .shadow(color: Color.black, radius: 3, x: 3, y: 3)
                        Spacer()
                    }
                }
                .padding()
            }
            .foregroundColor(.white)
        }
    }

struct TextOverlayView_Previews: PreviewProvider {
    static var previews: some View {
        TextOverlayView(landmark: Landmark.allLandmarks[0])
    }
}

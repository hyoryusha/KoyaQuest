//
//  RatingsOverlayView.swift
//  KoyaQuest
//
//  Created by Kevin K Collins on 2021/05/31.
//

import SwiftUI

struct RatingsOverlayView: View {
    var landmark: Landmark
    var body: some View {

        ZStack(alignment: .topTrailing) {
            VStack {
                HStack {
                    Spacer()
                    RatingsView(filter: landmark.name)
                }
                .padding(.top, 26)
                Spacer()
            }
        }
    }
}

struct RatingsOverlayView_Previews: PreviewProvider {
    static var previews: some View {
        RatingsOverlayView(landmark: Landmark.allLandmarks[0])
    }
}

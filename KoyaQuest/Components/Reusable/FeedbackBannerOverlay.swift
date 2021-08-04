//
//  CorrectBannerOverlayView.swift
//  MultipleChoice
//
//  Created by Kevin K Collins on 2021/05/29.
//

import SwiftUI

struct FeedbackBannerOverlay: View {
    var text = "Correct"
    var body: some View {

        ZStack(alignment: .top) {
            VStack(alignment: .leading) {
                HStack {
                    Text(text)
                        .font(.title)
                        .foregroundColor(.white)
                        .bold()
                        .italic()
                        .padding(.leading, 36)
                    Spacer()
                }
            }
            .padding()
        }
        .foregroundColor(.white)
    }
}

struct CorrectBannerOverlayView_Previews: PreviewProvider {
    static var previews: some View {
        FeedbackBannerOverlay()
    }
}

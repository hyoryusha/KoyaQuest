//
//  FeedbackOverlayView.swift
//  KoyaQuest
//
//  Created by Kevin K Collins on 2021/10/15.
//

import SwiftUI

struct FeedbackOverlayView: View {
    var type: FeedbackType
    var success: Bool
    var body: some View {

        Spacer()
        ZStack(alignment: .topLeading) {
            VStack(alignment: .leading) {
                HStack {
                    Text(FeedbackConstants.getFeedbackString(type: type, success: success))
                        .font(.system( .largeTitle, design: .serif))
                        .bold()
                        .padding(.leading, 10)
                        .shadow(color: Color.black, radius: 6, x: 5, y: 5)
                    Spacer()
                }
                Spacer()
            }
            .padding()
        }
        .foregroundColor(.white)
    }
}

struct FeedbackOverlayView_Previews: PreviewProvider {
    static var previews: some View {
        FeedbackOverlayView(type: .challenge, success: false)
    }
}

//
//  FeedbackOverlayView.swift
//  KoyaQuest
//
//  Created by Kevin K Collins on 2021/10/15.
//

import SwiftUI

struct FeedbackOverlayView: View {
    var success: Bool
    var body: some View {

        Spacer()
        ZStack(alignment: .topLeading) {
            VStack(alignment: .leading) {
                HStack {
                    Text(getFeedbackString(success: success))
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

    func getFeedbackString(success: Bool) -> String {
        if success {
            let index = Int.random(in: 0...positiveFeedbackStrings.count - 1)
            return positiveFeedbackStrings[index]
        } else {
            let index = Int.random(in: 0...negativeFeedbackStrings.count - 1)
            return negativeFeedbackStrings[index]
        }
    }
    var positiveFeedbackStrings = ["Excellent!", "Well Done!", "Good Job!", "Success!"]
    var negativeFeedbackStrings = ["Too Bad", "Better Luck Next Time", "Can't Win 'em All"]
}

struct FeedbackOverlayView_Previews: PreviewProvider {
    static var previews: some View {
        FeedbackOverlayView(success: true)
    }
}

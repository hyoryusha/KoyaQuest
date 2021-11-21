//
//  BonusFeedbackView.swift
//  KoyaQuest
//
//  Created by Kevin K Collins on 2021/06/18.
//

import SwiftUI

struct BonusFeedbackView: View {
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.sizeCategory) var sizeCategory: ContentSizeCategory

    var appData: AppData
    var bonus: Bonus
    var text = "Correct"
    var points: Int
    var success: Bool

    var body: some View {
        ZStack {
            VStack {
                Image(success ? "correct_banner" : "fail_banner")
                    .resizable()
                    .frame(height: 100)
                    .cornerRadius(0)
                    .overlay(FeedbackBannerOverlay(text: text))
                Spacer()
                Button {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        appData.recordCompletedBonus(bonus: bonus, points: points)
                        presentationMode.wrappedValue.dismiss()
                    }
                } label: {
                    Text("Tap to claim \(points) Points")
                        .font(FontSwap.caption2ForTitle3(for: sizeCategory))
                        .bold()
                        .frame(
                            minWidth: 180,
                            idealWidth: 200,
                            maxWidth: 210,
                            minHeight: 50,
                            idealHeight: 60,
                            maxHeight: 70,
                            alignment: .center
                        )
                        .padding([.top, .bottom], 2 )
                        .padding([.leading, .trailing], 12 )
                        .background(success ? Color.koyaOrange : .koyaRed)
                        .foregroundColor(.white)
                        .cornerRadius(6)
                }

                .buttonStyle(ScaleButtonStyle())
                Spacer()
            }
            .frame(width: 300, height: 200)
            .background(Color.koyaSky)
            .cornerRadius(12)
            .shadow(color: .koyaPurple.opacity(0.5), radius: 0.5, x: 12, y: 12  )

        }
        .background(Image("mtns"))
    }

}

struct BonusFeedbackView_Previews: PreviewProvider {
    static var previews: some View {
        BonusFeedbackView(appData: AppData(), bonus: Bonus.kukaiBonus, points: 12, success: true)
    }
}

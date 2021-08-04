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
        VStack {
            Image(success ? "correct_banner" : "fail_banner")
                .resizable()
                .frame(height: 100)
                .cornerRadius(0)
                .overlay(FeedbackBannerOverlay(text: text))
            Spacer()
            Button {
                presentationMode.wrappedValue.dismiss()
                appData.recordCompletedBonus(bonus: bonus, points: points)
            } label: {
                Text("Exit with \(points) Points")
                    .font(wideElement(sizeCategory: sizeCategory) ? .caption : .title3)
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
        .shadow(radius: 40)
        }
    }

struct BonusFeedbackView_Previews: PreviewProvider {
    static var previews: some View {
        BonusFeedbackView(appData: AppData(), bonus: Bonus.kukaiBonus, points: 12, success: true)
    }
}

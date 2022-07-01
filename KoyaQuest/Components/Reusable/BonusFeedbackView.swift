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
                Image(FeedbackConstants.randomImage())
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 360, height: 200)
                    .clipped()
                    .overlay(FeedbackOverlayView(type: .bonus, success: success))
                    .foregroundColor(.white)
                Button {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        appData.recordCompletedBonus(bonus: bonus, points: points)
                        presentationMode.wrappedValue.dismiss()
                    }
                } label: {
                    if #available(iOS 15.0, *) {
                        Text("Tap to claim \(points) Points")
                            .font(.title3)
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
                            .background(Color.koyaOrange)
                            .foregroundColor(.white)
                            .cornerRadius(6)
                    } else {
                        // Fallback on earlier versions
                        Text("Tap to claim \(points) Points")
                            .font(.title3)
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
                }
                .buttonStyle(ScaleButtonStyle())
                Spacer()
            }
            .background(Color.black)
            .frame(width: 320, height: 320)
            .cornerRadius(12)
            .shadow(color: .koyaPurple.opacity(0.35), radius: 0.5, x: 12, y: 12 )

        }
        .offset(x: 0.0, y: -45.0)
        .navigationBarTitle(Text(""))
        .navigationBarHidden(true)
        .statusBar(hidden: true)
        .background(Image("mtns"))
    }
}

struct BonusFeedbackView_Previews: PreviewProvider {
    static var previews: some View {
        BonusFeedbackView(appData: AppData(), bonus: Bonus.kukaiBonus, points: 12, success: true)
    }
}

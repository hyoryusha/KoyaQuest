//
//  NewBonusDisplayView.swift
//  KoyaQuest
//
//  Created by Kevin K Collins on 2021/08/24.
//

import SwiftUI

struct NewBonusDisplayView: View {
    @EnvironmentObject var appData: AppData
    @Binding var isPlayingGame: Bool
    @Binding var isShowingBonusList: Bool
    var body: some View {

        ZStack {
            Image("mtns")
                .ignoresSafeArea(.all)
            VStack {
                Image("bonus_banner")
                    .resizable()
                    .frame(height: 120)
                    .cornerRadius(0)
                Text("You have unlocked a bonus question!")
                    .font(.callout)
                    .padding(.top, 10)
                Button {
                    isShowingBonusList = true
                    print("show bonus list tapped")
                        } label: {
                            ActionButton(
                                color: .koyaRed,
                                text: "View Bonus")

                        }
                .buttonStyle(ScaleButtonStyle())

                Spacer()
            }
            .frame(width: 300, height: 240)
            .background(Color.koyaSky)
            .cornerRadius(12)
            .shadow(radius: 40)
        }

   }
}

struct NewBonusDisplayView_Previews: PreviewProvider {
    static var previews: some View {
        NewBonusDisplayView(isPlayingGame: .constant(true), isShowingBonusList: .constant(false))
    }
}

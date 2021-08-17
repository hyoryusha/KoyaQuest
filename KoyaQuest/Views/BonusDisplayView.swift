//
//  BonusDisplayView.swift
//  KoyaQuest
//
//  Created by Kevin K Collins on 2021/06/17.
//

import SwiftUI

struct BonusDisplayView: View {
    @EnvironmentObject var appData: AppData
    @Binding var isPlayingGame: Bool
    @Binding var isShowingBonusList: Bool
    var body: some View {
        NavigationView {
            VStack {
                Image("bonus_banner")
                    .resizable()
                    .frame(height: 120)
                    .cornerRadius(0)
                Text("You have unlocked a bonus question!")
                    .font(.callout)
                    .padding(.top, 10)
                NavigationLink(
                    destination: BonusListView()) {
                        ActionButton(
                            color: .koyaRed,
                            text: "View Bonus")
                            .buttonStyle(ScaleButtonStyle())
                    }
                Spacer()
            }
            .frame(width: 300, height: 240)
            .background(Color.koyaSky)
            .cornerRadius(12)
            .shadow(radius: 40)
            Spacer()
//            .overlay(Button {
//                isPlayingGame = false
//            } label: {
//                HStack {
//                    XDismissButton()
//                    Text("Disable Gameplay")
//                        .baselineOffset(6.0)
//                        .font(.footnote)
//                        .foregroundColor(.white)
//                }
//
//            }, alignment: .topLeading)
        }
       // .navigationBarHidden(true)
       // .navigationBarTitle("")
        //.navigationViewStyle(StackNavigationViewStyle())
   }
}

struct BonusDisplayView_Previews: PreviewProvider {
    static var previews: some View {
        BonusDisplayView(isPlayingGame: .constant(true), isShowingBonusList: .constant(false))
    }
}

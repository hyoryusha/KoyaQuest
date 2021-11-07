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
                Image("bonus banner test")
                    .aspectRatio(contentMode: .fill)
                    .frame(height: 160)
                    .clipped()
                    .overlay(BonusOverlayView())
                Spacer()
                HStack{
                    Image(systemName: "lock.open")
                        .foregroundColor(.koyaGreen)
                        .font(.headline)
                    Text("You have unlocked a bonus question!")
                        .foregroundColor(.white)
                        .font(.subheadline)
                }
                Button {
                    isShowingBonusList = true
                        } label: {
                            ActionButton(
                                color: .koyaOrange,
                                text: "View Bonus")
                        }
                .buttonStyle(ScaleButtonStyle())

                Spacer()
            }
            .frame(width: 320, height: 300)
            .background(Color.black)
            .cornerRadius(12)
            .shadow(radius: 60)
        }
   }
}



struct NewBonusDisplayView_Previews: PreviewProvider {
    static var previews: some View {
        NewBonusDisplayView(isPlayingGame: .constant(true), isShowingBonusList: .constant(false))
            .preferredColorScheme(.dark)
    }
}

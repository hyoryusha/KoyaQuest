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
                ZStack {
                    Image("mtns")
                        .ignoresSafeArea()
                        .blur(radius: 2.0)

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
                        NavigationLink(
                            destination: BonusListView()) {
                                ActionButton(
                                    color: .koyaOrange,
                                    text: "View Bonus")
                                    .buttonStyle(ScaleButtonStyle())
                            }
                        Spacer()
                    }
//                    .frame(width: 300, height: 240)
//                    .background(Color.koyaSky)
//                    .cornerRadius(12)
//                    .shadow(radius: 40)
                    .frame(width: 320, height: 300)
                    .background(Color.black)
                    .cornerRadius(12)
                    .shadow(radius: 60)
                    //Spacer()
                }
            }
            .navigationBarTitle(Text(""))
            .navigationBarHidden(true)
   }
}

struct BonusDisplayView_Previews: PreviewProvider {
    static var previews: some View {
        BonusDisplayView(isPlayingGame: .constant(true), isShowingBonusList: .constant(false))
    }
}

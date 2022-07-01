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
    @StateObject var hapticEngine = HapticEngine()
    var body: some View {
        NavigationView {
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
                    HStack {
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
                .frame(width: 320, height: 300)
                .background(Color.black)
                .cornerRadius(12)
                .shadow(radius: 60)
            }
            .navigationBarTitle(Text(""))
            .navigationBarHidden(true)
            .statusBar(hidden: true)
            .offset(x: 0.0, y: -40.0)
            .onAppear() {
                hapticEngine.vibrationAlert()
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    hapticEngine.vibrationAlert()
                }
            }
        }
    }
}

struct BonusDisplayView_Previews: PreviewProvider {
    static var previews: some View {
        BonusDisplayView(isPlayingGame: .constant(true), isShowingBonusList: .constant(false))
    }
}

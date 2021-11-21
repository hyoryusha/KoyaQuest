//
//  BonusOverlayView.swift
//  KoyaQuest
//
//  Created by Kevin K Collins on 2021/10/16.
//

import SwiftUI
struct BonusOverlayView: View {

    var body: some View {
        Spacer()
        ZStack {
            VStack {
                HStack {
                    Spacer()
                    Text("Bonus!")
                        .font(.system( .largeTitle, design: .serif))
                        .bold()
                        .padding(.trailing, 10)
                        .shadow(color: Color.black, radius: 6, x: 5, y: 5)
                }
            }
            .padding()
        }
        .foregroundColor(.white)
    }
}
struct BonusOvelLayView_Previews: PreviewProvider {
    static var previews: some View {
        BonusOverlayView()
    }
}

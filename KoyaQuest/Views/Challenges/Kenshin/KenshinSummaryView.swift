//
//  KenshinSummaryView.swift
//  KoyaQuest
//
//  Created by Kevin K Collins on 2022/05/17.
//

import SwiftUI

struct KenshinSummaryView: View {
    var body: some View {
        VStack {
            Text("A Key to Understanding Mt. Kōya")
                .font(.title2)
                .bold()
                .foregroundColor(.white)
                .padding(.bottom, 6)
            Text("Although Uesugi Kenshin and Takeda Shingen were arch enemies in life, both await salvation here at Oku-no-in. \nThe sharing of this sacred space by former foes is representative of the inclusive nature of Mt. Kōya and the teachings of Kūkai.")
                .fixedSize(horizontal: false, vertical: true)
                .foregroundColor(.white)
        }
        .padding()
        //.background(Color.koyaRed.opacity(0.3))
    }
}

struct KenshinSummaryView_Previews: PreviewProvider {
    static var previews: some View {
        KenshinSummaryView()
            .preferredColorScheme(.dark)
    }
}

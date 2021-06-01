//
//  TitleView.swift
//  KoyaQuest
//
//  Created by Kevin K Collins on 2021/05/31.
//

import SwiftUI

struct TitleView: View {
    var fullCaption: Bool
    var body: some View {
        VStack{
            Text("Kōya Quest")
                .font(.system(.title, design: .serif))
                .italic()
                .bold()
                .foregroundColor(Color.koyaPurple)
                .italic()
                .padding(.top, 10)
            
            if fullCaption {
                Text("An interactive game & guide \nfor visitors to Japan's Mt. Kōya")
                    .foregroundColor(Color.koyaDarkText)
                    .font(.system(.callout, design: .serif))
                    .kerning(0.2)
                    .italic()
                    .multilineTextAlignment(.center)
            }
        }
    }
}

struct TitleView_Previews: PreviewProvider {
    static var previews: some View {
        TitleView(fullCaption: true)
            .colorScheme(.dark)
    }
}

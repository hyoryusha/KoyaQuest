//
//  Buttons.swift
//  KoyaQuest
//
//  Created by Kevin K Collins on 2021/05/31.
//

import SwiftUI

struct SmallDismissButton: View {
    var buttonText: String
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        Button(action:{
                self.presentationMode.wrappedValue.dismiss()
        }) {
            HStack{
                Image(systemName: "arrowshape.turn.up.left.circle")
                    .padding(.leading, 16)
                Spacer()
                Text(buttonText.uppercased())
                    .font(.body)
                    .bold()
                    .padding(.trailing, 20)
            }
            .frame(minWidth: 100, idealWidth: 120, maxWidth: 120, minHeight: 28, idealHeight: 30, maxHeight: 32, alignment: .center)
            .padding([.top, .bottom] , 2 )
            .padding([.leading, .trailing] , 6 )
            .background(Color.koyaOrange)
            .foregroundColor(.white)
            //.cornerRadius(4)
        }.buttonStyle(ScaleButtonStyle())
    }
}

struct ScaleButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 1.1 : 1.0)
            .animation(.easeOut(duration: 0.2))
    }
}


struct Buttons_Previews: PreviewProvider {
    static var previews: some View {
        VStack (spacing: 10) {
//            XDismissButton()
//            XDismissButtonRight()
//            ChallengeButton(challenge: daimonChallenge, isShowingChallengePortal: .constant(false), isShowingChallenge: .constant(true))
//            GoButton()
//            DismissButton()
//            SuccessButton(text: "Success!")
            SmallDismissButton(buttonText: "Back")
        }
        
    }
}

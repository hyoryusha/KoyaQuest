//
//  KenshinMoreInfoView.swift
//  KoyaQuest2021
//
//  Created by Kevin K Collins on 2021/05/03.
//

import SwiftUI

struct KenshinMoreInfoView: View {
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        VStack {
            Text("More Info on Haka-mairi Customs")
                .font(.body)
                .multilineTextAlignment(.leading)
                .foregroundColor(.primary)
                .padding()

            Button {
                self.presentationMode.wrappedValue.dismiss()
            } label: {
                Text("Exit")
                    .font(.headline)
                    .foregroundColor(.koyaOrange)
            }
        }
    }
}

struct KenshinMoreInfoView_Previews: PreviewProvider {
    static var previews: some View {
        KenshinMoreInfoView()
    }
}

//
//  AppInfoTopView.swift
//  KoyaQuest
//
//  Created by Kevin K Collins on 2021/06/04.
//

import SwiftUI

struct AppInfoTopView: View {
    @Binding var isShowingInfo: Bool
    var body: some View {
        HStack {
            Spacer()
            Button {
                isShowingInfo = false
            } label: {
                Image(systemName: "xmark")
                    .font(.headline)
                    .foregroundColor(Color.white)
                    .frame(width: 26, height: 26, alignment: .center)
                    .foregroundColor(Color.white)
                    .background(
                        Circle()
                            .fill(Color.koyaOrange)
                    )
                    .padding(.top, 50)
                    .padding(.trailing, 30)
            }
        }
    }
}

struct AppInfoTopView_Previews: PreviewProvider {
    static var previews: some View {
        AppInfoTopView(isShowingInfo: .constant(true))
    }
}

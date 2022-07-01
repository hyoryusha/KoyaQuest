//
//  MountainOverlayView.swift
//  KoyaQuest
//
//  Created by Kevin K Collins on 2021/11/13.
//

import SwiftUI

struct MountainOverlayView: View {
    var body: some View {
        ZStack {
            Image("mtns")
                .resizable()
                .aspectRatio(contentMode: .fill)

                .edgesIgnoringSafeArea(.all)
            VStack {

                TitleView(fullCaption: false)
                    .padding(.top, 40)
                Spacer()
            }

        }
    }
}

struct MountainOverlayView_Previews: PreviewProvider {
    static var previews: some View {
        MountainOverlayView()
    }
}

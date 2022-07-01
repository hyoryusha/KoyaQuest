//
//  BarcodeOverlayView.swift
//  KoyaQuest
//
//  Created by Kevin K Collins on 2022/05/19.
//

import SwiftUI

struct BarcodeOverlayView: View {
    var body: some View {
        Image(systemName: "barcode.viewfinder")
            .resizable()
            .scaledToFit()
            .opacity(0.3)
//            .animation(
//                .easeInOut(duration: 1)
//                    .repeatForever(autoreverses: true),
//                value: 1.0
//            )
    }
}

struct BarcodeOverlayView_Previews: PreviewProvider {
    static var previews: some View {
        BarcodeOverlayView()
    }
}

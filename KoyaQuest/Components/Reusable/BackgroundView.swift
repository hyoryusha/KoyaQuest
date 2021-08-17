//
//  BackgroundView.swift
//  KoyaQuest
//
//  Created by Kevin K Collins on 2021/05/30.
//

import SwiftUI

struct BackgroundView: View {
    let startPoint = UnitPoint(x: 0.5, y: -0.75)
    var body: some View {
        LinearGradient(gradient: Gradient(colors: [.koyaPurple, .black]), startPoint: startPoint, endPoint: .bottom)
            .edgesIgnoringSafeArea(.all)
    }
}

struct BackgroundView_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundView()
    }
}

//
//  DaimonSolutionOverlay.swift
//  KoyaQuest
//
//  Created by Kevin K Collins on 2021/11/12.
//

import SwiftUI

struct DaimonSolutionOverlay: View {
    var body: some View {
        Image("daimon_solution")
            .resizable()
            //.scaledToFit()
            .frame(width: 200, height: 150)
            .offset(y: -82)
    }
}

struct DaimonSolutionOverlay_Previews: PreviewProvider {
    static var previews: some View {
        DaimonSolutionOverlay()
    }
}

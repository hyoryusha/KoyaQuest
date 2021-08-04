//
//  LoadingView.swift
//  KoyaQuest
//
//  Created by Kevin K Collins on 2021/06/04.
//

import SwiftUI

struct LoadingView: View {

        var body: some View {
            VStack {
                ZStack {
                    Color(.systemBackground)
                        .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)

                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(
                                            tint: .secondary
                        ))
                        .scaleEffect(1.5)
                }
            }
        }
    }

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}

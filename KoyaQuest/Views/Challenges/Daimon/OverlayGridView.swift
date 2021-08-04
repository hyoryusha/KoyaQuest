//
//  OverlayGridView.swift
//  KoyaQuest
//
//  Created by Kevin K Collins on 2021/06/05.
//

import SwiftUI

struct OverlayGridView: View {
    let data = Array(1...15).map {"\($0)"}
    let layout = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    var body: some View {
        ScrollView {
            LazyVGrid(columns: layout, spacing: 4) {
                ForEach(data, id: \.self) {item in
                    ZStack {
                        VStack {
                            HStack {
                                ZStack {
                                    Circle()
                                        .frame(
                                            width: 19,
                                            height: 19
                                        )
                                        .foregroundColor(.white)
                                        .shadow(
                                            color: .black,
                                            radius: 2,
                                            x: 0.5,
                                            y: 2.0
                                        )
                                    Text(item)
                                        .font(.footnote)
                                        .bold()
                                        .foregroundColor(.koyaRed)
                                }
                            }
                        }
                        RoundedRectangle(cornerRadius: 0)
                            .stroke(Color.koyaRed, lineWidth: 2)
                            .frame(height: 54)
                            .foregroundColor(.gray)
                            .opacity(0.4)
                    }
                }
            }
        }
        .padding(2)
    }
}

struct OverlayGridView_Previews: PreviewProvider {
    static var previews: some View {
        OverlayGridView()
    }
}

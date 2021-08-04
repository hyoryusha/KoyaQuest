//
//  ToggleStyle+Extension.swift
//  KoyaQuest
//
//  Created by Kevin K Collins on 2021/06/04.
//

import SwiftUI

struct CheckboxStyle: ToggleStyle {

    func makeBody(configuration: Self.Configuration) -> some View {
        return HStack {
        configuration.label
        Image(systemName: configuration.isOn ? "checkmark.circle.fill" : "circle")
            .resizable()
            .frame(width: 24, height: 24)
            .foregroundColor(configuration.isOn ? Color.koyaOrange : Color.koyaDarkText)
            .font(.system(size: 16, weight: .light, design: .default))
            .onTapGesture {
                configuration.isOn.toggle()
            }
        }
    }
}

//
//  DirectionDistanceIndicator.swift
//  KoyaQuest
//
//  Created by Kevin K Collins on 2022/05/14.
//

import SwiftUI

struct DirectionDistanceIndicator: View {
    var isVajraChallenge: Bool = false
    var distance: Double?
    var rotation: Double?
    var inRange: Bool { distance ?? 100.00 < 11 ? true : false }
    var color: Color?
    var body: some View {
        VStack {
            HStack {
                Image(systemName: inRange ? "scope" : "arrow.up.circle")
                .font(.largeTitle)
                .foregroundColor(.white)
                .rotationEffect(.degrees(rotation ?? 0.0))
                .animation(.easeIn, value: rotation ?? 0.0)
                //.padding()
                if inRange {
                Text("VERY NEAR" )
                    .font(.title)
                    .foregroundColor(.white)
                } else {
                Text("\(distance ?? 100.0, specifier: "%.0f") m" )
                    .font(.largeTitle)
                    .foregroundColor(.white)
                }
            }
            .frame(
                width: 280,
                height: 56,
                alignment: .center
            )
            .background(color ?? .red)
            .cornerRadius(20.0)
            .padding(.top, 6)
            if !isVajraChallenge {
                Text(inRange ? "You should see it nearby." : "Stay on the paved walkways.")
                    .font(.headline)
                    .bold()
                    .foregroundColor(inRange ? .koyaGreen : .koyaOrange)
            }
        }
        .padding(.bottom, 8)
    }
}

struct DirectionDistanceIndicator_Previews: PreviewProvider {
    static var previews: some View {
        DirectionDistanceIndicator()
    }
}

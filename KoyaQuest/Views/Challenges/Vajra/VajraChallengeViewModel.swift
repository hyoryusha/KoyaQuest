//
//  VajraChallengeViewModel.swift
//  KoyaQuest
//
//  Created by Kevin K Collins on 2021/06/06.
//

import SwiftUI
import CoreLocation

final class VajraChallengeViewModel: ObservableObject {
    @Published var found: Bool = false
    @Published var zapped: Bool = false
    @Published var distance: Double = 1000.00
    @Published var isShowingModal = false

    var statusText: String {
        found  ? "You found it!" : "Keep searching..."
    }

    var proximity: String {
        " \(distance) m. "
    }

    var statusTextColor: Color {
        found ? .green : .red
    }

    var distanceIndicatorColor: Color {
        switch distance {
        case 99.00..<1000.00:
            return Color.red
        case 49.00..<99.00:
            return Color.yellow
        case 0.00..<49:
            return Color.koyaGreen
        default:
            return Color.red
        }
    }
    
    var rotation: Double {
        let degrees = (self.heading - self.bearing) * -1
        return degrees
    }

    var bearing: CLLocationDirection = 0.0
    var heading: Double = 0.0
}

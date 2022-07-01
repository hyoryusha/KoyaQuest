////
////  Haptics.swift
////  KoyaQuest
////
////  Created by Kevin K Collins on 2022/05/21.
////
//
//import SwiftUI
//import CoreHaptics
//
import SwiftUI
import CoreHaptics

final class HapticEngine: ObservableObject {
    private var engine: CHHapticEngine?

    // MARK: - HAPTICS
    func prepareHaptics() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        do {
            self.engine = try CHHapticEngine()
            try engine?.start()
        } catch {
            print("There was an error creating the engine: \(error.localizedDescription)")
        }
    }

     func vibrationAlert() {
        prepareHaptics()
        var events = [CHHapticEvent]()
         for _ in 1...5 {
             for amt in stride(from: 0, to: 1, by: 0.1) {
                 let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: Float(1 - amt))
                 let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: Float(1 - amt))
                 let event = CHHapticEvent(
                     eventType: .hapticTransient,
                     parameters: [intensity, sharpness],
                     relativeTime: 1 + amt
                 )
                 events.append(event)
             }
         }

        do {
            let pattern = try CHHapticPattern(events: events, parameters: [])
            let player = try engine?.makePlayer(with: pattern)
            try player?.start(atTime: 0)
        } catch {
            print("Failed to play pattern: \(error.localizedDescription).")
        }
    }
}

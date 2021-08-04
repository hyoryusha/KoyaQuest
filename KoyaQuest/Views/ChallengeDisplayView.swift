//
//  ChallengeDisplayView.swift
//  KoyaQuest
//
//  Created by Kevin K Collins on 2021/06/04.
//

import SwiftUI
import CoreHaptics

struct ChallengeDisplayView: View {
    @EnvironmentObject var appData: AppData
    
    @State private var engine: CHHapticEngine?
    @Binding var isPlayingGame: Bool

    var enteredZone: Area
    var body: some View {
        VStack {
            Image("challenge_banner")
                .resizable()
                .cornerRadius(0)
            Spacer()
            ChallengeDescriptionView(
                enteredZone: enteredZone
            )
                .padding()
        }
        .onAppear {
            vibrationAlert()
        }
            .frame(width: 300, height: 472)
            .background(Color.koyaSky)
            .cornerRadius(12)
            .overlay(Button {
                isPlayingGame = false
            } label: {
                HStack {
                    XDismissButton()
                    Text("Disable Gameplay")
                        .baselineOffset(6.0)
                        .font(.footnote)
                        .foregroundColor(.gray)
                }

            }, alignment: .topLeading)
        }

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
        for amt in stride(from: 0, to: 1, by: 0.1) {
            let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: Float(amt))
            let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: Float(amt))
            let event = CHHapticEvent(
                eventType: .hapticTransient,
                parameters: [intensity, sharpness],
                relativeTime: amt
            )
            events.append(event)
        }

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

        for amt in stride(from: 0, to: 1, by: 0.1) {
            let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: Float(amt))
            let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: Float(amt))
            let event = CHHapticEvent(
                eventType: .hapticTransient,
                parameters: [intensity, sharpness],
                relativeTime: amt
            )
            events.append(event)
        }

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

        do {
            let pattern = try CHHapticPattern(events: events, parameters: [])
            let player = try engine?.makePlayer(with: pattern)
            try player?.start(atTime: 0)
        } catch {
            print("Failed to play pattern: \(error.localizedDescription).")
        }
    }
}

struct ChallengeDisplayView_Previews: PreviewProvider {
    static var previews: some View {
        ChallengeDisplayView(isPlayingGame: .constant(true), enteredZone: daimonArea)
    }
}

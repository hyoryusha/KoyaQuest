//
//  KoyakunChallengeView.swift
//  KoyaQuest
//
//  Created by Kevin K Collins on 2021/06/04.
//

import SwiftUI
import Combine

struct KoyakunChallengeView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var appData: AppData
    @EnvironmentObject var locationManager: LocationManager
    @StateObject var viewModel = KoyakunChallengeViewModel()
    @State var message = "Catch 'em all?"
    @State private var showRotation = false
    @State var timer: AnyCancellable?
    @State private var messages: [String] = [ "Koyakun will appear and disappear randomly",  "Scan in all directions.", "You don't need to tap the screen.", "Just move your iPhone near each target." , "You need to be within 20 cm." , "Happy hunting!"]

    var body: some View {
        ZStack {
            KoyakunCatcherView(viewModel: self.viewModel,
                               completed: $viewModel.completed)
            if showRotation {
                VStack {
                    Text(message)
                        .padding(.top, 8)
                        .padding(.bottom, 8)
                        .frame(minWidth: 320, maxWidth: .infinity)
                        .background(Color.gray.opacity(0.6))
                        .font(.headline)
                        .multilineTextAlignment(.center)
                    Spacer()
                }
                .animation(.easeIn(duration: 1.0))
                .padding(.top, 60)
            }

            VStack {
                XDismissButtonRight()
                    .offset(x: 0, y: 0)
                    .padding(.top, 24)
                    .padding(.trailing, 30)
                Spacer()
            }
            .overlay( viewModel.completed ? MountainOverlayView() : nil)
            if viewModel.completed {
                let earnedPoints = viewModel.points
                let points = min(koyakunChallenge.maxPoints, earnedPoints)
                ChallengeFeedbackView(
                    appData: appData,
                    locationManager: locationManager,
                    challenge: koyakunChallenge, text: "Nice job!",
                    points: points,
                    success: viewModel.completed
                )
                .offset(x: 0.0, y: -40.0)
            }
        }
        .ignoresSafeArea(.all)
        .navigationBarTitle(Text(""))
        .navigationBarHidden(true)
        .onAppear {

            DispatchQueue.main.asyncAfter(deadline: .now() + 6.5) {
                showRotation = true
                startRotation(with: messages)
            }
        }
    }
    private func startRotation(with messages: [String]) {
        guard !messages.isEmpty else { return }

        var index = 0
        self.message = messages[0]
        self.timer = Timer.publish(every: 7, on: .main, in: .common).autoconnect().sink { output in
            index += 1
            guard index < messages.count else {
                self.timer?.cancel()
                self.showRotation = false
                return
            }
            self.message = messages[index]
        }
    }
}

struct KoyakunChallengeView_Previews: PreviewProvider {
    static var previews: some View {
        KoyakunChallengeView()
            .environmentObject(AppData())
            .environmentObject(LocationManager())
            .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
    }
}

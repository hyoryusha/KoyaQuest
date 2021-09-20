//
//  KenshinMissionView.swift
//  KoyaQuest2021
//
//  Created by Kevin K Collins on 2021/05/03.
//

import SwiftUI
import AVKit

struct KenshinMissionView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var playable = false
    var body: some View {
        VStack {
            Text("Review Your Mission")
                .font(.title3)
                .bold()
                .foregroundColor(.koyaOrange)
                .padding()
            if playable {
                VideoPlayer(player: AVPlayer(
                                url: Bundle.main.url(
                                    forResource: "uesugi_ghost",
                                    withExtension: "mp4")!
                    )
                )
                    .frame(height: 280)

                Text("Tap to replay video.")
                    .font(.footnote)
                    .italic()
                    .foregroundColor(.gray)
            }
            Button {
                playable.toggle()
            } label: {
                HStack {
                    Image(systemName: playable ? "video.slash.fill" : "video.fill")
                }
                Text(playable ? "Hide Video" : "Show Video Again")

            }
                .font(.footnote)
                .foregroundColor(.koyaOrange)
                .padding(.top)

            ScrollView {
                // swiftlint:disable:next line_length
                Text("\"My name is Uesugi Kenshin. Now, I rest peacefully here at Mt. Kōya, but in life I was a warrior and led many soldiers into bloody battle. \nAt a place called Kawanakajima, I fought many times to defeat my arch enemy. To no avail.\nNow, he, too, awaits salvation beneath the moss of Oku-no-in.\nYour mission is to seek out the nearby resting place of the man known as the \"Tiger of Kai,\" and offer a prayer for his soul.\"")
                .font(.body)
                .multilineTextAlignment(.leading)
                .foregroundColor(.white)
                    .padding()
            }
            Button {
                playable = false
                self.presentationMode.wrappedValue.dismiss()
            } label: {
                Text("Exit")
                    .font(.headline)
                    .foregroundColor(.koyaOrange)
                    .padding()
            }
            Spacer()
        }
        .background(Color(.black))
        .ignoresSafeArea()
        .statusBar(hidden: true)
    }
}
struct KenshinMissionView_Previews: PreviewProvider {
    static var previews: some View {
        KenshinMissionView()
    }
}

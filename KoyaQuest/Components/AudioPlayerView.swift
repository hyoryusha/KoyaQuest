//
//  ContentView.swift
//  SampleAudioDescription
//
//  Created by Kevin K Collins on 2021/06/30.
//

import SwiftUI
import AVFoundation

struct AudioPlayerView: View {
    @State private var playingAudio: Bool = false
    @StateObject var audioModel = AudioModel()
    var audioFile: String
    var body: some View {
        VStack {
            if !audioModel.hidePlayButton {
                Toggle(isOn: $playingAudio, label: {
                    Text(playingAudio ? "Stop Audio" : "Play Audio")
                        .font(.subheadline)
                        .foregroundColor(playingAudio ? .koyaRed : Color.koyaGreen)
                })
                .toggleStyle(AudioToggleStyle())
                        .onChange(of: playingAudio) { play in
                            if play {
                                audioModel.soundFileName = audioFile
                                audioModel.playAudio()
                            } else {
                                audioModel.currentTime = audioModel.audioPlayer.currentTime
                                audioModel.stopAudio()
                            }
                        }
                .onChange(of: audioModel.didFinishPlaying) { finished in
                    if finished {
                        playingAudio = false
                        audioModel.isPlaying.toggle()
                    }
                }
            } else {
                EmptyView()
            }
        }
        .alert(item: $audioModel.alertItem) { alertItem in
            Alert(title: alertItem.title,
                  message: alertItem.message,
                  dismissButton: alertItem.dismissButton)
        }
    }
}

struct AudioPlayerView_Previews: PreviewProvider {
    static var previews: some View {
        AudioPlayerView(audioFile: "1000")
    }
}

struct AudioToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        Button {
            configuration.isOn.toggle()
        } label: {
            Label {
                configuration.label
            } icon: {
                Image(systemName: configuration.isOn ? "pause.fill" : "play.circle")
                    .foregroundColor(configuration.isOn ? .koyaRed : .koyaGreen)
                    .accessibility(label: Text(configuration.isOn ? "Checked" : "Unchecked"))
                    .imageScale(.large)
            }
        }
        .buttonStyle(PlainButtonStyle())
    }
}

struct PlayButton: View {
    @Binding var playingAudio: Bool
    var body: some View {
        HStack {
            Button(action: {
                playingAudio.toggle()
            }, label: {
                Image(systemName: playingAudio ? "pause.fill" : "play.circle")
                    .font(.title)
               })
            Text(playingAudio ? "Stop" : "Play")
                .font(.title)
                .bold()
                .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
            }
    }
}


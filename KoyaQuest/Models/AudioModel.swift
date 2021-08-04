//
//  AudioModel.swift
//  SampleAudioDescription
//
//  Created by Kevin K Collins on 2021/06/30.
//

import SwiftUI
import AVFoundation

import Foundation
import SwiftUI
import AVFoundation

class AudioModel: NSObject, ObservableObject, AVAudioPlayerDelegate {
    @Published var didFinishPlaying = false
    @Published var isPlaying: Bool = false {
           willSet {
               if newValue == true {
                   playAudio()
               }
           }
       }
    @Published var alertItem: AlertItem?
    @Published var hidePlayButton: Bool = false
    var currentTime: TimeInterval?
    //var audioPlayer = AVAudioPlayer()
    var audioPlayer: AVAudioPlayer!
    var soundFileName = ""

    override init() {
           super.init()
           //audioPlayer.delegate = self
       }

    func playAudio() {
        guard let path = Bundle.main.path(forResource: soundFileName, ofType: "mp3") else {
            self.alertItem = AlertContext.noAudioFile
            self.hidePlayButton = true
            return
            
        }
        self.hidePlayButton = false
        let url = URL(fileURLWithPath: path)

        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer.delegate = self
            audioPlayer.currentTime = self.currentTime ?? 0.0
            audioPlayer.play()
        }
        catch {
            // error
            self.alertItem = AlertContext.noAudioFile
        }
    }

    func stopAudio() {
        audioPlayer.pause()
    }
}

extension AudioModel {
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        guard flag else {return}
        didFinishPlaying = true
        self.currentTime = 0.0
    }
}

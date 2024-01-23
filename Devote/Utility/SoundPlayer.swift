//
//  SoundPlayer.swift
//  Devote
//
//  Created by Nonato Sousa on 23/01/24.
//

import Foundation
import AVFoundation

enum AudioClip {
    case Ding
    case Rise
    case Tap
}

var audioPlayer: AVAudioPlayer?

func playSoundAndHaptic(_ audioClip: AudioClip) {
    let clipName = getAudioClip(audioClip)
    
    if let audioPath = Bundle.main.path(forResource: clipName, ofType: "mp3") {
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: audioPath))
            audioPlayer?.play()
        } catch {
            print("Couldn't find and play the audio clipe source!")
        }
    }
    
    haptics.notificationOccurred(.success)
}

private func getAudioClip(_ audioClip: AudioClip) -> String {
    switch audioClip {
    case .Ding:
        return "sound-ding"
    case .Rise:
        return "sound-rise"
    case .Tap:
        return "sound-tap"
    }
}

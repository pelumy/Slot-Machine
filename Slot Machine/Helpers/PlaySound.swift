//
//  PlaySound.swift
//  Slot Machine
//
//  Created by Itunu Raimi on 26/02/2021.
//

import AVFoundation

var audioPlayer: AVAudioPlayer?

func playSound(fileName: String, fileFormat: String) {
    if let path = Bundle.main.path(forResource: fileName, ofType: fileFormat) {
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
            audioPlayer?.play()
        } catch {
            print("Could not find and play the sound file")
        }
    }
    
}

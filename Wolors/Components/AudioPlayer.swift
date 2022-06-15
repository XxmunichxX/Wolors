//
//  AudioPlayer.swift
//  Wolors
//
//  Created by Francesco Monaco on 14/06/22.
//

import Foundation
import AVKit

class AudioManager {
    
    static let shared = AudioManager()
    
    var player: AVAudioPlayer?
    
    func startBackGroundMusic() {
        guard let url = Bundle.main.url(forResource: "soundTrack", withExtension: "mp3") else {
            print("No resource found: soundTrack")
            return
        }
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.numberOfLoops = -1
            player?.play()
        } catch {
            print("Fail to inizialize player", error)
        }
    }
    
    func startPlayer(track: String) {
        guard let url = Bundle.main.url(forResource: track, withExtension: "mp3") else {
            print("No resource found: \(track)")
            return
        }
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
           
            player?.play()
        } catch {
            print("Fail to inizialize player", error)
        }
    }
}

//
//  Sound.swift
//  Obstacle Pong
//
//  Created by Buka Cakrawala on 7/8/16.
//  Copyright © 2016 Buka Cakrawala. All rights reserved.
//

import AVFoundation

var backgroundMusicPlayer = AVAudioPlayer()

func playBackgroundMusic(filename: String) {
    let url = NSBundle.mainBundle().URLForResource(filename, withExtension: nil)
    guard let newURL = url else {
        print("Could not find file: \(filename)")
        return
    }
    do {
        backgroundMusicPlayer = try AVAudioPlayer(contentsOfURL: newURL)
        backgroundMusicPlayer.numberOfLoops = -1
        backgroundMusicPlayer.prepareToPlay()
        backgroundMusicPlayer.play()
    } catch let error as NSError {
        print(error.description)
    }
}


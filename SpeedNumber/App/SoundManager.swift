//
//  SoundManager.swift
//  SpeedNumber
//
//  Created by Ivan Ruiz Monjo on 07/04/2020.
//  Copyright © 2020 Ivan Ruiz Monjo. All rights reserved.
//

import Foundation
import AVFoundation
import UIKit

import AudioToolbox

final class SoundManager {

    enum Sound: String {
        case correct
        case incorrect
    }
    
    private static var soundURL: NSURL? = nil
    private static var soundID: SystemSoundID = 0

    static func play(_ sound: SoundManager.Sound) {
        let filePath = Bundle.main.path(forResource: sound.rawValue, ofType: "wav")
        soundURL = NSURL(fileURLWithPath: filePath!)
        if let url = soundURL {
            
            AudioServicesCreateSystemSoundID(url, &soundID)
            AudioServicesPlaySystemSound(soundID)
        }
    }
}

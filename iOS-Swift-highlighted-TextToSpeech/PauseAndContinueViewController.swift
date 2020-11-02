//
//  PauseAndContinueViewController.swift
//  iOS-Swift-highlighted-TextToSpeech
//
//  Created by Arifin Firdaus on 02/11/20.
//  Copyright © 2020 Arifin Firdaus. All rights reserved.
//

import UIKit
import AVFoundation

class PauseAndContinueViewController: UIViewController, AVSpeechSynthesizerDelegate {
    
    @IBOutlet weak var textLabel: UILabel!
    
    var synthesizer = AVSpeechSynthesizer()
    var playQueue = [AVSpeechUtterance]()
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        for i in 1...10 {
            
            let stringNb = "Sentence number " + String(i) + " of the speech synthesizer."
            
            let utterance = AVSpeechUtterance(string: stringNb)
            utterance.rate = AVSpeechUtteranceDefaultSpeechRate
            utterance.pitchMultiplier = 1.0
            utterance.volume = 1.0
            
            playQueue.append(utterance)
        }

        synthesizer.delegate = self

        for utterance in playQueue {
            synthesizer.speak(utterance)
        }
    }
    
    //AVSpeechSynthesizerDelegate protocol method to highlight the vocalized word.
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer,
                           willSpeakRangeOfSpeechString characterRange: NSRange,
                           utterance: AVSpeechUtterance) {

        let attributedString = NSMutableAttributedString(string: utterance.speechString)
        attributedString.addAttribute(.font,
                                      value: UIFont.boldSystemFont(ofSize: 19),
                                      range: characterRange)

        textLabel.attributedText = attributedString

        let subString = attributedString.attributedSubstring(from: characterRange)
        print("word : \(subString.string)")
    }
    
    @IBAction func pauseAction(_ sender: UIBarButtonItem) {
        if (synthesizer.isSpeaking == true) {
            if (synthesizer.pauseSpeaking(at: .immediate) == true) {
                print("PAUSE")
            } else {
                print("P.R.O.B.L.E.M. when pausing.")
            }
        }
    }

    @IBAction func resumeAction(_ sender: UIBarButtonItem) {
        if (synthesizer.isPaused == true) {
            if (synthesizer.continueSpeaking() == true) {
                print("RESUME")
            } else {
                print("P.R.O.B.L.E.M. when resuming.")
            }
        }
    }
  
}

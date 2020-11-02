//
//  StopAndContinueViewController.swift
//  iOS-Swift-highlighted-TextToSpeech
//
//  Created by Arifin Firdaus on 02/11/20.
//  Copyright © 2020 Arifin Firdaus. All rights reserved.
//

import UIKit
import AVFoundation

class StopAndContinueViewController: UIViewController {
    @IBOutlet weak var label: UILabel!
    var currentUtterance: AVSpeechUtterance?
    let synthesizer = AVSpeechSynthesizer()
    
    var remainingText: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        label.numberOfLines = 0
        label.text = "1. Ketuhanan Yang Maha Esa. 2. Kemanusiaan yang adil dan beradab. 3. Persatuan Indonesia. 4. Kerakyatan yang dipimpin oleh hikmat kebijaksanaan dalam permusyawaratan dan perwakilan. 5. Keadilan sosial bagi seluruh rakyat Indonesia."
        
        synthesizer.delegate = self
    }
  
    @IBAction func stop(_ sender: UIBarButtonItem) {
        synthesizer.stopSpeaking(at: .word)
    }
    
    @IBAction func continueSpeak(_ sender: UIBarButtonItem) {
        guard let remainingText = self.remainingText else { return }
        let newUtterance = AVSpeechUtterance(string: remainingText)
        newUtterance.voice = AVSpeechSynthesisVoice(language: "id_ID")
        synthesizer.speak(newUtterance)
    }
    
    @IBAction func speak(_ sender: UIBarButtonItem) {
        let initialUtterance = AVSpeechUtterance(string: label.text!)
        initialUtterance.voice = AVSpeechSynthesisVoice(language: "id_ID")
        synthesizer.speak(initialUtterance)
    }
}


// MARK: - AVSpeechSynthesizerDelegate

extension StopAndContinueViewController: AVSpeechSynthesizerDelegate {
    
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, willSpeakRangeOfSpeechString characterRange: NSRange, utterance: AVSpeechUtterance) {
        self.currentUtterance = utterance
        let remainingText = utterance.speechString.dropFirst(characterRange.location)
        self.remainingText = String(remainingText)
        print("reaminingText: \(remainingText)")
    }
}

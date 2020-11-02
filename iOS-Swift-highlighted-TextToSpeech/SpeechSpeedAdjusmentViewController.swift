//
//  SpeechSpeedAdjusmentViewController.swift
//  iOS-Swift-highlighted-TextToSpeech
//
//  Created by Arifin Firdaus on 28/10/20.
//  Copyright © 2020 Arifin Firdaus. All rights reserved.
//

import UIKit
import AVFoundation

class SpeechSpeedAdjusmentViewController: UIViewController {
    @IBOutlet weak var textView: UITextView!
    var synthesizer: AVSpeechSynthesizer!
    var currentRange: NSRange = NSRange(location: 0, length: 0)
    var text: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let generator = MockStringGenerator()
        textView.text = generator.generateText()
        
        text = textView.text!
        
        synthesizer = AVSpeechSynthesizer()
        synthesizer.delegate = self
    }
    
    @IBAction func didTapSpeakButton(_ sender: UIBarButtonItem) {
        synthesizer.speak(makeUtterance(for: AVSpeechUtteranceDefaultSpeechRate, with: text!))
    }
    
    @IBAction func didChangeSpeakSpeed(_ sender: UISlider) {
        if synthesizer.isSpeaking {
            synthesizer.stopSpeaking(at: .immediate)
            // ambil range ketika dia stop
            // ambil indx kata ketika dia stop
            // lempar sbg start index ketika dia speak lagi.
            
            // self.currentRange
        }
        
        if isStillHaveTextThatNeedsToBeSpoken() {
            attemptSpeakTextThatNeedsToBeSpoken(withRate: sender.value)
        }
    }
    
    private func isStillHaveTextThatNeedsToBeSpoken() -> Bool {
        return currentRange.length > 0
    }
    
    private func attemptSpeakTextThatNeedsToBeSpoken(withRate rate: Float) {
        guard let text = self.text else { return }
        if NSMaxRange(self.currentRange) >= text.count {
            return
        }
        let offfset = NSMaxRange(currentRange)
        
        let startIndex = text.index(text.startIndex, offsetBy: offfset)
        // let newString = string.substring(from: startIndex)
        let newString = String(text[startIndex...])
        self.text = newString
        synthesizer.speak(makeUtterance(for: rate, with: text))
    }
    
    private func makeUtterance(for rate: Float, with str: String) -> AVSpeechUtterance {
        let utterance = AVSpeechUtterance(string: str)
        utterance.rate = rate
        utterance.volume = 0.2
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        return utterance
    }
    
}


// MARK: - AVSpeechSynthesizerDelegate

extension SpeechSpeedAdjusmentViewController: AVSpeechSynthesizerDelegate {
    
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, willSpeakRangeOfSpeechString characterRange: NSRange, utterance: AVSpeechUtterance) {
        let mutableAttributedString = NSMutableAttributedString(string: utterance.speechString)
        mutableAttributedString.addAttribute(
            .foregroundColor,
            value: UIColor.red,
            range: characterRange
        )
        textView.attributedText = mutableAttributedString
        
        self.currentRange = characterRange
        
        let remainingText = utterance.speechString.dropFirst(characterRange.location)
    }
    
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
        textView.attributedText = NSAttributedString(string: utterance.speechString)
        // self.currentRange = NSRange(location: 0, length: 0)
    }
    
}

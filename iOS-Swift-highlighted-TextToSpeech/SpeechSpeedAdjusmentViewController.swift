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
    var string: String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let generator = LoremIpsumGenerator()
        textView.text = generator.generateText()
        
        string = textView.text!
        
        synthesizer = AVSpeechSynthesizer()
        synthesizer.delegate = self
    }
    
    @IBAction func didTapSpeakButton(_ sender: UIBarButtonItem) {
        synthesizer.speak(makeUtterance(for: AVSpeechUtteranceDefaultSpeechRate, with: string!))
    }
    
    @IBAction func didChangeSpeakSpeed(_ sender: UISlider) {
        if synthesizer.isSpeaking {
            synthesizer.stopSpeaking(at: .immediate)
        }
        if isStillHaveTextThatNeedsToBeSpoken() {
            attemptSpeakTextThatNeedsToBeSpoken(withRate: sender.value)
        }
    }
    
    private func isStillHaveTextThatNeedsToBeSpoken() -> Bool {
        return currentRange.length > 0
    }
    
    private func attemptSpeakTextThatNeedsToBeSpoken(withRate rate: Float) {
        guard let string = string else { return }
        if NSMaxRange(currentRange) >= string.count {
            return
        }
        let startIndex = string.index(string.startIndex, offsetBy: NSMaxRange(currentRange))
        // let newString = string.substring(from: startIndex)
        let newString = String(string[startIndex...])
        self.string = newString
        synthesizer.speak(makeUtterance(for: rate, with: string))
    }
    
    func makeUtterance(for rate: Float, with str: String) -> AVSpeechUtterance {
        let utterance = AVSpeechUtterance(string: str)
        utterance.rate = rate
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        return utterance
    }
    
}


// MARK: - AVSpeechSynthesizerDelegate

extension SpeechSpeedAdjusmentViewController: AVSpeechSynthesizerDelegate {
    
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, willSpeakRangeOfSpeechString characterRange: NSRange, utterance: AVSpeechUtterance) {
        print("speaking")
        let mutableAttributedString = NSMutableAttributedString(string: utterance.speechString)
        mutableAttributedString.addAttribute(.foregroundColor, value: UIColor.red, range: characterRange)
        textView.attributedText = mutableAttributedString
        
        debugPrint(characterRange.toRange())
        currentRange = characterRange
    }
    
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
        print("finish")
        textView.attributedText = NSAttributedString(string: utterance.speechString)
    }
    
}

//
//  ViewController.swift
//  iOS-Swift-highlighted-TextToSpeech
//
//  Created by Arifin Firdaus on 06/10/20.
//  Copyright © 2020 Arifin Firdaus. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    @IBOutlet weak var textView: UITextView!
    let synthesizer = AVSpeechSynthesizer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textView.showsVerticalScrollIndicator = true
        
//        for family in UIFont.familyNames {
//            let sName: String = family as String
//            print("family: \(sName)")
//
//            for name in UIFont.fontNames(forFamilyName: sName) {
//                print("name: \(name as String)")
//            }
//        }
    }
    
    @IBAction func speakButtonDidTapped(_ sender: UIBarButtonItem) {
        let string = textView.text!
        let utterance = AVSpeechUtterance(string: string)
        utterance.volume = 0
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        
        synthesizer.delegate = self
        synthesizer.speak(utterance)
    }
    
}


// MARK: - AVSpeechSynthesizerDelegate

extension ViewController: AVSpeechSynthesizerDelegate {
    
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, willSpeakRangeOfSpeechString characterRange: NSRange, utterance: AVSpeechUtterance) {
        let mutableAttributedString = NSMutableAttributedString(string: utterance.speechString)
        mutableAttributedString.addAttribute(.underlineStyle, value:  NSUnderlineStyle.thick.rawValue, range: characterRange)
        mutableAttributedString.addAttribute(.underlineColor, value: UIColor.systemBlue, range: characterRange)
        textView.attributedText = mutableAttributedString
        textView.font = UIFont.systemFont(ofSize: 72, weight: .light)
        textView.scrollRangeToVisible(makeCustomCharacterRange(from: characterRange))
    }
    
    private func makeCustomCharacterRange(from characterRange: NSRange) -> NSRange {
        return NSRange(location: characterRange.location + 24, length: characterRange.length)
    }
    
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
        textView.attributedText = NSAttributedString(string: utterance.speechString)
    }
}


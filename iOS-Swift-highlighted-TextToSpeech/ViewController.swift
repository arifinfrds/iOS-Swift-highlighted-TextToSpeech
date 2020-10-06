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
    }

    @IBAction func speakButtonDidTapped(_ sender: UIBarButtonItem) {
        let string = textView.text!
        let utterance = AVSpeechUtterance(string: string)
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US")

        synthesizer.delegate = self
        synthesizer.speak(utterance)
    }
    
}


// MARK: - AVSpeechSynthesizerDelegate

extension ViewController: AVSpeechSynthesizerDelegate {
    
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, willSpeakRangeOfSpeechString characterRange: NSRange, utterance: AVSpeechUtterance) {
        let mutableAttributedString = NSMutableAttributedString(string: utterance.speechString)
        mutableAttributedString.addAttribute(.backgroundColor, value: UIColor.systemBlue, range: characterRange)
        textView.attributedText = mutableAttributedString
        textView.font = UIFont.preferredFont(forTextStyle: .body)
    }

    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
        textView.attributedText = NSAttributedString(string: utterance.speechString)
    }
}


//
//  MockStringGenerator.swift
//  iOS-Swift-highlighted-TextToSpeech
//
//  Created by Arifin Firdaus on 28/10/20.
//  Copyright © 2020 Arifin Firdaus. All rights reserved.
//

import Foundation

struct MockStringGenerator {
    func generateText() -> String {
        return """
            Optical character recognition is the electronic or mechanical conversion of images of typed, handwritten or printed text into machine-encoded text, whether from a scanned document, a photo of a document, a scene-photo (for example the text on signs and billboards in a landscape photo) or from subtitle text superimposed on an image (for example: from a television broadcast).

            With our friendly typesetting feature, you can adjust the texts’ font and size. You can adjust the line spacing and the spacing between letters. Readdy provides you with some background colors to make your reading experience more comfortable.

            With text to speech feature, Readdy can detect your scanned text and read it aloud in 2 languages, Indonesian and English.

            """
    }
}

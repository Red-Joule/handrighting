//
//  Spellcheck.swift
//  handrighting
//
//  Created by Dor Rubin on 11/21/16.
//  Copyright © 2016 Red Joule. All rights reserved.
//

import UIKit


class Spellcheck {
    var raw_text: String
    var corrected_text: String
    
    init( raw_text: String) {
        self.raw_text = raw_text
        self.corrected_text = raw_text // set the corrected_text to equal the raw_text by default
    }
    
    func makeCorrection() {        
        // Check spelling of the word
        let textChecker = UITextChecker()
        let misspelledRange = textChecker.rangeOfMisspelledWordInString(
            self.raw_text, range: NSRange(0..<self.raw_text.utf16.count),
            startingAt: 0, wrap: false, language: "en_US")
        
        if misspelledRange.location != NSNotFound,
            let guesses = textChecker.guessesForWordRange(
                misspelledRange, inString: self.raw_text, language: "en_US") as? [String]
        {
            // set the misspelled word first guess as the correct string
            self.corrected_text = guesses.first!
            print("Possible guesses: \(guesses)")
        } else {
            // not a misspelled word or word not found so simply use the resultOfOpenCV as the word to display
            print("Not found")
            
        }
    }
    
}
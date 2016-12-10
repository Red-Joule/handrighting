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
    var result_image: UIImage!
    
    init( raw_text: String) {
        self.raw_text = raw_text
        print(self.raw_text);
        self.corrected_text = "notFound" // set the corrected_text to equal the raw_text by default
    }
    
    func makeCorrection() {
        print("hello from makeCorrection");
        // Check spelling of the word
        let textChecker = UITextChecker()
        let misspelledRange = textChecker.rangeOfMisspelledWordInString(
            self.raw_text, range: NSRange(0..<self.raw_text.utf16.count),
            startingAt: 0, wrap: false, language: "en_US")
        print(misspelledRange);
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
    
    func createImage(in_str: String) {
        var letterImages: [UIImage] = []
        for i in in_str.characters {
            let fname = String(i) + "small.png"
            letterImages.append(UIImage(named: fname)!)
        }
        self.result_image = getMixedImg(letterImages)
    }
    
}

func getMixedImg(imgarray: [UIImage]) -> UIImage {
    
    var height = CGFloat(0)
    var width = CGFloat(0)
    for img in imgarray {
        height = img.size.height
        width += img.size.width
    }
    let size = CGSizeMake(width, height)
    
    UIGraphicsBeginImageContext(size)
    
    let const_height = 30
    let const_width = 20
    var count = 0
    for img in imgarray {
        img.drawInRect(CGRectMake(CGFloat(count*const_width), 0, CGFloat(const_width), CGFloat(const_height)))
        count += 1
    }
    
    let finalImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    
    return finalImage
}
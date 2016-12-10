//
//  CheckViewController.swift
//  handrighting
//
//  Created by Eric Mooney on 12/10/16.
//  Copyright © 2016 Red Joule. All rights reserved.
//

import UIKit

class CheckViewController: UIViewController {
    
    // MARK: Properties
    @IBOutlet weak var imageTextLabel: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var correctedTextLabel: UILabel!
    
    var image: Image?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Set up views if editing an existing Image.
        if let image = image {
            photoImageView.image = image.photo
            let openCVResult = OpenCVWrapper.trainAndTest(photoImageView.image)
            
            let word = Spellcheck(raw_text: openCVResult.lowercaseString);
            print(word);
            word.makeCorrection();
            imageTextLabel.text = "You wrote... " + openCVResult;
            if(word.corrected_text == "notFound") {
                correctedTextLabel.text = "No alternative spellings found.";
            } else {
                correctedTextLabel.text = "Did you mean... " + word.corrected_text.uppercaseString + "?";
            }
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

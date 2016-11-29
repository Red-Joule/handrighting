//
//  DrawViewController.swift
//  handrighting
//
//  Created by Eric Mooney on 10/17/16.
//  Copyright © 2016 Red Joule. All rights reserved.
//

import UIKit

class DrawViewController: UIViewController {

    // MARK: Properties
    
    @IBOutlet weak var drawView: DrawView!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    var photoImage: UIImage!         // The image
    
    // MARK: Actions
    
    @IBAction func clear(sender: UIButton) {
        let theDrawView : DrawView = drawView as DrawView
        theDrawView.lines = []
        theDrawView.setNeedsDisplay()
    }
    
    func saveDrawingToPhotoLibrary() {
        UIGraphicsBeginImageContext(self.drawView.frame.size)
        self.drawView.layer.renderInContext(UIGraphicsGetCurrentContext()!)
        let sourceImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        UIImageWriteToSavedPhotosAlbum(sourceImage, nil, nil, nil)
        photoImage = sourceImage
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        self.drawView.layer.borderWidth = 1.0;

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


    // MARK: - Navigation
    @IBAction func cancel(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    // This method lets you configure a view controller before it's presented.
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if saveButton === sender {
            // Save the drawing to the photo library
            saveDrawingToPhotoLibrary()
            
            // Run the OpenCV OCR on the image
            // resultOfOpenCV = ????
            
            let NavigationController = segue.destinationViewController as! UINavigationController
            let DestinationViewController = NavigationController.topViewController as! ShowViewController
            
            // Get the info that generated this segue.
            let name = "Drawing"
//            let photo = photoImage

            // Run the OpenCV OCR on the image and save as resultOfOpenCV
//            let resultOfOpenCV = "drawring"
            let resultOfOpenCV = "bal"
            
            // Check spelling of the word
            let word = Spellcheck(raw_text: resultOfOpenCV)
            word.makeCorrection()
            word.createImage(word.corrected_text)
            // Set the image to be passed.
            let savedImage = Image(photo: word.result_image!, name: name, text: word.corrected_text) // when resultOfOpenCV availabe, substitute nil for text
            DestinationViewController.image = savedImage
            
        }
    }
    

}

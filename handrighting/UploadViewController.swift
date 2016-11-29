//
//  UploadViewController.swift
//  handrighting
//
//  Created by Eric Mooney on 10/3/16.
//  Copyright © 2016 Red Joule. All rights reserved.
//

import UIKit

class UploadViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    // MARK: Properties

    @IBOutlet weak var photoImageView: UIImageView!         // The image
    @IBOutlet weak var openCVVersionLabel: UILabel!         // Open CV Version
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    /*
     This value is either passed by `ImageTableViewController` in `prepareForSegue(_:sender:)`
     or constructed as part of adding a new image.
     */
    var image: Image?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        openCVVersionLabel.text = OpenCVWrapper.openCVVersionString()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    // MARK: UIImagePickerControllerDelegate
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        // Dismiss the picker if the user canceled.
        dismissViewControllerAnimated(true, completion: nil)
    }

    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        // The info dictionary contains multiple representations of the image, and this uses the original.
        let selectedImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        // Set photoImageView to display the selected image.
        photoImageView.image = selectedImage
                
        // Dismiss the picker.
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    // MARK: Navigation
    @IBAction func cancelButton(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    // This method lets you configure a view controller before it's presented.
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if saveButton === sender {
            
            
            let NavigationController = segue.destinationViewController as! UINavigationController
            let DestinationViewController = NavigationController.topViewController as! ShowViewController
            
            // Get the info that generated this segue.
//            let photo = photoImageView.image

            // Run the OpenCV OCR on the image and save as resultOfOpenCV
//            let resultOfOpenCV = "uppload"
            let resultOfOpenCV = "kab"

            // Check spelling of the word
            let word = Spellcheck(raw_text: resultOfOpenCV)
            word.makeCorrection()
            word.createImage(word.corrected_text)
            // Set the image to be passed.
            let savedImage = Image(photo: word.result_image!, name: nil, text: word.corrected_text) // when resultOfOpenCV available, substitute nil for text
            DestinationViewController.image = savedImage
        
        }
    }
    
    
    // MARK: Actions
    
    @IBAction func selectImageFromPhotoLibrary(sender: UITapGestureRecognizer) {
        
        // UIImagePickerController is a view controller that lets a user pick media from their photo library.
        let imagePickerController = UIImagePickerController()
        
        // Only allow photos to be picked, not taken.
        imagePickerController.sourceType = .PhotoLibrary
        
        // Make sure ViewController is notified when the user picks an image.
        imagePickerController.delegate = self
        
        presentViewController(imagePickerController, animated: true, completion: nil)
    }
    
}


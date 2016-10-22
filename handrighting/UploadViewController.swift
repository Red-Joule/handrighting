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
    @IBOutlet weak var imageNameLabel: UILabel!             // A name for the image
    @IBOutlet weak var imageNameTextField: UITextField!     // To set the name for the image
    @IBOutlet weak var imageTextLabel: UILabel!             // The text calculated for the image
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
        
        // Handle the text field’s user input through delegate callbacks.
        imageNameTextField.delegate = self
        
         // Enable the Save button only if the text field has a valid Meal name.
        checkValidImageName()
        
        openCVVersionLabel.text = OpenCVWrapper.openCVVersionString()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: UITextFieldDelegate
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        // Hide the keyboard.
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        checkValidImageName()
        imageNameLabel.text = textField.text
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        // Disable the Save button while editing.
        saveButton.enabled = false
    }
    
    func checkValidImageName() {
        // Disable the Save button if the text field is empty.
        let text = imageNameTextField.text ?? ""
        saveButton.enabled = !text.isEmpty
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
            
            // Run the OpenCV OCR on the image
            // resultOfOpenCV = ????
            
            let NavigationController = segue.destinationViewController as! UINavigationController
            let DestinationViewController = NavigationController.topViewController as! ShowViewController
            
            // Get the info that generated this segue.
            let name = imageNameTextField.text ?? ""
            let photo = photoImageView.image
            // let text = resultOfOpenCV
            
            // Set the image to be passed.
            let savedImage = Image(photo: photo!, name: name, text: nil) // when resultOfOpenCV available, substitute nil for text
            DestinationViewController.image = savedImage
        
        }
    }
    
    
    // MARK: Actions
    
    @IBAction func selectImageFromPhotoLibrary(sender: UITapGestureRecognizer) {
        // Hide the keyboard.
        imageNameTextField.resignFirstResponder()
        
        // UIImagePickerController is a view controller that lets a user pick media from their photo library.
        let imagePickerController = UIImagePickerController()
        
        // Only allow photos to be picked, not taken.
        imagePickerController.sourceType = .PhotoLibrary
        
        // Make sure ViewController is notified when the user picks an image.
        imagePickerController.delegate = self
        
        presentViewController(imagePickerController, animated: true, completion: nil)
    }
    
}


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
    @IBOutlet weak var givenImageView: UIImageView!
    
    // Keep track of the sample photos
    let givenPhotos = ["BUS", "CAR", "CAT", "DOG", "FISH", "SOCK"];
    let randomNum = Int(arc4random());
    
    var index: Int!;
    var photoImage: UIImage!         // The image
    
//    self.profileImageView.layer.cornerRadius = self.profileImageView.frame.size.width / 2;
//    self.profileImageView.clipsToBounds = YES;
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
        self.givenImageView.layer.cornerRadius = self.givenImageView.frame.size.width / 4;
        self.givenImageView.clipsToBounds = true;
        // Load the random sample image
        let numGivenPhotos = givenPhotos.count;
        index = (Int(randomNum) % Int(numGivenPhotos));
        loadGivenPhoto();
    }
    
    // Set the given image to one from the list
    func loadGivenPhoto() {
        print(index);
        let testPhoto = UIImage(named: givenPhotos[index])!
        givenImageView.image = testPhoto;
       
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
            
            let NavigationController = segue.destinationViewController as! UINavigationController
            let DestinationViewController = NavigationController.topViewController as! ShowViewController
            
            // Get the info that generated this segue.
            let name = givenPhotos[index];
            let photo = photoImage
            // let text = OpenCVWrapper.getStringFromImage()
            
            // Set the image to be passed.
            let savedImage = Image(photo: photo, name: name, text: "resultOfOpenCV") // when resultOfOpenCV availabe, substitute nil for text
            DestinationViewController.image = savedImage
            
        }
    }
    

}

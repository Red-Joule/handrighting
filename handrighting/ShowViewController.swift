//
//  ShowViewController.swift
//  handrighting
//
//  Created by Eric Mooney on 10/19/16.
//  Copyright © 2016 Red Joule. All rights reserved.
//

import UIKit

class ShowViewController: UIViewController {

    // MARK: Properties
    @IBOutlet weak var imageTextLabel: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var givenTextLabel: UILabel!
    @IBOutlet weak var givenImageView: UIImageView!
    
    var image: Image?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Set up views if editing an existing Image.
        if let image = image {
            photoImageView.image = image.photo
            let openCVResult = OpenCVWrapper.trainAndTest(photoImageView.image);
            
            var ending = "Great job!"
            if(openCVResult != image.name){
                ending = "Try again."
            }
            
            givenTextLabel.text = "The answer is: " + image.name! + ". "
            imageTextLabel.text = "You wrote... " + openCVResult + ". " + ending;

            let testPhoto = UIImage(named: image.name!)!;
            givenImageView.image = testPhoto;
            givenImageView.layer.cornerRadius = self.givenImageView.frame.size.width / 4;
            givenImageView.clipsToBounds = true;

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
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
    @IBOutlet weak var imageNameLabel: UILabel!
    @IBOutlet weak var imageTextLabel: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!
    
    var image: Image?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Set up views if editing an existing Image.
        if let image = image {
            navigationItem.title = image.name
            imageNameLabel.text   = image.name
            photoImageView.image = image.photo
            imageTextLabel.text = image.text
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
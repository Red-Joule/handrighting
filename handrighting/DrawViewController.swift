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
    
    
    
    // MARK: Actions
    
    @IBAction func clear(sender: UIButton) {
        let theDrawView : DrawView = drawView as DrawView
        theDrawView.lines = []
        theDrawView.setNeedsDisplay()
    }
    
    @IBAction func saveDrawing(sender: UIButton) {
        UIGraphicsBeginImageContext(self.drawView.frame.size)
        self.drawView.layer.renderInContext(UIGraphicsGetCurrentContext()!)
        let sourceImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        UIImageWriteToSavedPhotosAlbum(sourceImage, nil, nil, nil)
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
    

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }

}

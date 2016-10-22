//
//  Image.swift
//  handrighting
//
//  Created by Eric Mooney on 10/5/16.
//  Copyright © 2016 Red Joule. All rights reserved.
//

import UIKit

class Image {
    // MARK: Properties
    
    var photo: UIImage
    var name: String? //not currently used
    var text: String?
    
    // MARK: Initialization
    
    init?(photo: UIImage, name: String?, text: String?) {
        // Initialize stored properties.
        self.photo = photo
        self.name = name //not currently used
        self.text = text
        
    }
    
}
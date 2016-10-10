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
    
    var name: String
    var photo: UIImage?
    var text: String?
    
    // MARK: Initialization
    
    init?(name: String, photo: UIImage?, text: String?) {
        // Initialize stored properties.
        self.name = name
        self.photo = photo
        self.text = text
        
        // Initialization should fail if there is no name
        if name.isEmpty {
            return nil
        }
    }
    
}
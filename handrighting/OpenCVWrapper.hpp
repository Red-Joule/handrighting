//
//  OpenCVWrapper.h
//  handrighting
//
//  Created by Luke on 10/9/16.
//  Copyright © 2016 Red Joule. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OpenCVWrapper : UITableViewCell

// Define OpenCV Function Wrappers Here

// Get OpenCV Version String
+(NSString *) openCVVersionString;

+(NSString *) trainAndTest: (UIImage *)image;

@end

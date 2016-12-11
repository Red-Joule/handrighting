//
//  OpenCVWrapper.h
//  handrighting
//
//  Created by Luke on 10/9/16.
//  Copyright © 2016 Red Joule. All rights reserved.
//
#import <opencv2/opencv.hpp>
#include<blenders.hpp>
#import <UIKit/UIKit.h>
#import "OpenCVWrapper.hpp"
#import "TrainAndTest.hpp"

@interface OpenCVWrapper : UITableViewCell

// Define OpenCV Function Wrappers Here

// Get OpenCV Version String
+(NSString *) openCVVersionString;

+(NSString *) trainAndTest: (UIImage *)image;

@end
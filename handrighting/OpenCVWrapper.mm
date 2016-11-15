//
//  OpenCVWrapper.m
//  handrighting
//
//  Created by Luke on 10/9/16.
//  Copyright © 2016 Red Joule. All rights reserved.
//

#import "OpenCVWrapper.h"
#import <opencv2/opencv.hpp>

@implementation OpenCVWrapper

+(NSString *) openCVVersionString
{
    return [NSString stringWithFormat:@"OpenCV Version %s", CV_VERSION];
}

+(NSString *) getStringFromImage
{
    
    const char * imageString = "STRING";
    return [NSString stringWithFormat:@"%s", imageString];
}

@end
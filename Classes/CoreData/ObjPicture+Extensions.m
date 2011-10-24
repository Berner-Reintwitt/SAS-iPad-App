//
//  ObjPicture+Extensions.m
//  TabBarWithSplitView
//
//  Created by Berndt Reinhold on 24.10.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "Utils.h"

#import "ObjPicture+Extensions.h"
#import "ScaledImage+Extensions.h"

@implementation ObjPicture (Extensions)

- (UIImage *) GetScaledImage:(int)width withHeight:(int)height withMode:(ScaleModes)mode {
    ScaledImage *original = [self.images anyObject]; // im moment ist nur das eine original vorhanden
    UIImage *img = [original getImage];
    CGImageRef cgref = CreateScaledCGImageFromCGImageWithMode(img.CGImage, width, height, mode);
    UIImage *scaled = [UIImage imageWithCGImage:cgref];
    return scaled;
}

@end

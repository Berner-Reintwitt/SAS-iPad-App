//
//  ScaledImage+Extensions.m
//  TabBarWithSplitView
//
//  Created by Berndt Reinhold on 20.10.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ScaledImage+Extensions.h"
#import "ImageData.h"
@implementation ScaledImage (Extensions)

- (UIImage *) getImage {
	UIImage *result;
	NSData *imageData = self.imageData.data;
	result = [UIImage imageWithData:imageData];
	return result;
}

@end

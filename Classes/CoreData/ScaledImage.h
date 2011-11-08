//
//  ScaledImage.h
//  TabBarWithSplitView
//
//  Created by Berndt Reinhold on 08.11.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class ImageData, ObjPicture;

@interface ScaledImage : NSManagedObject

@property (nonatomic, retain) NSNumber * height;
@property (nonatomic, retain) NSString * mode;
@property (nonatomic, retain) NSNumber * quality;
@property (nonatomic, retain) NSDate * timestamp;
@property (nonatomic, retain) NSNumber * width;
@property (nonatomic, retain) ImageData *imageData;
@property (nonatomic, retain) ObjPicture *parent;

@end

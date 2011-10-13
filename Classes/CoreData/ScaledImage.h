//
//  ScaledImage.h
//  xmlLoad
//
//  Created by Berndt Reinhold on 12.10.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class ObjPicture;

@interface ScaledImage : NSManagedObject

@property (nonatomic, retain) NSNumber * width;
@property (nonatomic, retain) NSNumber * height;
@property (nonatomic, retain) NSNumber * quality;
@property (nonatomic, retain) NSString * mode;
@property (nonatomic, retain) NSDate * timestamp;
@property (nonatomic, retain) NSData * data;
@property (nonatomic, retain) ObjPicture *parent;

@end

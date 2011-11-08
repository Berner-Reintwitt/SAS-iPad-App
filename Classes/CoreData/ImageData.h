//
//  ImageData.h
//  TabBarWithSplitView
//
//  Created by Berndt Reinhold on 08.11.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class ScaledImage;

@interface ImageData : NSManagedObject

@property (nonatomic, retain) NSData * data;
@property (nonatomic, retain) ScaledImage *parent;

@end

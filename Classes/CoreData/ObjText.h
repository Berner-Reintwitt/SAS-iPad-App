//
//  ObjText.h
//  TabBarWithSplitView
//
//  Created by Berndt Reinhold on 08.11.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class ObjInfo2;

@interface ObjText : NSManagedObject

@property (nonatomic, retain) NSString * key;
@property (nonatomic, retain) NSData * md5hash;
@property (nonatomic, retain) NSString * text;
@property (nonatomic, retain) NSDate * timestamp;
@property (nonatomic, retain) ObjInfo2 *parent;

@end

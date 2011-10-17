//
//  ObjAttribute.h
//  TabBarWithSplitView
//
//  Created by Berndt Reinhold on 17.10.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class ObjInfo2;

@interface ObjAttribute : NSManagedObject

@property (nonatomic, retain) NSNumber * id_;
@property (nonatomic, retain) NSString * label;
@property (nonatomic, retain) NSString * value;
@property (nonatomic, retain) ObjInfo2 *parent;

@end

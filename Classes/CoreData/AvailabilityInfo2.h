//
//  AvailabilityInfo2.h
//  TabBarWithSplitView
//
//  Created by Berndt Reinhold on 08.11.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class ObjInfo2;

@interface AvailabilityInfo2 : NSManagedObject

@property (nonatomic, retain) NSString * bookingWeekStart;
@property (nonatomic, retain) NSString * dayAvailabilty;
@property (nonatomic, retain) NSData * md5hash;
@property (nonatomic, retain) NSDate * startDate;
@property (nonatomic, retain) NSDate * timestamp;
@property (nonatomic, retain) ObjInfo2 *parent;

@end

//
//  AvailabilityInfo2.h
//  xmlLoad
//
//  Created by Berndt Reinhold on 12.10.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class ObjInfo2;

@interface AvailabilityInfo2 : NSManagedObject

@property (nonatomic, retain) NSString * bookingWeekStart;
@property (nonatomic, retain) NSString * dayAvailability;
@property (nonatomic, retain) NSDate * startDate;
@property (nonatomic, retain) NSDate * timestamp;
@property (nonatomic, retain) ObjInfo2 *parent;

@end

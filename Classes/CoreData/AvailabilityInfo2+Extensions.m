//
//  AvailabilityInfo2+Extensions.m
//  TabBarWithSplitView
//
//  Created by Berndt Reinhold on 10.11.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "AvailabilityInfo2+Extensions.h"
#import "StringConsts.h"
#import "Utils.h"
#import "AbstractParser.h"

@implementation AvailabilityInfo2 (Extensions)

+ (AvailabilityInfo2 *) parseFromXmlNodes:(NSArray *)nodes withContext:(NSManagedObjectContext *)context {
    AvailabilityInfo2 *result = nil;
    NSString *objectID = nil, *BookingWeekStart = nil, *DayAvailability = nil, *startDate = nil, *timestamp = nil, *md5 = nil;
    for (NSDictionary *d in nodes) {
        NSString *nodeName = [d objectForKey:XML_NodeName];
        NSString *nodeContent = [d objectForKey:XML_NodeContent];
        if ([nodeName compare:NAME_objectID] == NSOrderedSame) objectID = nodeContent;
        else if ([nodeName compare:NAME_BookingWeekStart] == NSOrderedSame) BookingWeekStart = nodeContent;
        else if ([nodeName compare:NAME_DayAvailability] == NSOrderedSame) DayAvailability = nodeContent;
        else if ([nodeName compare:NAME_startDate] == NSOrderedSame) startDate = nodeContent;
        else if ([nodeName compare:NAME_timestamp] == NSOrderedSame) timestamp = nodeContent;
        else if ([nodeName compare:Name_md5] == NSOrderedSame) md5 = nodeContent;
        else NSLog(@"unknown tag %s", [nodeContent UTF8String]);
    }
    if (!(nil != objectID && nil != BookingWeekStart && nil != DayAvailability && nil != startDate && nil != timestamp && nil != md5)) {
        NSLog(@"Availability update: missing tag");
        return nil;
    }
    result = [NSEntityDescription insertNewObjectForEntityForName:CLASS_AvailabilityInfo2 inManagedObjectContext:context];
    result.bookingWeekStart = BookingWeekStart;
    result.timestamp = [AbstractParser parseDate:timestamp];
    result.startDate = [AbstractParser parseDate:startDate];
    result.dayAvailabilty = DayAvailability;
    result.md5hash = DecodeAP16(md5);
    return result;
}

@end

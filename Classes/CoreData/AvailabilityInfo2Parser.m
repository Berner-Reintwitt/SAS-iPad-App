//
//  AvailabilityInfo2Parser.m
//  xmlLoad
//
//  Created by Berndt Reinhold on 10.10.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "AvailabilityInfo2Parser.h"
#import "AvailabilityInfo2.h"
#import "ObjInfo2.h"
#import "StringConsts.h"
#import "Queries.h"

@implementation AvailabilityInfo2Parser

- (void) closeTag:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName parentName:(NSString *)pName myDict:(NSMutableDictionary *) mDict parentDict:(NSMutableDictionary *) pDict {

    if ([CLASS_AvailabilityInfo2 compare:elementName] == NSOrderedSame) {
        AvailabilityInfo2 *aInfo = [NSEntityDescription insertNewObjectForEntityForName:CLASS_AvailabilityInfo2 inManagedObjectContext:context];
        NSDate *timestamp = [AbstractParser parseDate:[mDict objectForKey:NAME_timestamp]];
        aInfo.timestamp = timestamp;
		NSString *startDate_str = [mDict objectForKey:NAME_startDate];
        NSDate *startDate = [AbstractParser parseDate:startDate_str];
        aInfo.startDate = startDate;
        NSString *bookingWeekStart = [mDict objectForKey:NAME_BookingWeekStart];
        aInfo.bookingWeekStart = bookingWeekStart;
        NSString *dayAvailability = [mDict objectForKey:NAME_DayAvailability];
        aInfo.dayAvailabilty = dayAvailability;
		NSMutableData *md5hash = [AbstractParser parseBase16:[mDict objectForKey:Name_md5]];
		aInfo.md5hash = md5hash;
        NSString *exid = [mDict objectForKey:NAME_objectID];
        ObjInfo2 *a = [Queries getApartment:context	withExID:exid];
        if (nil != a) {
            [a addAvailabilityInfoObject:aInfo];
        } else {
            NSLog(@"AvailabilityInfo2Parser: missing exid: %s", [exid UTF8String]);
        }
    }
    
}

@end

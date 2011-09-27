//
//  Apartment.h
//  SAS-iPad-App
//
//  Created by Oliver  Neveling on 26.09.11.
//  Copyright (c) 2011 neveling.net GmbH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Apartment : NSManagedObject

@property (nonatomic, retain) NSString * exid;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * rooms;
@property (nonatomic, retain) NSNumber * bed_rooms;
@property (nonatomic, retain) NSNumber * living_area;
@property (nonatomic, retain) NSNumber * persons;
@property (nonatomic, retain) NSNumber * max_persons;
@property (nonatomic, retain) NSString * zip_code;
@property (nonatomic, retain) NSString * city;
@property (nonatomic, retain) NSString * street;
@property (nonatomic, retain) NSNumber * groupID;
@property (nonatomic, retain) NSNumber * wohnlageID;
@property (nonatomic, retain) NSDecimalNumber * longitude;
@property (nonatomic, retain) NSDecimalNumber * latitude;
@property (nonatomic, retain) NSString * attributes;

@end

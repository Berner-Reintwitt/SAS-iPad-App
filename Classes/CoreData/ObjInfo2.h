//
//  ObjInfo2.h
//  TabBarWithSplitView
//
//  Created by Berndt Reinhold on 17.10.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class AvailabilityInfo2, ObjAttribute, ObjPicture, ObjPriceInfo, ObjText;

@interface ObjInfo2 : NSManagedObject

@property (nonatomic, retain) NSNumber * alergic;
@property (nonatomic, retain) NSNumber * animals;
@property (nonatomic, retain) NSNumber * anlageID;
@property (nonatomic, retain) NSNumber * bed_rooms;
@property (nonatomic, retain) NSString * city;
@property (nonatomic, retain) NSNumber * cityID;
@property (nonatomic, retain) NSNumber * erbaut;
@property (nonatomic, retain) NSString * etage;
@property (nonatomic, retain) NSString * exid;
@property (nonatomic, retain) NSNumber * flags;
@property (nonatomic, retain) NSDate * fromDate;
@property (nonatomic, retain) NSDecimalNumber * googlemaps_latitude;
@property (nonatomic, retain) NSDecimalNumber * googlemaps_longitude;
@property (nonatomic, retain) NSString * group;
@property (nonatomic, retain) NSNumber * groupID;
@property (nonatomic, retain) NSNumber * houseID;
@property (nonatomic, retain) NSNumber * id_;
@property (nonatomic, retain) NSNumber * lageID;
@property (nonatomic, retain) NSString * land;
@property (nonatomic, retain) NSNumber * living_area;
@property (nonatomic, retain) NSNumber * max_persons;
@property (nonatomic, retain) NSNumber * mindays;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * objnr;
@property (nonatomic, retain) NSNumber * ortslageID;
@property (nonatomic, retain) NSNumber * persons;
@property (nonatomic, retain) NSNumber * quality;
@property (nonatomic, retain) NSString * region;
@property (nonatomic, retain) NSNumber * regionID;
@property (nonatomic, retain) NSNumber * renoviert;
@property (nonatomic, retain) NSNumber * rooms;
@property (nonatomic, retain) NSNumber * smoking;
@property (nonatomic, retain) NSString * street;
@property (nonatomic, retain) NSDate * timestamp;
@property (nonatomic, retain) NSDate * toDate;
@property (nonatomic, retain) NSNumber * typID;
@property (nonatomic, retain) NSNumber * wohnlageID;
@property (nonatomic, retain) NSNumber * zipcode;
@property (nonatomic, retain) NSSet *attributes;
@property (nonatomic, retain) NSSet *availabilityInfo;
@property (nonatomic, retain) NSSet *pictures;
@property (nonatomic, retain) NSSet *priceInfo;
@property (nonatomic, retain) NSSet *texts;
@end

@interface ObjInfo2 (CoreDataGeneratedAccessors)

- (void)addAttributesObject:(ObjAttribute *)value;
- (void)removeAttributesObject:(ObjAttribute *)value;
- (void)addAttributes:(NSSet *)values;
- (void)removeAttributes:(NSSet *)values;

- (void)addAvailabilityInfoObject:(AvailabilityInfo2 *)value;
- (void)removeAvailabilityInfoObject:(AvailabilityInfo2 *)value;
- (void)addAvailabilityInfo:(NSSet *)values;
- (void)removeAvailabilityInfo:(NSSet *)values;

- (void)addPicturesObject:(ObjPicture *)value;
- (void)removePicturesObject:(ObjPicture *)value;
- (void)addPictures:(NSSet *)values;
- (void)removePictures:(NSSet *)values;

- (void)addPriceInfoObject:(ObjPriceInfo *)value;
- (void)removePriceInfoObject:(ObjPriceInfo *)value;
- (void)addPriceInfo:(NSSet *)values;
- (void)removePriceInfo:(NSSet *)values;

- (void)addTextsObject:(ObjText *)value;
- (void)removeTextsObject:(ObjText *)value;
- (void)addTexts:(NSSet *)values;
- (void)removeTexts:(NSSet *)values;

@end

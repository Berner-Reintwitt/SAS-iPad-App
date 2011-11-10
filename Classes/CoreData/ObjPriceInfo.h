//
//  ObjPriceInfo.h
//  TabBarWithSplitView
//
//  Created by Berndt Reinhold on 08.11.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class ObjInfo2, Price;

@interface ObjPriceInfo : NSManagedObject

@property (nonatomic, retain) NSData * md5hash;
@property (nonatomic, retain) NSNumber * perPers;
@property (nonatomic, retain) NSNumber * prli;
@property (nonatomic, retain) NSDate * timestamp;
@property (nonatomic, retain) NSString * typ;
@property (nonatomic, retain) ObjInfo2 *parent;
@property (nonatomic, retain) NSSet *prices;
@end

@interface ObjPriceInfo (CoreDataGeneratedAccessors)

- (void)addPricesObject:(Price *)value;
- (void)removePricesObject:(Price *)value;
- (void)addPrices:(NSSet *)values;
- (void)removePrices:(NSSet *)values;

@end

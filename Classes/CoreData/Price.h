//
//  Price.h
//  xmlLoad
//
//  Created by Berndt Reinhold on 12.10.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class ObjPriceInfo;

@interface Price : NSManagedObject

@property (nonatomic, retain) NSDate * dateFrom;
@property (nonatomic, retain) NSDate * dateTo;
@property (nonatomic, retain) NSNumber * price;
@property (nonatomic, retain) NSString * styp;
@property (nonatomic, retain) NSString * typ;
@property (nonatomic, retain) ObjPriceInfo *parent;

@end

//
//  ObjInfo2+ObjInfo2Extensions.m
//  TabBarWithSplitView
//
//  Created by Berndt Reinhold on 20.10.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//


#import "AvailabilityInfo2.h"
#import "ObjAttribute.h"
#import "ObjInfo2+Extensions.h"
#import "ObjPicture+Extensions.h"
#import "ObjPriceInfo+Extensions.h"
#import "Price.h"
#import "ObjText.h"
#import "Utils.h"
#import "StringConsts.h"


static NSInteger picSort(id pic1, id pic2, void *context) {
    int v1 = [((ObjPicture *) pic1).serial intValue];
    int v2 = [((ObjPicture *) pic2).serial intValue];
    return v1 < v2 ? NSOrderedAscending : v1 > v2 ? NSOrderedDescending : NSOrderedSame;
}

static NSPredicate *maxPersons(int actPersons) {
    NSExpression *leftSide = [NSExpression expressionForKeyPath: NAME_max_persons];
    NSExpression *rightSide = [NSExpression expressionForConstantValue: [NSNumber numberWithInt: actPersons]];
    NSPredicate *result = [NSComparisonPredicate
                          predicateWithLeftExpression: leftSide
                          rightExpression: rightSide
                          modifier: NSDirectPredicateModifier
                          type: NSGreaterThanOrEqualToPredicateOperatorType
                          options: 0];
    return result;
}

//static NSPredicate *exid(

@implementation ObjInfo2 (Extensions)

- (NSArray *) OrderedPictures {
    NSArray *unordered = self.pictures.allObjects;
    NSArray *ordered = [unordered sortedArrayUsingFunction:picSort context:NULL];   
    return ordered;
}

- (NSMutableData *) deepMd5Hash {
    NSMutableData *result = [NSMutableData dataWithData: self.md5hash];
    for (AvailabilityInfo2 *a in self.availabilityInfo) XorMd5Hash(result, a.md5hash);
    for (ObjAttribute *a in self.attributes) XorMd5Hash(result, a.md5hash);
    for (ObjPicture *p in self.pictures) XorMd5Hash(result, p.md5hash);
    for (ObjPriceInfo *p in self.priceInfo) XorMd5Hash(result, [p deepMd5Hash]);
    for (ObjText *t in self.texts) XorMd5Hash(result, t.md5hash);
    return result;
}

+ (NSArray *) AllApartments {
    NSManagedObjectContext *context = managedObjectContext();
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:CLASS_ObjInfo2 inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
	[fetchRequest setPredicate:nil];
    NSError *error = nil;
    NSArray *result = [context executeFetchRequest:fetchRequest error:&error];
    [fetchRequest release];
    return result;
}

+ (NSArray *) LocalSearch:(SearchParameters *)sparam {
    
    NSArray *all = [ObjInfo2 AllApartments];

    
    
    NSPredicate *persons = maxPersons(sparam.adults + sparam.children);
    
    NSArray *result = [all filteredArrayUsingPredicate: persons];
    
    return result;
    
}

- (double) FinalCleaningPrice {
    for (ObjPriceInfo *pi in self.priceInfo) {
        for (Price *p in pi.prices) {
            if ([@"ER" compare:p.typ] == NSOrderedSame) {
                return [p.price doubleValue];
            }
        }
    }
    return 0;
}

- (double) LowestPricePerWeek {
    
    double fc = [self FinalCleaningPrice];
    if (0 == fc) return 0;

    NSNumber *lowest;
    
    for (ObjPriceInfo *pi in self.priceInfo) {
        for (Price *p in pi.prices) {
            if ([@"TP" compare:p.typ] == NSOrderedSame && (nil == lowest || [lowest compare:p.price] == NSOrderedDescending)) {
                lowest = p.price;
            }
        }
    }
    
    if (nil == lowest) return 0;
    double result = [lowest doubleValue] * 7 + fc + 19.0;
    return result;
}

@end

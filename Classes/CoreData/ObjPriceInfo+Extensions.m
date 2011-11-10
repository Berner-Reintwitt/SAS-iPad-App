//
//  ObjPriceInfo+Extensions.m
//  TabBarWithSplitView
//
//  Created by Berndt Reinhold on 01.11.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ObjPriceInfo+Extensions.h"
#import "Price+Extensions.h"
#import "Utils.h"
#import "StringConsts.h"
#import "Queries.h"
#import "AbstractParser.h"


@implementation ObjPriceInfo (Extensions)

- (NSMutableData *) deepMd5Hash {
    NSMutableData *result = [NSMutableData dataWithData: self.md5hash];
    for (Price *p in self.prices) {
        XorMd5Hash(result, p.md5hash);
    }
    return result;
}

+ (ObjPriceInfo *) parseFromXmlNodes:(NSArray *)nodes withContext:(NSManagedObjectContext *)context {
    ObjPriceInfo *result = nil;
    ObjInfo2 *parent = nil;
    NSString *exid, *perPers, *prli, *timestamp, *typ;
    NSMutableSet *prices = nil;
    exid = perPers = prli = timestamp = typ = nil;
    
    NSString *nodeName, *nodeContent;
    NSArray *nodeChildArray;
    
    for (NSDictionary *d in nodes) {
        nodeName = [d objectForKey:XML_NodeName];
        nodeContent = [d objectForKey:XML_NodeContent];
        if ([nodeName compare:NAME_exid] == NSOrderedSame) exid = nodeContent;
        else if ([nodeName compare:NAME_perPers] == NSOrderedSame) perPers = nodeContent;
        else if ([nodeName compare:NAME_prli] == NSOrderedSame) prli = nodeContent;
        else if ([nodeName compare:NAME_timestamp] == NSOrderedSame) timestamp = nodeContent;
        else if ([nodeName compare:NAME_typ] == NSOrderedSame) typ = nodeContent;
        else if ([nodeName compare:NAME_prices] == NSOrderedSame) {
            NSArray *p = [d objectForKey:XML_NodeChildNodes];
            prices = [NSMutableSet setWithCapacity:8];
            for (NSDictionary *e in p) {
                NSArray *q = [e objectForKey:XML_NodeChildNodes];
                Price *pr = [Price parseFromXmlNodes:q withContext:context];
                [prices addObject:pr];
            }
        }
    }
    
    if (nil != exid && nil != perPers && nil != prli && nil != timestamp && nil != typ) {
        parent = [Queries getApartment:context withExID:exid];
        if (nil == parent) {
            NSLog(@"priceinfo for unknown object %s", [exid UTF8String]);
            return nil;
        }
        result = [NSEntityDescription insertNewObjectForEntityForName:CLASS_ObjPriceInfo inManagedObjectContext:context];
        result.prli = [AbstractParser parseInt:prli];
        result.perPers = [AbstractParser parseBoolean:perPers];
        result.timestamp = [AbstractParser parseDate:timestamp];
        result.parent = parent;
        result.typ = typ;
        [result addPrices:prices];
    }
    
    return result;
}


@end

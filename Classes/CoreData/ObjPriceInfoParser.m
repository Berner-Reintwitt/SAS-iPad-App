//
//  ObjPriceInfoParser.m
//  xmlLoad
//
//  Created by Berndt Reinhold on 07.10.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ObjPriceInfoParser.h"
#import "ObjInfo2.h"
#import "ObjPriceInfo.h"
#import "Price.h"
#import "StringConsts.h"
#import "Queries.h"

@implementation ObjPriceInfoParser


- (void) closeTag:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName parentName:(NSString *)pName myDict:(NSMutableDictionary *) mDict parentDict:(NSMutableDictionary *) pDict {
    
    if ([CLASS_Price compare:elementName] == NSOrderedSame) {
        Price *price = [NSEntityDescription insertNewObjectForEntityForName:CLASS_Price inManagedObjectContext:context];
            if (nil != price) {
                price.dateFrom = [AbstractParser parseDate:[mDict objectForKey:NAME_dateFrom]];
                price.dateTo = [AbstractParser parseDate:[mDict objectForKey:NAME_dateTo]];
                price.styp = [mDict objectForKey:NAME_styp];
                price.typ = [mDict objectForKey:NAME_typ];
                price.price = [AbstractParser parseFloat:[mDict objectForKey:NAME_price]];
                NSMutableSet *prices = [pDict objectForKey:SET_Price];
                if (nil == prices) {
                    prices = [NSMutableSet setWithCapacity:20];
                    [pDict setObject:prices forKey:SET_Price];
                }
                [prices addObject:price];
        }
       
    } else if ([CLASS_ObjPriceInfo compare:elementName] == NSOrderedSame) {
        ObjPriceInfo *pInfo = [NSEntityDescription insertNewObjectForEntityForName:CLASS_ObjPriceInfo inManagedObjectContext:context];
        if (nil != pInfo) {
            pInfo.typ = [mDict objectForKey:NAME_prli];
            pInfo.timestamp = [AbstractParser parseDate:[mDict objectForKey:NAME_timestamp]];
            pInfo.prli = [AbstractParser parseInt: [mDict objectForKey:NAME_prli]];
            pInfo.prices = [mDict objectForKey:SET_Price];
            NSString *exid = [mDict objectForKey:NAME_exid];
            
            ObjInfo2 *a = [Queries getApartment:context	withExID:exid];
            if (nil != a) {
                [a addPriceInfoObject:pInfo];            
            }
        }
    }
    
}




@end

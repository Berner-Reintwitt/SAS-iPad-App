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
    
    if ([CLASS_Price compare:elementName] == NSOrderedSame) { // </Price>
        Price *price = [NSEntityDescription insertNewObjectForEntityForName:CLASS_Price inManagedObjectContext:context];
		if (nil == price) {
			NSLog(@"<Price>: can't create ManagedObject");
			return;
		}
		price.dateFrom = [AbstractParser parseDate:[mDict objectForKey:NAME_dateFrom]];
		price.dateTo = [AbstractParser parseDate:[mDict objectForKey:NAME_dateTo]];
		price.styp = [mDict objectForKey:NAME_styp];
		price.typ = [mDict objectForKey:NAME_typ];
		price.price = [AbstractParser parseFloat:[mDict objectForKey:NAME_price]];
		price.md5hash = [AbstractParser parseBase16:[mDict objectForKey:Name_md5]];
		NSMutableSet *prices = [pDict objectForKey:SET_Price];
		if (nil == prices) {
			prices = [NSMutableSet setWithCapacity:20];
			[pDict setObject:prices forKey:SET_Price];
		}
		[prices addObject:price];
    } else if ([NAME_prices compare:elementName] == NSOrderedSame) { // </prices>
		NSSet *prices = [mDict objectForKey:SET_Price];
		if (nil == prices) {
			NSLog(@"prices: no Prices");
			return;
		}
		[pDict setObject:prices forKey:SET_Price]; // pass to parent
    } else if ([CLASS_ObjPriceInfo compare:elementName] == NSOrderedSame) { // </PriceInfo>
		NSString *exid = [mDict objectForKey:NAME_exid];
		ObjInfo2 *a = [Queries getApartment:context	withExID:exid];
		if (nil == a) {
			NSLog(@"PriceInfo: unknown exid(%s)", [exid UTF8String]);
			return;
		}
		NSSet *prices = [mDict objectForKey:SET_Price];
		if (nil == prices) {
			NSLog(@"PriceInfo: no prices");
			return;
		}
        ObjPriceInfo *pInfo = [NSEntityDescription insertNewObjectForEntityForName:CLASS_ObjPriceInfo inManagedObjectContext:context];
        if (nil == pInfo) {
			NSLog(@"PriceInfo: can't create ManagedObject");
			return;
        }
		if (nil == (pInfo.typ = [mDict objectForKey:NAME_typ])) NSLog(@"PriceInfo: no typ");
		if (nil == (pInfo.timestamp = [AbstractParser parseDate:[mDict objectForKey:NAME_timestamp]])) NSLog(@"PriceInfo: no timestamp");
		if (nil == (pInfo.prli = [AbstractParser parseInt: [mDict objectForKey:NAME_prli]])) NSLog(@"PriceInfo: no prli");
		if (nil == (pInfo.perPers = [AbstractParser parseBoolean:[mDict objectForKey:NAME_perPers]])) NSLog(@"PriceInfo: no perPers");
		if (nil == (pInfo.md5hash = [AbstractParser parseBase16:[mDict objectForKey:Name_md5]])) NSLog(@"PriceInfo: no md5");
		[pInfo addPrices:prices];
		[a addPriceInfoObject:pInfo];            
    }
}




@end

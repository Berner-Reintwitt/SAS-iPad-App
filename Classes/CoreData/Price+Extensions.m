//
//  Price+Extensions.m
//  TabBarWithSplitView
//
//  Created by Berndt Reinhold on 10.11.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "Price+Extensions.h"
#import "StringConsts.h"
#import "AbstractParser.h"
#import "Utils.h"

@implementation Price (Extensions)

+ (Price *) parseFromXmlNodes:(NSArray *)nodes withContext:(NSManagedObjectContext *)context {
    Price *result = nil;
    NSString *dateFrom = nil, *dateTo = nil, *price = nil, *styp = nil, *typ = nil, *md5 = nil;
    for (NSDictionary *d in nodes) {
        NSString *nodeName = [d objectForKey:XML_NodeName];
        NSString *nodeContent = [d objectForKey:XML_NodeContent];
        if ([nodeName compare:NAME_dateFrom] == NSOrderedSame) dateFrom = nodeContent;
        else if ([nodeName compare:NAME_dateTo] == NSOrderedSame) dateTo = nodeContent;
        else if ([nodeName compare:NAME_price] == NSOrderedSame) price = nodeContent;
        else if ([nodeName compare:NAME_styp] == NSOrderedSame) styp = nodeContent;
        else if ([nodeName compare:NAME_typ] == NSOrderedSame) typ = nodeContent;
        else if ([nodeName compare:Name_md5] == NSOrderedSame) md5 = nodeContent;
        else NSLog(@"unknown tag %s", [nodeContent UTF8String]);
    }
    if (nil != dateFrom && nil != dateTo && nil != price && nil != styp && nil != typ && nil != md5) {
        result = [NSEntityDescription insertNewObjectForEntityForName:CLASS_Price inManagedObjectContext:context];
        result.dateFrom = [AbstractParser parseDate:dateFrom];
        result.dateTo = [AbstractParser parseDate:dateTo];
        result.price = [AbstractParser parseFloat:price];
        result.styp = styp;
        result.typ = typ;
        result.md5hash = DecodeAP16(md5);
    }
    return result;
}

@end

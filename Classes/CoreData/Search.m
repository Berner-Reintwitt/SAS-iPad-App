//
//  Search.m
//  TabBarWithSplitView
//
//  Created by Berndt Reinhold on 25.10.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "Search.h"
#import "ObjInfo2+Extensions.h"
#import "SearchResult.h"
#import "Utils.h"
#import "XPathQuery.h"
#import "StringConsts.h"
#import "AbstractParser.h"

@implementation Search

+ (NSArray *) SearchWithParameters:(SearchParameters *)spar {
    NSMutableArray *paramValues = [NSMutableArray arrayWithCapacity:8];
    [paramValues addObject:PARAM_SEARCH_FROMDATE];
    [paramValues addObject:dateToYYYYMMDD(spar.dateFrom)];
    [paramValues addObject:PARAM_SEARCH_TODATE];
    [paramValues addObject:dateToYYYYMMDD(spar.dateTo)];
    [paramValues addObject:PARAM_SEARCH_ADULTS];
    [paramValues addObject:[NSString stringWithFormat:@"%d", spar.adults]];
    if (spar.children > 0) {
        [paramValues addObject:PARAM_SEARCH_CHILDREN];
        [paramValues addObject:[NSString stringWithFormat:@"%d", spar.children]];
    }
    if (spar.rangeFrom > 0) {
        [paramValues addObject:PARAM_SEARCH_RANGEFROM];
        [paramValues addObject:[NSString stringWithFormat:@"%d", spar.rangeFrom]];
    }
    if (spar.rooms > 0) {
        [paramValues addObject:PARAM_SEARCH_ROOMS];
        [paramValues addObject:[NSString stringWithFormat:@"%d", spar.rooms]];
    }
    
    NSMutableArray *result = [NSMutableArray arrayWithCapacity:initApartmentCapacity];
    NSData *rawXML = readDataWithQueryArray(URL_SEARCH, paramValues);
    NSArray *root = PerformXMLXPathQuery(rawXML, @"/ArrayOfObjInfo/ObjInfo");
    for (NSDictionary *d in root) {
        NSArray *values = [d objectForKey:XML_NodeChildNodes];
        NSAssert(nil != values, @"Search");
        SearchResult *sres = [[SearchResult alloc] init];
        for (NSDictionary *e in values) {
            NSString *nodeName = [e objectForKey:XML_NodeName];
            NSString *nodeContent = [e objectForKey:XML_NodeContent];
            if ([nodeName compare:NAME_exid] == NSOrderedSame) sres.exid = nodeContent;
            else if ([nodeName compare:NAME_objnr] == NSOrderedSame) sres.objnr = nodeContent;
            else if ([nodeName compare:NAME_name] == NSOrderedSame) sres.name = nodeContent;
            else if ([nodeName compare:NAME_fromDate] == NSOrderedSame) sres.fromDate = [AbstractParser parseDate:nodeContent];
            else if ([nodeName compare:NAME_toDate] == NSOrderedSame) sres.toDate = [AbstractParser parseDate:nodeContent];
            else if ([nodeName compare:NAME_rooms] == NSOrderedSame) sres.rooms = parseInt(nodeContent);
            else if ([nodeName compare:NAME_bed_rooms] == NSOrderedSame) sres.bed_rooms = parseInt(nodeContent);
            else if ([nodeName compare:NAME_living_area] == NSOrderedSame) sres.living_area = parseDouble(nodeContent);
            else if ([nodeName compare:NAME_persons] == NSOrderedSame) sres.persons = parseInt(nodeContent);
            else if ([nodeName compare:NAME_max_persons] == NSOrderedSame) sres.max_persons = parseInt(nodeContent);
            else if ([nodeName compare:NAME_mindays] == NSOrderedSame) sres.mindays = parseInt(nodeContent);
            else if ([nodeName compare:NAME_kurzbucher] == NSOrderedSame) sres.kurzbucher = parseInt(nodeContent);
            else if ([nodeName compare:NAME_nights] == NSOrderedSame) sres.nights = parseInt(nodeContent);
        }
        // sanity check
        sres.spar = spar;
        [result addObject:sres];
    }
    return result;
}

@end

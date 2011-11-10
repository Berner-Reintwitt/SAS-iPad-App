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

@implementation Search

+ (NSEnumerator *) SearchWithParameters:(SearchParameters *)spar {

    NSData *rawXml = readData(@"http://feder-mirror.local/Search.ashx", @"search", @"f", @"20120101", @"t", @"20120108", @"a", @"2", nil);
    NSArray *result = PerformXMLXPathQuery(rawXml, @"/ArrayOfObjInfo/ObjInfo");
    
    
    
    
    
}

@end

//
//  SearchResult.m
//  TabBarWithSplitView
//
//  Created by Berndt Reinhold on 25.10.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "SearchResult.h"
#import "AbstractParser.h"
#import "Utils.h"
#import "StringConsts.h"
#import "XPathQuery.h"
#import "Search.h"

@implementation SearchResult

@synthesize exid, objnr, name, fromDate, toDate, rooms, bed_rooms, living_area, persons, max_persons, mindays, kurzbucher, nights, spar;
  

+ (NSArray *) Search: (SearchParameters *) spar {
    return [Search SearchWithParameters:spar];
}


+ (NSArray *) mySearchresults {
    return [Search SearchWithParameters:nil]; 
}


+ (NSArray *) mySearchresults: (SearchParameters *) sp {
    return [Search SearchWithParameters:sp];
/*
    SearchParameters *spar =[[SearchParameters alloc]init];
    spar.children=2;
    spar.adults=2;
    spar.dateTo=[AbstractParser parseDate:@"2012-01-14T00:00:00"];
    spar.dateFrom=[AbstractParser parseDate:@"2012-01-07T00:00:00"];
    NSMutableArray *array=[NSMutableArray arrayWithCapacity:30];
    SearchResult *sr=[[SearchResult alloc]init];
    sr.spar=spar;
    sr.dateFrom=[AbstractParser parseDate:@"2012-01-07T00:00:00"];
    sr.dateTo=[AbstractParser parseDate:@"2012-01-14T00:00:00"];
    sr.price=1380;
    sr.hitrate=1;
    sr.exid=@"1/02";
    [array addObject:sr];
    sr=[[SearchResult alloc]init];
    sr.spar=spar;
    sr.dateFrom=[AbstractParser parseDate:@"2012-01-07T00:00:00"];
    sr.dateTo=[AbstractParser parseDate:@"2012-01-14T00:00:00"];
    sr.price=1380;
    sr.hitrate=1;
    sr.exid=@"37/01";
    [array addObject:sr];
    sr=[[SearchResult alloc]init];
    sr.spar=spar;
    sr.dateFrom=[AbstractParser parseDate:@"2012-01-07T00:00:00"];
    sr.dateTo=[AbstractParser parseDate:@"2012-01-14T00:00:00"];
    sr.price=1380;
    sr.hitrate=1;
    sr.exid=@"50/05";
    [array addObject:sr];
    sr=[[SearchResult alloc]init];
    sr.spar=spar;
    sr.dateFrom=[AbstractParser parseDate:@"2012-01-07T00:00:00"];
    sr.dateTo=[AbstractParser parseDate:@"2012-01-14T00:00:00"];
    sr.price=1380;
    sr.hitrate=1;
    sr.exid=@"3/05";
    [array addObject:sr];
    sr=[[SearchResult alloc]init];
    sr.spar=spar;
    sr.dateFrom=[AbstractParser parseDate:@"2012-01-07T00:00:00"];
    sr.dateTo=[AbstractParser parseDate:@"2012-01-14T00:00:00"];
    sr.price=1380;
    sr.hitrate=1;
    sr.exid=@"6/06";
    [array addObject:sr];
    sr=[[SearchResult alloc]init];
    sr.spar=spar;
    sr.dateFrom=[AbstractParser parseDate:@"2012-01-07T00:00:00"];
    sr.dateTo=[AbstractParser parseDate:@"2012-01-14T00:00:00"];
    sr.price=1380;
    sr.hitrate=1;
    sr.exid=@"29/21";
    [array addObject:sr];
    sr=[[SearchResult alloc]init];
    sr.spar=spar;
    sr.dateFrom=[AbstractParser parseDate:@"2012-01-07T00:00:00"];
    sr.dateTo=[AbstractParser parseDate:@"2012-01-14T00:00:00"];
    sr.price=1380;
    sr.hitrate=1;
    sr.exid=@"50/39B";
    [array addObject:sr];
    sr=[[SearchResult alloc]init];
    sr.spar=spar;
    sr.dateFrom=[AbstractParser parseDate:@"2012-01-07T00:00:00"];
    sr.dateTo=[AbstractParser parseDate:@"2012-01-14T00:00:00"];
    sr.price=1380;
    sr.hitrate=1;
    sr.exid=@"8/02";
    [array addObject:sr];
    sr=[[SearchResult alloc]init];
    sr.spar=spar;
    sr.dateFrom=[AbstractParser parseDate:@"2012-01-07T00:00:00"];
    sr.dateTo=[AbstractParser parseDate:@"2012-01-14T00:00:00"];
    sr.price=1380;
    sr.hitrate=1;
    sr.exid=@"35/10";
    [array addObject:sr];
    
    return array;
*/
}


- (double) hitrate {
    return 1;
}


- (double) price {
    return 1350;
}


@end

//
//  SearchParameters.m
//  TabBarWithSplitView
//
//  Created by Johannes Böhler on 21.10.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "SearchParameters.h"

@implementation SearchParameters

{
    
    
    
}

+ (SearchParameters *) globalSearchParameters{
    
    static SearchParameters * __spar;
    if (nil==__spar){
        __spar= [[SearchParameters alloc]init];
    }
    
    return __spar;
    
}

@synthesize exIDs,city,rooms,adults,dateTo,groupID,maxCost,maxSize,minSize,rangeTo,children,dateFrom,merkmale,rangeFrom,dateToFest,minHitRate,wohnlageID,datefromfest,minQualitaet,AlternativeSearch;

@end

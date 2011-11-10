//
//  SearchParameters.h
//  TabBarWithSplitView
//
//  Created by Johannes Böhler on 21.10.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SearchParameters : NSObject {
    NSSet *exIDs;
    NSSet *merkmale;
    NSDate *dateFrom;
    NSDate *dateTo;
    NSString *city;
    NSDecimal *minQualitaet;
    NSDecimal *maxCost;
    NSDecimal *minSize;
    NSDecimal *maxSize;
    BOOL   datefromfest;
    BOOL   dateToFest;
    int    rangeFrom;
    int    rangeTo;
    int    adults;
    int    children;
    int    rooms;
    int     groupID;
    int     wohnlageID;
    BOOL    AlternativeSearch;
    double  minHitRate;
}

@property (nonatomic,retain) NSSet *exIDs;
@property (nonatomic,retain) NSSet *merkmale;
@property (nonatomic,retain) NSDate *dateFrom;;
@property (nonatomic,retain) NSDate *dateTo;
@property (nonatomic,retain) NSString *city;
@property  NSDecimal *minQualitaet;
@property  NSDecimal *maxCost;
@property  NSDecimal *maxSize;
@property  NSDecimal *minSize;
@property  BOOL   datefromfest;
@property  BOOL   dateToFest;
@property  int    rangeFrom;
@property  int    rangeTo;
@property  int    adults;
@property  int    children;
@property  int    rooms;
@property  int     groupID;
@property  int     wohnlageID;
@property  BOOL     AlternativeSearch;
@property  double    minHitRate;

 + (SearchParameters *) globalSearchParameters; 

@end

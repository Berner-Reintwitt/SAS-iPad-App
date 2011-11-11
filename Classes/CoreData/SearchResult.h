//
//  SearchResult.h
//  TabBarWithSplitView
//
//  Created by Berndt Reinhold on 25.10.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SearchParameters.h"


@interface SearchResult : NSObject {
    // <feder>
    NSString *exid;
    NSString *objnr;
    NSString *name;
    NSDate *fromDate;
    NSDate *toDate;
    int rooms;
    int bed_rooms;
    double living_area;
    int persons;
    int max_persons;
    int mindays;
    int kurzbucher;
    int nights;
    // </feder>
    SearchParameters *spar;
}

@property (nonatomic,retain) NSString *exid;
@property (nonatomic,retain) NSString *objnr;
@property (nonatomic,retain) NSString *name;
@property (nonatomic,retain) NSDate *fromDate;
@property (nonatomic,retain) NSDate *toDate;
@property int rooms;
@property int bed_rooms;
@property double living_area;
@property int persons;
@property int max_persons;
@property int mindays;
@property int kurzbucher;
@property int nights;
@property (nonatomic,retain) SearchParameters *spar;

- (double) hitrate;
- (double) price;

+ (NSArray *) mySearchresults: (SearchParameters *) sp;
+ (NSArray *) mySearchresults;

+ (NSArray *) Search:(SearchParameters *) spar;



@end

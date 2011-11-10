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
    
    NSDate *dateFrom;
    NSDate *dateTo;
    double  price;
    NSString *exid;
    double  hitrate;  //exaktheit des treffers
    SearchParameters *spar;
    
    
}

@property (nonatomic,retain) SearchParameters *spar;

@property (nonatomic,retain) NSDate *dateFrom;
@property (nonatomic,retain) NSDate *dateTo;
@property  double  price;
@property (nonatomic,retain) NSString *exid;
@property  double  hitrate;  //exaktheit des treffers
+ (NSArray *) mySearchresults: (SearchParameters *) sp;
+ (NSArray *) mySearchresults;

@end

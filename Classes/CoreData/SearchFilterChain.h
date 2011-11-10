//
//  SearchFilterChain.h
//  TabBarWithSplitView
//
//  Created by Berndt Reinhold on 25.10.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SearchFilter.h"
#import "SearchParameters.h"

@interface SearchFilterChain : NSEnumerator {
    SearchFilter *First;
    SearchFilter *Last;
    NSEnumerator *Source;
}

@property (nonatomic, retain) SearchFilter *First;
@property (nonatomic, retain) SearchFilter *Last;
@property (nonatomic, retain) NSEnumerator *Source;

+ (SearchFilterChain *) chainFromSearchParameters:(SearchParameters *)spar;


- (NSArray *) allObjects;
- (id) nextObject;

- (void) addFilter:(SearchFilter *)filter;
- (void) setSource:(NSEnumerator *)source;




@end

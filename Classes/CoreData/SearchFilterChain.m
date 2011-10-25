//
//  SearchFilterChain.m
//  TabBarWithSplitView
//
//  Created by Berndt Reinhold on 25.10.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "SearchFilterChain.h"
#import "StringConsts.h"

@implementation SearchFilterChain

@synthesize First;
@synthesize Last;
@synthesize Source;

+ (SearchFilterChain *) chainFromSearchParameters:(SearchParameters *)spar {
    SearchFilterChain *result = [[SearchFilterChain alloc] init];
    
    if (spar.adults + spar.children > 0) {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(max_persons >= %@)", spar.adults + spar.children];
        SearchFilter *filter = [SearchFilter searchFilterWithFilter:predicate];
        [result addFilter:filter];
    }
    
    if (spar.minQualitaet > 0) {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(quality >= %@)", spar.minQualitaet];
        SearchFilter *filter = [SearchFilter searchFilterWithFilter:predicate];
        [result addFilter:filter];
    }
    
    if (spar.minSize > 0) {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(living_area >= %@)", spar.minSize];
        SearchFilter *filter = [SearchFilter searchFilterWithFilter:predicate];
        [result addFilter:filter];
    }
    
    if (spar.maxSize > spar.minSize) {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(living_area <= %@)", spar.maxSize];
        SearchFilter *filter = [SearchFilter searchFilterWithFilter:predicate];
        [result addFilter:filter];
    }

    if (spar.rooms > 0) {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(rooms >= %@)", spar.rooms];
        SearchFilter *filter = [SearchFilter searchFilterWithFilter:predicate];
        [result addFilter:filter];
    }
    
    if (spar.groupID > 0) {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(groupID >= %@)", spar.groupID];
        SearchFilter *filter = [SearchFilter searchFilterWithFilter:predicate];
        [result addFilter:filter];
    }
    
    if ([spar.merkmale containsObject:NAME_alergic]) {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(alergic == 1)"];
        SearchFilter *filter = [SearchFilter searchFilterWithFilter:predicate];
        [result addFilter:filter];
    }
    
    if ([spar.merkmale containsObject:NAME_animals]) {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(animals == 1)"];
        SearchFilter *filter = [SearchFilter searchFilterWithFilter:predicate];
        [result addFilter:filter];
    }
    
    if ([spar.merkmale containsObject:NAME_smoking]) {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(smoking == 1)"];
        SearchFilter *filter = [SearchFilter searchFilterWithFilter:predicate];
        [result addFilter:filter];
    }
    
    return result;
}

#pragma mark -
#pragma mark helper methods

- (void) addFilter:(SearchFilter *)filter {
    if (nil == First) {
        First = Last = filter;
    } else {
        filter.Source = Last;
        Last = filter;
    }
}

- (void) setSource:(NSEnumerator *)source {
    Source = source;
    if (nil != First) {
        First.Source = source;
    }
}


#pragma mark -
#pragma mark NSEnumerable methods

- (id) nextObject {
    return nil != Last ? [Last nextObject] : nil;
}

- (NSArray *) allObjects {
    return nil != Last ? [Last allObjects] : nil;
}


@end

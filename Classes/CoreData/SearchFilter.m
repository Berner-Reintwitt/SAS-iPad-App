//
//  SearchFilter.m
//  TabBarWithSplitView
//
//  Created by Berndt Reinhold on 25.10.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "SearchFilter.h"

@implementation SearchFilter 

@synthesize Source;
@synthesize Filter;

#pragma mark -
#pragma mark Constructors

+ (SearchFilter *) searchFilterWithSource:(NSEnumerator *)source andWithFilter:(NSPredicate *)filter  {
    SearchFilter *result = [[SearchFilter alloc] init];
    result->Source = source;
    result->Filter = filter;
    return result;
}

+ (SearchFilter *) searchFilterWithSource:(NSEnumerator *)source {
    return [SearchFilter searchFilterWithSource:source andWithFilter:nil];
}

+ (SearchFilter *) searchFilterWithFilter:(NSPredicate *)filter {
    return [SearchFilter searchFilterWithSource:nil andWithFilter:filter];
}

#pragma mark -
#pragma mark NSEnumerable methods

- (NSArray *) allObjects {
    NSMutableArray *result = [NSMutableArray array];
    for (id object = [self nextObject]; nil != object; object = [self nextObject]) {
        [result addObject:object];
    }
    return result;
}

- (id) nextObject {
    if (nil == Source) return nil;
    id result = [Source nextObject];
    if (nil != Filter) {
        while (nil != result && ![Filter evaluateWithObject:result]) {
            result = [Source nextObject];
        }
    }
    return result;
}


@end

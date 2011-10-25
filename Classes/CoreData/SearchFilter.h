//
//  SearchFilter.h
//  TabBarWithSplitView
//
//  Created by Berndt Reinhold on 25.10.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SearchFilter : NSEnumerator {
    NSEnumerator *Source;
    NSPredicate *Filter;
}

@property (nonatomic,retain) NSEnumerator *Source;
@property (nonatomic,retain) NSPredicate *Filter;

+ (SearchFilter *) searchFilterWithSource:(NSEnumerator *)source;
+ (SearchFilter *) searchFilterWithFilter:(NSPredicate *)filter;
+ (SearchFilter *) searchFilterWithSource:(NSEnumerator *)source andWithFilter:(NSPredicate *)filter;

- (NSArray *) allObjects;
- (id) nextObject;

@end

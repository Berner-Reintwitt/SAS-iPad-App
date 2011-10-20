//
//  ObjInfo2+ObjInfo2Extensions.m
//  TabBarWithSplitView
//
//  Created by Berndt Reinhold on 20.10.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ObjInfo2+Extensions.h"
#import "ObjPicture.h"

static NSInteger picSort(id pic1, id pic2, void *context) {
    int v1 = [((ObjPicture *) pic1).serial intValue];
    int v2 = [((ObjPicture *) pic2).serial intValue];
    return v1 < v2 ? NSOrderedAscending : v1 > v2 ? NSOrderedDescending : NSOrderedSame;
}

@implementation ObjInfo2 (Extensions)

- (NSArray *) OrderedPictures {
    NSArray *unordered = self.pictures.allObjects;
    NSArray *ordered = [unordered sortedArrayUsingFunction:picSort context:NULL];   
    return ordered;
}

@end

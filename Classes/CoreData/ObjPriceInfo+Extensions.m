//
//  ObjPriceInfo+Extensions.m
//  TabBarWithSplitView
//
//  Created by Berndt Reinhold on 01.11.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ObjPriceInfo+Extensions.h"
#import "Price.h"
#import "Utils.h"

@implementation ObjPriceInfo (Extensions)

- (NSMutableData *) deepMd5Hash {
    NSMutableData *result = [NSMutableData dataWithData: self.md5hash];
    for (Price *p in self.prices) {
        XorMd5Hash(result, p.md5hash);
    }
    return result;
}

@end

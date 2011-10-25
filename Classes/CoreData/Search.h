//
//  Search.h
//  TabBarWithSplitView
//
//  Created by Berndt Reinhold on 25.10.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SearchParameters.h"

@interface Search : NSObject

+ (NSEnumerator *) SearchWithParameters:(SearchParameters *)spar;


@end

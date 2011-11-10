//
//  Price+Extensions.h
//  TabBarWithSplitView
//
//  Created by Berndt Reinhold on 10.11.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "Price.h"

@interface Price (Extensions)

+ (Price *) parseFromXmlNodes:(NSArray *)nodes withContext:(NSManagedObjectContext *)context;

@end

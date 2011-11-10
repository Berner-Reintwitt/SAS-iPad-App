//
//  AvailabilityInfo2+Extensions.h
//  TabBarWithSplitView
//
//  Created by Berndt Reinhold on 10.11.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "AvailabilityInfo2.h"

@interface AvailabilityInfo2 (Extensions)

+ (AvailabilityInfo2 *) parseFromXmlNodes:(NSArray *)nodes withContext:(NSManagedObjectContext *)context;

@end

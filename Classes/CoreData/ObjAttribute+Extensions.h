//
//  ObjAttribute+Extensions.h
//  TabBarWithSplitView
//
//  Created by Berndt Reinhold on 10.11.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ObjAttribute.h"

@interface ObjAttribute (Extensions)

+ (ObjAttribute *) parseFromXmlNodes:(NSArray *)nodes withContext:(NSManagedObjectContext *)context;

@end

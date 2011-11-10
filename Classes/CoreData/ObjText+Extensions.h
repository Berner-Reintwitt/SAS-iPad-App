//
//  ObjText+Extensions.h
//  TabBarWithSplitView
//
//  Created by Berndt Reinhold on 10.11.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ObjText.h"

@interface ObjText (Extensions)

+ (ObjText *) parseFromXmlNodes:(NSArray *)nodes withContext:(NSManagedObjectContext *)context;

@end

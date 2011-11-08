//
//  Queries.h
//  xmlLoad
//
//  Created by Berndt Reinhold on 10.10.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ObjInfo2.h"

void startImport(void);

@interface Queries : NSObject

+ (ObjInfo2 *) getApartment:(NSManagedObjectContext *)context withExID:(NSString *)exid;

+ (NSArray *) getAllApartments:(NSManagedObjectContext *)context;

+ (NSArray *) getAllApartmentsOrderedByExID:(NSManagedObjectContext *)context;

+ (NSInteger) countApartments:(NSManagedObjectContext *)context;

+ (void) initialImport:(NSManagedObjectContext *)context;

+ (void) incrementalImport:(NSManagedObjectContext *)context;

@end

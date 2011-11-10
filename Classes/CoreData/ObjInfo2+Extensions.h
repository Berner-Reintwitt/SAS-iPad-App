//
//  ObjInfo2+ObjInfo2Extensions.h
//  TabBarWithSplitView
//
//  Created by Berndt Reinhold on 20.10.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ObjInfo2.h"
#import "SearchParameters.h"

@interface ObjInfo2 (Extensions)

- (NSArray *) OrderedPictures;

- (NSMutableData *) picturesMd5Deep;

- (NSMutableData *) textsMd5Deep;

- (NSMutableData *) priceInfoMd5Deep;

- (NSMutableData *) availabilityInfoMd5Deep;

- (NSMutableData *) attributesMd5Deep;

- (NSMutableData *) deepMd5Hash;

+ (NSArray *) AllApartments;

+ (NSArray *) LocalSearch:(SearchParameters *)sparam;

- (void) updateFromXmlNodes:(NSArray *)nodes withContext:(NSManagedObjectContext *)context;

- (double) LowestPricePerWeek;

@end

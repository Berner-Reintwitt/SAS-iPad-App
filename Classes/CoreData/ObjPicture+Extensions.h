//
//  ObjPicture+Extensions.h
//  TabBarWithSplitView
//
//  Created by Berndt Reinhold on 24.10.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ObjPicture.h"

typedef enum {
    ScaleModeFit,
    ScaleModeCrop,
    ScaleModeLetterbox
} ScaleModes;

@interface ObjPicture (Extensions)

- (UIImage *) GetScaledImage:(int)width withHeight:(int)height withMode:(ScaleModes)mode;

+ (ObjPicture *) parseFromXmlNodes:(NSArray *)nodes withContext:(NSManagedObjectContext *)context;


@end

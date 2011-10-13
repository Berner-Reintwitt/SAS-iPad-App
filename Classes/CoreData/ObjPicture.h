//
//  ObjPicture.h
//  xmlLoad
//
//  Created by Berndt Reinhold on 12.10.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class ObjInfo2, ScaledImage;

@interface ObjPicture : NSManagedObject

@property (nonatomic, retain) NSString * big_url;
@property (nonatomic, retain) NSString * thumb_url;
@property (nonatomic, retain) NSDate * timestamp;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * type;
@property (nonatomic, retain) NSString * url;
@property (nonatomic, retain) ObjInfo2 *parent;
@property (nonatomic, retain) NSSet *images;
@end

@interface ObjPicture (CoreDataGeneratedAccessors)

- (void)addImagesObject:(ScaledImage *)value;
- (void)removeImagesObject:(ScaledImage *)value;
- (void)addImages:(NSSet *)values;
- (void)removeImages:(NSSet *)values;
@end

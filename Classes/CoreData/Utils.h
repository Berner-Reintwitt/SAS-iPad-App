//
//  Utils.h
//  xmlLoad
//
//  Created by Berndt Reinhold on 10.10.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString *DATASOURCE_URL;

extern NSString *QUERY_action;

extern NSString *ACTION_import;
extern NSString *IMPORT_name;

extern NSString *ACTION_picture;
extern NSString *PICTURE_url;
extern NSString *PICTURE_width;
extern NSString *PICTURE_height;
extern NSString *PICTURE_quality;
extern NSString *PICTURE_mode;

extern NSInteger PICTURE_QUALITY_highest;
extern NSInteger PICTURE_QUALITY_normal;
extern NSInteger PICTURE_QUALITY_low;
extern NSString *PICTURE_MODE_original;
extern NSString *PICTURE_MODE_crop;
extern NSString *PICTURE_MODE_letterbox;
extern NSString *PICTURE_MODE_fit;


NSManagedObjectModel *managedObjectModel(void);
NSManagedObjectContext *managedObjectContext(void);

NSString *EndcodeBase16(NSString *string);
NSData *readData(NSString *url, NSString *action, ...);
void logError(NSError *error);
NSData *readPicture(NSString *url, NSInteger width, NSInteger height, NSInteger quality, NSString *mode);

@interface Utils : NSObject
@end
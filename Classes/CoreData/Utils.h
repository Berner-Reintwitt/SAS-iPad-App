//
//  Utils.h
//  xmlLoad
//
//  Created by Berndt Reinhold on 10.10.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ImageIO/ImageIO.h>

#import "ObjPicture+Extensions.h"

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
NSPersistentStoreCoordinator *persistentStoreCoordinator(void);
NSURL *applicationDocumentsDirectory(void);
void saveContext(void);
NSData *getData(NSManagedObjectContext *context, NSString *key);
void setData(NSManagedObjectContext *context, NSString *key, NSData *data);
void XorMd5Hash(NSMutableData *a, NSData *b);
NSString *EndcodeBase16(NSString *string);
NSData *readData(NSString *url, NSString *action, ...);
NSData *readDataWithQueryArray(NSString *url, NSArray *paramAndValues);
void logError(NSError *error);
NSData *readPicture(NSString *url, NSInteger width, NSInteger height, NSInteger quality, NSString *mode);
NSString *NewUUID();
NSData *getData(NSManagedObjectContext *context, NSString *key);
void setData(NSManagedObjectContext *context, NSString *key, NSData *value);
CGImageRef CreateScaledCGImageFromCGImageWithMode(CGImageRef image, int dstWidth, int dstHeight, ScaleModes mode);

NSData *DecodeAP16(NSString *baseAP16Code);
NSString *EncodeAP16(NSData *md5Data);

NSString *parseExidFromTag(NSString *tag);
NSString *createExidParamString(NSEnumerator *enumerator);
NSString *dateToYYYYMMDD(NSDate *date);

BOOL containsPattern(NSString *source, NSString *pattern);


int parseInt(NSString *string);
double parseDouble(NSString *string);

BOOL tryParseInt(NSString *string, int *target);
BOOL tryParseDouble(NSString *string, double *target);


@interface Utils : NSObject

@end

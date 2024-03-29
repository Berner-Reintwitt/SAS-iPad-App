//
//  Utils.m
//  xmlLoad
//
//  Created by Berndt Reinhold on 10.10.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//


#import <CoreGraphics/CGContext.h>

#import "Utils.h"
#import "Queries.h"
#import "KeyValueData.h"
#import "StringConsts.h"


NSString *DATASOURCE_URL = @"http://feder-mirror.local/Query.ashx";

NSString *QUERY_action = @"source";

NSString *ACTION_import = @"import";
NSString *IMPORT_name = @"name";

NSString *ACTION_picture = @"picture";
NSString *PICTURE_url = @"url";
NSString *PICTURE_width = @"width";
NSString *PICTURE_height = @"height";
NSString *PICTURE_quality = @"quality";
NSString *PICTURE_mode = @"mode";


NSInteger PICTURE_QUALITY_highest = 100;
NSInteger PICTURE_QUALITY_normal = 85;
NSInteger PICTURE_QUALITY_low = 66;
NSString *PICTURE_MODE_original = @"original";
NSString *PICTURE_MODE_crop = @"crop";
NSString *PICTURE_MODE_letterbox = @"letterbox";
NSString *PICTURE_MODE_fit = @"fit";


NSString *EndcodeBase16(NSString *string) {
    static char hexCodes[] = "0123456789ABCDEF";
    char *src = (char *) [string UTF8String];
    unsigned long len = strlen(src);
    char dst[len * 2 + 1];
    dst[len * 2] = 0;
    for (unsigned long i = len; i > 0; ) {
        --i;
        char c = src[i];
        dst[i * 2] = hexCodes[c >> 4];
        dst[i * 2 + 1] = hexCodes[c & 15];
    }
    NSString *result = [NSString stringWithUTF8String:dst];
    return result;
}

NSData *DecodeAP16(NSString *baseAP16Code) {
	NSMutableData *result = [NSMutableData dataWithLength:baseAP16Code.length / 2];
	char *buffer = [result mutableBytes];
	for (int i = baseAP16Code.length / 2 - 1; i >= 0; --i) {
		buffer[i] = (char) (
			(([baseAP16Code characterAtIndex:i * 2 + 0] | 32) - 'a' & 0xf) << 4 |
			(([baseAP16Code characterAtIndex:i * 2 + 1] | 32) - 'a' & 0xf)
		);
	}
	return result;
}

NSString *EncodeAP16(NSData *md5Data) {
	NSCAssert(nil != md5Data && 16 == md5Data.length, @"argument exception");
	unichar buffer[32];
	const Byte *source = [md5Data bytes];
	for (int i = 15; i >= 0; --i) {
		Byte b = source[i];
		buffer[i * 2 + 0] = 'A' + ((b >> 4) & 0xf);
		buffer[i * 2 + 1] = 'A' + ((b >> 0) & 0xf);
	}
	return [NSString stringWithCharacters:buffer length:32];
}


void XorMd5Hash(NSMutableData *a, NSData *b) {
	NSCAssert(nil != a && 16 == a.length && nil != b && 16 == b.length, @"argument exception");
	Byte *bufa = [a mutableBytes];
	const Byte *bufb = [b bytes];
	for (int i = 15; i >= 0; --i) {
		bufa[i] ^= bufb[i];
	} 
}

NSMutableData *CreateXorMd5Hash(NSData *a, NSData *b) {
	NSMutableData *result = [NSMutableData dataWithData:a];
	XorMd5Hash(result, b);
	return result;
}

NSString *dateToYYYYMMDD(NSDate *date) {
	NSDateFormatter *df = [[[NSDateFormatter alloc] init] autorelease];
	NSCAssert(nil != df, @"dateToYYYYMMDD");
	[df setDateFormat:@"yyyyMMdd"];
	NSString *result = [df stringFromDate:date];
	NSCAssert(nil != result, @"dateToYYYYMMDD");
	return result;
}


BOOL tryParseInt(NSString *string, int *target) {
	NSScanner* scanner = [NSScanner scannerWithString:string];
	BOOL result = [scanner scanInt:target];
	return result;
}


int parseInt(NSString *string) {
	int result;
	if (!tryParseInt(string, &result)) {
		NSLog(@"parseInt error");
		result = -1;
	}
	return result;
}


BOOL tryParseDouble(NSString *string, double *target) {
	NSScanner* scanner = [NSScanner scannerWithString:string];
	BOOL result = [scanner scanDouble:target];
	return result;
}


double parseDouble(NSString *string) {
	double result;
	if (!tryParseDouble(string, &result)) {
		NSLog(@"parseDouble error");
		result = -1;
	}
	return result;
}


NSString *XorEncodedMd5Hash(NSString *a, NSString *b) {
	if (nil == a || nil == b || a.length != 32 || b.length != 32) {
		NSLog(@"argument exception");
		exit(1);
	}
	unichar buffer[32];
	for (int i = 31; i >= 0; --i) {
		buffer[i] = (64 | ([a characterAtIndex:i] - 1) ^ ([b characterAtIndex:i] - 1)) + 1;
	}
	return [NSString stringWithCharacters:buffer length:32];
}

NSString *NewUUID() {
	CFUUIDRef uid = CFMakeCollectable(CFUUIDCreate(NULL));
	CFStringRef uidStr = CFMakeCollectable(CFUUIDCreateString(NULL, uid));
	NSString *result = [[NSString alloc] initWithString:(NSString *)uidStr];
	[(id)uid release];
	[(id)uidStr release];
	return result;
}

void logError(NSError *error) {
    NSString *domain = [error domain];
    NSInteger code = [error code];
    NSLog(@"*** domain(%s) code(%d)", [domain UTF8String], code);
}

NSData *getData(NSManagedObjectContext *context, NSString *key) {
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:CLASS_KeyValueData inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(key == %@)", key];
    [fetchRequest setPredicate:predicate];
    NSError *error = nil;
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    [fetchRequest release];
    if (nil == fetchedObjects || fetchedObjects.count == 0) {
        // Handle the error
        NSLog(@"Utils.m - getData: missing key (%s)", [key UTF8String]);
        return nil;
    }
    if (fetchedObjects.count > 1) {
        NSLog(@"Utils.m - getData: multiple keys (%s)", [key UTF8String]);
        return nil;
    }
	KeyValueData *result = [fetchedObjects objectAtIndex:0];
    return result.value;
}

void setData(NSManagedObjectContext *context, NSString *key, NSData *value) {
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:CLASS_KeyValueData inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(key == %@)", key];
    [fetchRequest setPredicate:predicate];
    NSError *error = nil;
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    [fetchRequest release];
    if (nil == fetchedObjects || fetchedObjects.count == 0) {
        // Handle the error
        NSLog(@"Utils.m - getData: missing key (%s)", [key UTF8String]);
        return;
    }
    if (fetchedObjects.count > 1) {
        NSLog(@"Utils.m - getData: multiple keys (%s)", [key UTF8String]);
        return;
    }
	KeyValueData *result = [fetchedObjects objectAtIndex:0];
    result.value = value;
	[context processPendingChanges];
}


NSData *httpGet(NSString *urlAndQuery) {
	NSData *result;
    NSURL *url_query = [NSURL URLWithString: urlAndQuery];
	NSURLRequest *request = [NSURLRequest requestWithURL: url_query];
    NSError *error = nil;
    NSURLResponse *response;
    result = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    if (error) {
        logError(error);
    }
	return result;
}


NSData *readData(NSString *url, NSString *action, ...) {
    NSMutableString *query = [NSMutableString stringWithCapacity: 256];
    [query appendString: url];
    [query appendString: @"?"];
    
    NSString *pname = QUERY_action;
    NSString *pvalue = action;
    
    va_list argumentList;
    va_start(argumentList, action);
    while (true) {
        [query appendFormat:@"%s=%s", [pname UTF8String], [pvalue UTF8String]];
        pname = va_arg(argumentList, NSString *);
        if (nil == pname) break;
        pvalue = va_arg(argumentList, NSString *);
        if (nil == pvalue) {
            NSLog(@"argument '%s' without value", [pname UTF8String]);
            break;
        }
        [query appendString: @"&"];
    }
    va_end(argumentList);
	return httpGet(query);
}

NSData *readDataWithQueryArray(NSString *url, NSArray *paramAndValues) {
    NSMutableString *query = [NSMutableString stringWithCapacity: 256];
    [query appendString: url];
	if (nil != paramAndValues && paramAndValues.count > 0) {
		BOOL first = true;
		[query appendString:@"?"];
		for (int i = 0; i + 1 < paramAndValues.count; i += 2) {
			NSString *paramName = [paramAndValues objectAtIndex:i];
			NSString *paramValue = [paramAndValues objectAtIndex:i + 1];
			if (first) {
				first = false;
				[query appendFormat:@"%s=%s", paramName, paramValue];
			} else {
				[query appendFormat:@"&%s=%s", paramName, paramValue];
			}
		}
	}
	return httpGet(query);
}


NSString *parseExidFromTag(NSString *tag) {
	NSRange r = [tag rangeOfString:@"."];
	if (r.location == NSNotFound) {
		return nil;
	}
	NSString *result = [[tag substringFromIndex:r.location + 1] stringByReplacingOccurrencesOfString:@"-" withString:@"/"];
	return result;
}


BOOL containsPattern(NSString *source, NSString *pattern) {
	return
	nil != source &&
	nil != pattern &&
	NSNotFound != [source rangeOfString:pattern options:NSCaseInsensitiveSearch | NSLiteralSearch].location;
}


NSString *createExidParamString(NSEnumerator *enumerator) {
	NSMutableString *result = [NSMutableString stringWithCapacity:32];
	BOOL first = true;
	for (NSString *exid in enumerator) {
		if (first) {
			first = false;
		} else {
			[result appendString:@","];
		}
		[result appendString:[exid stringByReplacingOccurrencesOfString:@"/" withString:@"-"]];
	}
	return result;
}



NSData *readPicture(NSString *url, NSInteger width, NSInteger height, NSInteger quality, NSString *mode) {
    return readData(DATASOURCE_URL, ACTION_picture,
                    PICTURE_url, EndcodeBase16(url),
                    PICTURE_mode, mode,
                    PICTURE_width, [NSString stringWithFormat:@"%d", width],
                    PICTURE_height, [NSString stringWithFormat:@"%d", height],
                    PICTURE_quality, [NSString stringWithFormat:@"%d", quality],
                    nil);
}


NSURL *applicationDocumentsDirectory() {
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}


#pragma mark - Core Data stack

/**
 Returns the managed object context for the application.
 If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
 */
NSManagedObjectContext *managedObjectContext() {
    static NSManagedObjectContext *__managedObjectContext;
    if (__managedObjectContext != nil) {
        return __managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = persistentStoreCoordinator();
    if (coordinator != nil)
    {
        __managedObjectContext = [[NSManagedObjectContext alloc] init];
        [__managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return __managedObjectContext;
}

/**
 Returns the managed object model for the application.
 If the model doesn't already exist, it is created from the application's model.
 */
NSManagedObjectModel *managedObjectModel() {
    static NSManagedObjectModel *__managedObjectModel;
    if (__managedObjectModel != nil) {
        return __managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"ApartmentModel" withExtension:@"momd"];
    __managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return __managedObjectModel;
}

/**
 Returns the persistent store coordinator for the application.
 If the coordinator doesn't already exist, it is created and the application's store added to it.
 */
NSPersistentStoreCoordinator *persistentStoreCoordinator() {
	static NSPersistentStoreCoordinator *__persistentStoreCoordinator;
	if (__persistentStoreCoordinator != nil) {
		return __persistentStoreCoordinator;
	}
    
	NSURL *storeURL = [applicationDocumentsDirectory() URLByAppendingPathComponent:@"Apartments.sqlite"];
    
    NSError *error = nil;
    __persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:managedObjectModel()];
    if (![__persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
         
         Typical reasons for an error here include:
         * The persistent store is not accessible;
         * The schema for the persistent store is incompatible with current managed object model.
         Check the error message to determine what the actual problem was.
         
         
         If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
         
         If you encounter schema incompatibility errors during development, you can reduce their frequency by:
         * Simply deleting the existing store:
         [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
         
         * Performing automatic lightweight migration by passing the following dictionary as the options parameter: 
         [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:YES], NSMigratePersistentStoresAutomaticallyOption, [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption, nil];
         
         Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
         
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        //abort();
    }    
    
    return __persistentStoreCoordinator;
}


void saveContext() {
    NSError *error = nil;
    NSManagedObjectContext *context = managedObjectContext();
    if (managedObjectContext != nil) {
        if ([context hasChanges] && ![context save:&error]) {
            /*
             Replace this implementation with code to handle the error appropriately.
             
             abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
             */
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        } 
    }
}

CGImageRef CreateScaledCGImageFromCGImageWithMode(CGImageRef image, int dstWidth, int dstHeight, ScaleModes mode) {
	// Create the bitmap context
	CGContextRef context = NULL;
	void *bitmapData;
	
	int srcWidth = CGImageGetWidth(image);
	int srcHeight = CGImageGetHeight(image);
	double srcRatio, dstRatio;

	int cropLeft, cropTop, cropWidth, cropHeight;

	switch (mode) {
		case ScaleModeCrop:
			srcRatio = ((double) srcWidth) / ((double) srcHeight);
			dstRatio = ((double) dstWidth) / ((double) dstHeight);
			if (srcRatio > dstRatio) {
				cropTop = 0;
				cropHeight = dstHeight;
				cropWidth = (int) round(dstHeight * srcRatio);
				cropLeft = (dstWidth - cropWidth) / 2;
			} else {
				cropLeft = 0;
				cropWidth = dstWidth;
				cropHeight = (int) round(dstWidth / srcRatio);
				cropTop = (dstHeight - cropHeight) / 2;
			}
			break;
		case ScaleModeLetterbox:
			srcRatio = ((double) srcWidth) / ((double) srcHeight);
			dstRatio = ((double) dstWidth) / ((double) dstHeight);
			if (srcRatio > dstRatio) {
				cropLeft = 0;
				cropWidth = dstWidth;
				cropHeight = (int) round(dstWidth / srcRatio);
				cropTop = (dstHeight - cropHeight) / 2;
			} else {
				cropTop = 0;
				cropHeight = dstHeight;
				cropWidth = (int) round(dstHeight * srcRatio);
				cropLeft = (dstWidth - cropWidth) / 2;
			}
			break;
		case ScaleModeFit:
		default:
			cropLeft = cropTop = 0;
			cropWidth = dstWidth;
			cropHeight = dstHeight;
			break;
	}
	
	
	// Get image width, height. We'll use the entire image.
	int width = dstWidth;
	int height = dstHeight;
	
	// Declare the number of bytes per row. Each pixel in the bitmap in this
	// example is represented by 4 bytes; 8 bits each of red, green, blue, and
	// alpha.
	int bitmapBytesPerRow   = (width * 4);
	int bitmapByteCount     = (bitmapBytesPerRow * height);
	
	// Allocate memory for image data. This is the destination in memory
	// where any drawing to the bitmap context will be rendered.
	bitmapData = malloc( bitmapByteCount );
	if (bitmapData == NULL) {
		return nil;
	}
	
	// Create the bitmap context. We want pre-multiplied ARGB, 8-bits
	// per component. Regardless of what the source image format is
	// (CMYK, Grayscale, and so on) it will be converted over to the format
	// specified here by CGBitmapContextCreate.
	CGColorSpaceRef colorspace = CGImageGetColorSpace(image);
	context = CGBitmapContextCreate(bitmapData, width, height, 8, bitmapBytesPerRow, colorspace, kCGImageAlphaNoneSkipFirst);
	CGColorSpaceRelease(colorspace);
	
	if (context == NULL) {
		// error creating context
		return nil;
	}
	

	CGContextSetRGBFillColor(context, 1, 1, 1, 1);
	CGContextFillRect(context, CGRectMake(0, 0, dstWidth, dstHeight));
	
	
	CGContextSetInterpolationQuality(context, kCGInterpolationHigh);
	
	// Draw the image to the bitmap context. Once we draw, the memory
	// allocated for the context for rendering will then contain the
	// raw image data in the specified color space.
	CGContextDrawImage(context, CGRectMake(cropLeft, cropTop, cropWidth, cropHeight), image);
	
	CGImageRef imgRef = CGBitmapContextCreateImage(context);
	CGContextRelease(context);
	free(bitmapData);
	
	return imgRef;
}

/*
 static NSArray *fetchAll(NSManagedObjectContext *context, NSString *entityName) {
 //NSManagedObjectContext *context = <#Get the context#>;
 NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
 NSEntityDescription *entity = [NSEntityDescription entityForName:entityName inManagedObjectContext:context];
 [fetchRequest setEntity:entity];
 NSError *error = nil;
 NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
 if (fetchedObjects == nil) {
 // Handle the error
 }
 [fetchRequest release];    
 return fetchedObjects;
 }
 
 static NSArray *fetchAllAndSort(NSManagedObjectContext *context, NSString *entityName, NSString *sortKey) {
 //NSManagedObjectContext *context = <#Get the context#>;
 NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
 NSEntityDescription *entity = [NSEntityDescription entityForName:entityName inManagedObjectContext:context];
 [fetchRequest setEntity:entity];
 NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:sortKey ascending:YES];
 NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
 [fetchRequest setSortDescriptors:sortDescriptors];
 NSError *error = nil;
 NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
 if (fetchedObjects == nil) {
 // Handle the error
 }
 [fetchRequest release];
 [sortDescriptor release];
 [sortDescriptors release];    
 return fetchedObjects;
 }
 */



@implementation Utils
@end

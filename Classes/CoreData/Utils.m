//
//  Utils.m
//  xmlLoad
//
//  Created by Berndt Reinhold on 10.10.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "Utils.h"

NSString *DATASOURCE_URL = @"http://192.168.02.23:2222/DataSource.ashx";

NSString *QUERY_action = @"action";

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


void logError(NSError *error) {
    NSString *domain = [error domain];
    NSInteger code = [error code];
    NSLog(@"*** domain(%s) code(%d)", [domain UTF8String], code);
}


NSData *readData(NSString *url, NSString *action, ...) {
    NSData *result = nil;
    
    @autoreleasepool { 
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
        
        NSURL *url = [NSURL URLWithString: query];
        NSURLRequest *request = [NSURLRequest requestWithURL: url];
        NSError *error = nil;
        NSURLResponse *response;
        result = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
        if (error) {
            logError(error);
        }
    }
    return result;
}


NSData *readPicture(NSString *url, NSInteger width, NSInteger height, NSInteger quality, NSString *mode) {
    return readData(DATASOURCE_URL, ACTION_picture,
                    PICTURE_url, EndcodeBase16(url),
                    PICTURE_width, [NSString stringWithFormat:@"%d", width],
                    PICTURE_height, [NSString stringWithFormat:@"%d", height],
                    PICTURE_quality, [NSString stringWithFormat:@"%d", quality],
                    PICTURE_mode, mode,
                    nil);
}


NSManagedObjectModel *managedObjectModel() {
    
    static NSManagedObjectModel *model = nil;
    
    if (model != nil) {
        return model;
    }
    
    NSString *path = [[[NSProcessInfo processInfo] arguments] objectAtIndex:0];
    path = [path stringByDeletingPathExtension];
    NSURL *modelURL = [NSURL fileURLWithPath:[path stringByAppendingPathExtension:@"momd"]];
    model = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    
    return model;
}


NSManagedObjectContext *managedObjectContext() {
    
    static NSManagedObjectContext *context = nil;
    if (context != nil) {
        return context;
    }
    
    @autoreleasepool {
        context = [[NSManagedObjectContext alloc] init];
        
        NSPersistentStoreCoordinator *coordinator = [[[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:managedObjectModel()] autorelease];
        [context setPersistentStoreCoordinator:coordinator];
        
        NSString *STORE_TYPE = NSSQLiteStoreType;
        
        NSString *path = [[[NSProcessInfo processInfo] arguments] objectAtIndex:0];
        path = [path stringByDeletingPathExtension];
        NSURL *url = [NSURL fileURLWithPath:[path stringByAppendingPathExtension:@"sqlite"]];
        
        NSError *error;
        NSPersistentStore *newStore = [coordinator addPersistentStoreWithType:STORE_TYPE configuration:nil URL:url options:nil error:&error];
        
        if (newStore == nil) {
            NSLog(@"Store Configuration Failure %@", ([error localizedDescription] != nil) ? [error localizedDescription] : @"Unknown Error");
        }
    }
    return context;
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

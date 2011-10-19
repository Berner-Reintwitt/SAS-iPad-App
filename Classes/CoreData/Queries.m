//
//  Queries.m
//  xmlLoad
//
//  Created by Berndt Reinhold on 10.10.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "Queries.h"
#import "Utils.h"
#import "AbstractParser.h"
#import "ObjInfo2Parser.h"
#import "ObjPictureParser.h"
#import "ObjTextParser.h"
#import "ObjPriceInfoParser.h"
#import "AvailabilityInfo2Parser.h"
#import "StringConsts.h"

static void __startImport(void *ctx) {
    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
    
	NSManagedObjectContext *context =  (NSManagedObjectContext *) ctx;
	
	[[context undoManager] disableUndoRegistration];
	
    [Queries initialImport: context]; // make changes for which undo operations are not to be recorded

	[[context undoManager] enableUndoRegistration];	

	saveContext();
	
    [pool release];
}

void startImport(void) {
	NSManagedObjectContext *context = managedObjectContext();
	if ([Queries countApartments:context] <= 0) {
		dispatch_queue_t aQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
		dispatch_async_f(aQueue, context, &__startImport);
	}
}

@implementation Queries

+ (ObjInfo2 *) getApartment:(NSManagedObjectContext *)context withExID:(NSString *)exid {
    ObjInfo2 *result;
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:CLASS_ObjInfo2 inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(exid == %@)", exid];
    [fetchRequest setPredicate:predicate];
    NSError *error = nil;
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    [fetchRequest release];
    if (nil == fetchedObjects || fetchedObjects.count == 0) {
        // Handle the error
        NSLog(@"AbstractParser.getObjInfo2: missing exid(%s)", [exid UTF8String]);
        return nil;
    }
    if (fetchedObjects.count > 1) {
        NSLog(@"AbstractParser.getObjInfo2: multiple exid(%s)", [exid UTF8String]);
        //return nil;
    }
    result = [fetchedObjects objectAtIndex:0];
    return result;
}

+ (NSArray *) getAllApartments:(NSManagedObjectContext *)context {
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:CLASS_ObjInfo2 inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
	[fetchRequest setPredicate:nil];
    NSError *error = nil;
    NSArray *result = [context executeFetchRequest:fetchRequest error:&error];
    [fetchRequest release];
    return result;
}

+ (NSInteger) countApartments:(NSManagedObjectContext *)context {
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:CLASS_ObjInfo2 inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
	[fetchRequest setPredicate:nil];
    NSError *error = nil;
    NSInteger result = [context countForFetchRequest:fetchRequest error:&error];
	if (nil != error) {
		result = -1;
	}
    [fetchRequest release];
    return result;
}

+ (void) initialImport:(NSManagedObjectContext *)context {

    NSData *xmlData;
    NSXMLParser *pXML;
    AbstractParser *aparser;
    BOOL b, s;

    xmlData = readData(DATASOURCE_URL, ACTION_import, IMPORT_name, @"objliste2", nil);
    pXML = [[NSXMLParser alloc] initWithData: xmlData];
    aparser = [[ObjInfo2Parser alloc] initWithContext:context];
    [pXML setDelegate: aparser];
    s = (b = [pXML parse]);
    if (!b) {
        NSLog(@"ObjListe2 parse error");
    } else {
        NSLog(@"ObjListe2 imported");
    }
    [pXML release];
    [aparser release];
    [context processPendingChanges];
    
    xmlData = readData(DATASOURCE_URL, ACTION_import, IMPORT_name, @"objpictures", nil);
    pXML = [[NSXMLParser alloc] initWithData: xmlData];
    aparser = [[ObjPictureParser alloc] initWithContext:context];
    [pXML setDelegate: aparser];
    s &= (b = [pXML parse]);
    if (!b) {
        NSLog(@"ObjPicture parse error");
    } else {
        NSLog(@"ObjPicture imported");
    }
    [pXML release];
    [aparser release];
    [context processPendingChanges];

    xmlData = readData(DATASOURCE_URL, ACTION_import, IMPORT_name, @"objtexts", nil);
    pXML = [[NSXMLParser alloc] initWithData: xmlData];
    aparser = [[ObjTextParser alloc] initWithContext:context];
    [pXML setDelegate: aparser];
    s &= (b = [pXML parse]);
    if (!b) {
        NSLog(@"ObjText parse error");
    } else {
        NSLog(@"ObjText imported");
    }
    [pXML release];
    [aparser release];
    [context processPendingChanges];

    xmlData = readData(DATASOURCE_URL, ACTION_import, IMPORT_name, @"objpricelists", nil);
    pXML = [[NSXMLParser alloc] initWithData: xmlData];
    aparser = [[ObjPriceInfoParser alloc] initWithContext:context];
    [pXML setDelegate: aparser];
    s &= (b = [pXML parse]);
    if (!b) {
        NSLog(@"ObjPrceInfo parse error");
    } else {
        NSLog(@"ObjPrceInfo imported");
    }
    [pXML release];
    [aparser release];
    [context processPendingChanges];
 
    
    xmlData = readData(DATASOURCE_URL, ACTION_import, IMPORT_name, @"availabilityinfo", nil);
    pXML = [[NSXMLParser alloc] initWithData: xmlData];
    aparser = [[AvailabilityInfo2Parser alloc] initWithContext:context];
    [pXML setDelegate: aparser];
    s &= (b = [pXML parse]);
    if (!b) {
        NSLog(@"AvailabilityInfo2 parse error");
    } else {
        NSLog(@"AvailabilityInfo2 imported");
    }
    [pXML release];
    [aparser release];
    [context processPendingChanges];

    if (!s) {
        NSLog(@"inport failed");
    }
    
}

@end

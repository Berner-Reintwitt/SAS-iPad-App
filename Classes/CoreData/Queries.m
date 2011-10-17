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
    [Queries initialImport: context];
    [pool release];
}

void startImport(void) {
    dispatch_queue_t aQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async_f(aQueue, managedObjectContext(), &__startImport);
}


@implementation Queries

+ (ObjInfo2 *) getApartment:(NSString *)withExID context:(NSManagedObjectContext *)context {
    ObjInfo2 *result;
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:CLASS_ObjInfo2 inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(exid == %@)", withExID];
    [fetchRequest setPredicate:predicate];
    NSError *error = nil;
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    [fetchRequest release];
    if (nil == fetchedObjects || fetchedObjects.count == 0) {
        // Handle the error
        NSLog(@"AbstractParser.getObjInfo2: missing exid(%s)", [withExID UTF8String]);
        return nil;
    }
    if (fetchedObjects.count > 1) {
        NSLog(@"AbstractParser.getObjInfo2: multiple exid(%s)", [withExID UTF8String]);
        //return nil;
    }
    result = [fetchedObjects objectAtIndex:0];
    return result;
}

+ (ObjInfo2 *) newApartment:(NSManagedObjectContext *)context {
    ObjInfo2 *apartment = [NSEntityDescription insertNewObjectForEntityForName:CLASS_ObjInfo2 inManagedObjectContext:context];
    return [apartment retain];
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
    saveContext();
    
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
    saveContext();

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
    saveContext();

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
    saveContext();
 
    
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
    saveContext();

    if (!s) {
        NSLog(@"inport failed");
    }
    
}

@end

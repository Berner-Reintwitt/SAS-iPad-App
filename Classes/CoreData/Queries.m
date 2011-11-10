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
#import "XPathQuery.h"
#import "ObjInfo2+Extensions.h"
#import "ObjPriceInfo+Extensions.h"
#import "ObjText+Extensions.h"

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

static NSInteger orderByExid(id obj1, id obj2, void *context) {
	return [((ObjInfo2 *) obj1).exid compare:((ObjInfo2 *) obj2).exid];
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

+ (NSArray *) getAllApartmentsOrderedByExID:(NSManagedObjectContext *)context {
	NSArray *unorderedApartments = [Queries getAllApartments:context];
	NSArray *orderedApartments = [unorderedApartments sortedArrayUsingFunction:orderByExid context:NULL];
	return orderedApartments;
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
    BOOL b, s = TRUE;

	
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

	
    if (!s) {
        NSLog(@"inport failed");
    } else {
		NSError *error = nil;
		if ([context save:&error] != YES) {
			NSLog(@"can't save context");
			if (nil != error) {
				NSLog(@"%s", [error.localizedDescription UTF8String]);
			}
		}
	}
    
}


static void importSingleExid(NSManagedObjectContext *context, NSString *exid) {

    NSData *xmlData;
    NSXMLParser *pXML;
    AbstractParser *aparser;
    BOOL b, s = TRUE;
	
	
	xmlData = readData(DATASOURCE_URL, @"obj", @"mode", @"data", @"exid", exid, nil);
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
    
	
	xmlData = readData(DATASOURCE_URL, @"priceinfo", @"mode", @"data", @"exid", exid, nil);
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
	
	
	xmlData = readData(DATASOURCE_URL, @"availabilityinfo", @"mode", @"data", @"exid", exid, nil);
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
	
	
	xmlData = readData(DATASOURCE_URL, @"texts", @"mode", @"data", @"exid", exid, nil);
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
	
    
	xmlData = readData(DATASOURCE_URL, @"pictures", @"mode", @"data", @"exid", exid, nil);
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
	
	
    if (!s) {
        NSLog(@"inport failed");
    } else {
		NSError *error = nil;
		if ([context save:&error] != YES) {
			NSLog(@"can't save context");
			if (nil != error) {
				NSLog(@"%s", [error.localizedDescription UTF8String]);
			}
		}
	}
    
}

static void updateSingleExid(NSManagedObjectContext *context, NSString *exid) {

	NSString *keyMd5Shallow = @"md5shallow";
	NSString *keyPicDeep = @"objpictures";
	NSString *keyTextDeep = @"objtexts";
	NSString *keyPriceInfoDeep = @"objpriceinfo";
	NSString *keyAvailabilityInfoDeep = @"objavailabilityinfo";
	NSString *keyAttributesDeep = @"objattributes";	
	
	NSString *nodeName, *nodeContent;
	
	
	ObjInfo2 *apartment = [Queries getApartment:context withExID:exid];
	NSCAssert(nil != apartment, @"missing exid");
	NSData *md5shallow, *picDeep, *textDeep, *priceInfoDeep, *availabilityInfoDeep, *attributesDeep;
	md5shallow = picDeep = textDeep = priceInfoDeep = availabilityInfoDeep = attributesDeep = nil;
	
	NSData *rawXML = readData(DATASOURCE_URL, @"obj", @"mode", @"details", @"exid", exid, nil);
	NSString *ex_id = [exid stringByReplacingOccurrencesOfString:@"/" withString:@"-"];
	NSString *nodePath = [NSString stringWithFormat:@"/objdetails/exid.%s/*", [ex_id UTF8String]];
	
	
	NSArray *root = PerformXMLXPathQuery(rawXML, nodePath);

	for (NSDictionary *d in root) {
		nodeName = [d objectForKey:@"nodeName"];
		nodeContent = [d objectForKey:@"nodeContent"];
		NSData *nodeMd5 = DecodeAP16(nodeContent); 
		if ([nodeName compare:keyMd5Shallow] == NSOrderedSame) {
			NSCAssert(nil == md5shallow, @"double node");
			md5shallow = nodeMd5;
		} else if ([nodeName compare:keyPicDeep] == NSOrderedSame) {
			NSCAssert(nil == picDeep, @"double node");
			picDeep = nodeMd5;
		} else if ([nodeName compare:keyTextDeep] == NSOrderedSame) {
			NSCAssert(nil == textDeep, @"double node");
			textDeep = nodeMd5;
		} else if ([nodeName compare:keyPriceInfoDeep] == NSOrderedSame) {
			NSCAssert(nil == priceInfoDeep, @"double node");
			priceInfoDeep = nodeMd5;
		} else if ([nodeName compare:keyAvailabilityInfoDeep] == NSOrderedSame) {
			NSCAssert(nil == availabilityInfoDeep, @"double node");
			availabilityInfoDeep = nodeMd5;
		} else if ([nodeName compare:keyAttributesDeep] == NSOrderedSame) {
			NSCAssert(nil == attributesDeep, @"double node");
			attributesDeep = nodeMd5;
		}
	}

	NSCAssert(nil != md5shallow && nil != picDeep && nil != textDeep && nil != priceInfoDeep && nil != availabilityInfoDeep && nil != attributesDeep, @"missing value");
	
	
	NSData *orig = [apartment md5hash];
	if (![md5shallow isEqualToData:[apartment md5hash]] || ![attributesDeep isEqualToData:[apartment attributesMd5Deep]]) {
		// apartment or attributes has changed
		rawXML = readData(DATASOURCE_URL, @"obj", @"mode", @"data", @"exid", ex_id, nil);
		nodePath = [NSString stringWithFormat:@"/objdata/exid.%s/ObjInfo2", [ex_id UTF8String]];
		root = PerformXMLXPathQuery(rawXML, nodePath);
		[apartment updateFromXmlNodes:root withContext:context];
	}
	
	orig = [apartment picturesMd5Deep];
	if (![picDeep isEqualToData:[apartment picturesMd5Deep]]) { // pictures has changed
		rawXML = readData(DATASOURCE_URL, @"pictures", @"mode", @"data", @"exid", ex_id, nil);
		nodePath = [NSString stringWithFormat:@"/objpictures/exid.%s/ObjPicture", [ex_id UTF8String]];
		root = PerformXMLXPathQuery(rawXML, nodePath);
		NSMutableSet *newPics = [NSMutableSet setWithCapacity:8];
		for (NSDictionary *d in root) {
			NSArray *childNodes = [d objectForKey:XML_NodeChildNodes];
			ObjPicture *pic = [ObjPicture parseFromXmlNodes:childNodes withContext:context];
			if (nil != pic) {
				[newPics addObject:pic];
			}
		}
		[apartment removePictures:apartment.pictures];
		[apartment addPictures:newPics];
	}
	
	orig = [apartment textsMd5Deep];
	if (![textDeep isEqualToData:[apartment textsMd5Deep]]) { // texts has changed
		rawXML = readData(DATASOURCE_URL, @"texts", @"mode", @"data", @"exid", ex_id, nil);
		nodePath = [NSString stringWithFormat:@"/objtexts/exid.%s/ObjText", [ex_id UTF8String]];
		root = PerformXMLXPathQuery(rawXML, nodePath);
		[apartment removeTexts:apartment.texts]; // remove all textes
		for (NSDictionary *d in root) {
			ObjText *t = [ObjText parseFromXmlNodes:[d objectForKey:XML_NodeChildNodes] withContext:context];
			[apartment addTextsObject:t];
		}
	}

	orig = [apartment priceInfoMd5Deep];
	if (![priceInfoDeep isEqualToData:[apartment priceInfoMd5Deep]]) { // prices has changed
		rawXML = readData(DATASOURCE_URL, @"priceinfo", @"mode", @"data", @"exid", ex_id, nil);
		nodePath = [NSString stringWithFormat:@"/objpriceinfo/exid.%s/ObjPriceInfo", [ex_id UTF8String]];
		root = PerformXMLXPathQuery(rawXML, nodePath);
		[apartment removePriceInfo:apartment.priceInfo]; // remove all priceinfo
		for (NSDictionary *d in root) {
			NSArray *nodeChildArray = [d objectForKey:@"nodeChildArray"];
			ObjPriceInfo *pi = [ObjPriceInfo parseFromXmlNodes:nodeChildArray withContext:managedObjectContext()];
			[apartment addPriceInfoObject: pi];
		}
	}
	
	orig = [apartment availabilityInfoMd5Deep];
	if (![availabilityInfoDeep isEqualToData:[apartment availabilityInfoMd5Deep]]) { // availabilityInfo has changed
		[apartment removeAvailabilityInfo:apartment.availabilityInfo]; // remove availabilityInfo
		rawXML = readData(DATASOURCE_URL, @"availabilityinfo", @"mode", @"data", @"exid", ex_id, nil);
		nodePath = [NSString stringWithFormat:@"/objavailabilityinfo/AvailabilityInfo2/*", [ex_id UTF8String]];
		root = PerformXMLXPathQuery(rawXML, nodePath);
		[apartment removePriceInfo:apartment.priceInfo]; // remove all priceinfo
		for (NSDictionary *d in root) {
			NSArray *nodeChildArray = [d objectForKey:@"nodeChildArray"];
			AvailabilityInfo2 *ai = [AvailabilityInfo2 parseFromXmlNodes:nodeChildArray withContext:managedObjectContext()];
			[apartment addAvailabilityInfoObject:ai];
		}
	}

}

+ (void) incrementalImport:(NSManagedObjectContext *)context {
	NSMutableData *deep = [NSMutableData dataWithLength:16];
	for (ObjInfo2 *oi2 in [Queries getAllApartments:context]) {
		XorMd5Hash(deep, oi2.md5hash);
	}
	
	NSData *rawXML = readData(DATASOURCE_URL, @"obj", @"mode", @"summary", nil);
	NSArray *root = PerformXMLXPathQuery(rawXML, @"/summary");
	NSDictionary *top = [root objectAtIndex:0];
	NSString *sumBase16 = [top objectForKey:@"nodeContent"];
	NSData *summaryMd5 = DecodeAP16(sumBase16);

	if (![deep isEqualToData:summaryMd5]) {
		NSLog(@"update...");
		

		/*** create md5deep => ObjInfo2, md5shallow => ObjInfo2 and exid ==> ObjInfo2 dictionaries */
		NSArray *allApartments = [Queries getAllApartments:managedObjectContext()];
		NSMutableDictionary *deepObjInfo2Dict = [NSMutableDictionary dictionaryWithCapacity:allApartments.count];
		NSMutableDictionary *shallowObjInfo2Dict = [NSMutableDictionary dictionaryWithCapacity:allApartments.count];
		NSMutableDictionary *exidObjInfo2Dict = [NSMutableDictionary dictionaryWithCapacity:allApartments.count];
		for (ObjInfo2 *oi2 in allApartments) {
			[deepObjInfo2Dict setObject:oi2 forKey:[oi2 deepMd5Hash]];
			[shallowObjInfo2Dict setObject:oi2 forKey:oi2.md5hash];
			[exidObjInfo2Dict setObject:oi2 forKey:oi2.exid];
		}
		

		/*** divide md5deep in hits and misses */
		NSMutableDictionary *remoteMissingMd5DeepExidDict = [NSMutableDictionary dictionaryWithCapacity:allApartments.count];
		NSMutableSet *remoteHitMd5DeepSet = [NSMutableSet setWithCapacity:allApartments.count]; 
		
		rawXML = readData(DATASOURCE_URL, @"obj", @"mode", @"md5deep", @"exid", @"*", nil);
		root = PerformXMLXPathQuery(rawXML, @"/objmd5deep/*");

		for (NSDictionary *dict in root) {
			NSString *base16 = [dict objectForKey:@"nodeContent"];
			NSString *exidTag =  [dict objectForKey:@"nodeName"];
			if (nil == base16) {
				NSLog(@"incImp");
				exit(1);
			}
			NSData *md5deep = DecodeAP16(base16);
			if (nil != [deepObjInfo2Dict objectForKey:md5deep]) {
				[remoteHitMd5DeepSet addObject:md5deep];
			} else {
				NSRange r = [exidTag rangeOfString:@"."];
				NSAssert(r.location != NSNotFound, @"wrong tag format");
				NSString *exid = [[exidTag substringFromIndex:r.location + 1] stringByReplacingOccurrencesOfString:@"-" withString:@"/"];
				[remoteMissingMd5DeepExidDict setObject:exid forKey:md5deep];
			}			
		}
		NSLog(@"deep equ = %d", remoteHitMd5DeepSet.count); // hits don't need further processing

		NSMutableSet *localMissingMd5Deep = [NSMutableSet setWithCapacity:allApartments.count]; // find local unmatched md5deep
		for (NSData *md5deep in deepObjInfo2Dict.allKeys) {
			if (![remoteHitMd5DeepSet containsObject:md5deep]) {
				[localMissingMd5Deep addObject:md5deep];
			}
		}
		

		NSSet *remoteExids = [NSSet setWithArray:remoteMissingMd5DeepExidDict.allValues]; // exids for unmatched remoted md5deeps
		
		NSMutableSet *localExids = [NSMutableSet setWithCapacity:allApartments.count]; // exids for unmatched local md5deeps
		for (NSData *md5 in localMissingMd5Deep) {
			ObjInfo2 *oi2 = [deepObjInfo2Dict objectForKey:md5];
			NSAssert(nil != oi2, @"missing md5deep key");
			[localExids addObject: oi2.exid];
		}
		
		NSMutableSet *modifiedExids = [NSMutableSet setWithCapacity:allApartments.count]; // modified apartments

		NSMutableSet *remoteAddedExids = [NSMutableSet setWithCapacity:allApartments.count]; // new remote apartments
		for (NSString *exid in remoteExids) {
			if (![localExids containsObject:exid]) { // have no local buddy
				[remoteAddedExids addObject:exid];
			} else {
				[modifiedExids addObject:exid]; // or are just modified
			}
		}
		
		NSMutableSet *remoteRemovedExids = [NSMutableSet setWithCapacity:allApartments.count]; // remote removed apartments
		for (NSString *exid in localExids) {
			if (![remoteExids containsObject:exid]) { // have no remote buddy
				[remoteRemovedExids addObject:exid];
			} else {
				[modifiedExids addObject:exid]; // or are just modified
			}
		}
		
		for (NSString *exid in remoteRemovedExids) { // delete apartment
/*			ObjInfo2 *apartment = [Queries getApartment:managedObjectContext() withExID:exid];
			NSAssert(nil != apartment, @"missing exid");
			[managedObjectContext() deleteObject: apartment];
*/		}
		
		for (NSString *exid in remoteAddedExids) { // import apartments
//			importSingleExid(managedObjectContext(), exid);
		}
		
		for (NSString *exid in modifiedExids) { // update apartments
			updateSingleExid(managedObjectContext(), exid);
		}
		
		saveContext();
		
		return;
		
	}
	
}

@end

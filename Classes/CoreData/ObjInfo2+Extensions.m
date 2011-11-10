//
//  ObjInfo2+ObjInfo2Extensions.m
//  TabBarWithSplitView
//
//  Created by Berndt Reinhold on 20.10.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//


#import "AvailabilityInfo2.h"
#import "ObjAttribute+Extensions.h"
#import "ObjInfo2+Extensions.h"
#import "ObjPicture+Extensions.h"
#import "ObjPriceInfo+Extensions.h"
#import "Price.h"
#import "ObjText.h"
#import "Utils.h"
#import "StringConsts.h"
#import "AbstractParser.h"

static NSInteger picSort(id pic1, id pic2, void *context) {
    int v1 = [((ObjPicture *) pic1).serial intValue];
    int v2 = [((ObjPicture *) pic2).serial intValue];
    return v1 < v2 ? NSOrderedAscending : v1 > v2 ? NSOrderedDescending : NSOrderedSame;
}

static NSPredicate *maxPersons(int actPersons) {
    NSExpression *leftSide = [NSExpression expressionForKeyPath: NAME_max_persons];
    NSExpression *rightSide = [NSExpression expressionForConstantValue: [NSNumber numberWithInt: actPersons]];
    NSPredicate *result = [NSComparisonPredicate
                          predicateWithLeftExpression: leftSide
                          rightExpression: rightSide
                          modifier: NSDirectPredicateModifier
                          type: NSGreaterThanOrEqualToPredicateOperatorType
                          options: 0];
    return result;
}

//static NSPredicate *exid(

@implementation ObjInfo2 (Extensions)

- (void) updateFromXmlNodes:(NSArray *)nodes withContext:(NSManagedObjectContext *)context {

    NSString
    *alergic = nil,
    *animals = nil,
    *anlageID = nil,
    *bed_rooms = nil,
    *city = nil,
    *cityID = nil,
    *erbaut = nil,
    *etage = nil,
    *exid = nil,
    *flags = nil,
    *fromDate = nil,
    *latitude = nil,
    *longitude = nil,
    *group = nil,
    *groupID = nil,
    *houseID = nil,
    *id_ = nil,
    *lageID = nil,
    *land = nil,
    *living_area = nil,
    *max_persons = nil,
    *mindays = nil,
    *name = nil,
    *objnr = nil,
    *ortslageID = nil,
    *persons = nil,
    *quality = nil,
    *region = nil,
    *regionID = nil,
    *renoviert = nil,
    *smoking = nil,
    *street = nil,
    *timestamp = nil,
    *toDate = nil,
    *typID = nil,
    *wohnlageID = nil,
    *zipcode = nil,
    *md5 = nil;

    NSMutableSet *attributes = nil;

    NSLog(@"update ObjInfo2(%s)", [self.exid UTF8String]);
    
    for (NSDictionary *d in nodes) {
        NSString *nodeName = [d objectForKey:XML_NodeName];
        NSString *nodeContent = [d objectForKey:XML_NodeContent];
        if ([nodeName compare:NAME_alergic] == NSOrderedSame) alergic = nodeContent;
        else if ([nodeName compare:NAME_animals] == NSOrderedSame) animals = nodeContent;
        else if ([nodeName compare:NAME_anlageID] == NSOrderedSame) anlageID = nodeContent;
        else if ([nodeName compare:NAME_bed_rooms] == NSOrderedSame) bed_rooms = nodeContent;
        else if ([nodeName compare:NAME_city] == NSOrderedSame) city = nodeContent;
        else if ([nodeName compare:NAME_cityID] == NSOrderedSame) cityID = nodeContent;
        else if ([nodeName compare:NAME_erbaut] == NSOrderedSame) erbaut = nodeContent;
        else if ([nodeName compare:NAME_etage] == NSOrderedSame) etage = nodeContent;
        else if ([nodeName compare:NAME_exid] == NSOrderedSame) exid = nodeContent;
        else if ([nodeName compare:NAME_flags] == NSOrderedSame) flags = nodeContent;
        else if ([nodeName compare:NAME_fromDate] == NSOrderedSame) fromDate = nodeContent;
        else if ([nodeName compare:NAME_latitude] == NSOrderedSame) latitude = nodeContent;
        else if ([nodeName compare:NAME_longitude] == NSOrderedSame) longitude = nodeContent;
        else if ([nodeName compare:NAME_group] == NSOrderedSame) group = nodeContent;
        else if ([nodeName compare:NAME_groupID] == NSOrderedSame) groupID = nodeContent;
        else if ([nodeName compare:NAME_houseID] == NSOrderedSame) houseID = nodeContent;
        else if ([nodeName compare:NAME_id] == NSOrderedSame) id_ = nodeContent;
        else if ([nodeName compare:NAME_lageID] == NSOrderedSame) lageID = nodeContent;
        else if ([nodeName compare:NAME_land] == NSOrderedSame) land = nodeContent;
        else if ([nodeName compare:NAME_living_area] == NSOrderedSame) living_area = nodeContent;
        else if ([nodeName compare:NAME_max_persons] == NSOrderedSame) max_persons = nodeContent;
        else if ([nodeName compare:NAME_mindays] == NSOrderedSame) mindays = nodeContent;
        else if ([nodeName compare:NAME_name] == NSOrderedSame) name = nodeContent;
        else if ([nodeName compare:NAME_objnr] == NSOrderedSame) objnr = nodeContent;
        else if ([nodeName compare:NAME_ortslageID] == NSOrderedSame) ortslageID = nodeContent;
        else if ([nodeName compare:NAME_persons] == NSOrderedSame) persons = nodeContent;
        else if ([nodeName compare:NAME_quality] == NSOrderedSame) quality = nodeContent;
        else if ([nodeName compare:NAME_region] == NSOrderedSame) region = nodeContent;
        else if ([nodeName compare:NAME_regionID] == NSOrderedSame) regionID = nodeContent;
        else if ([nodeName compare:NAME_renoviert] == NSOrderedSame) renoviert = nodeContent;
        else if ([nodeName compare:NAME_smoking] == NSOrderedSame) smoking = nodeContent;
        else if ([nodeName compare:NAME_street] == NSOrderedSame) street = nodeContent;
        else if ([nodeName compare:NAME_timestamp] == NSOrderedSame) timestamp = nodeContent;
        else if ([nodeName compare:NAME_toDate] == NSOrderedSame) toDate = nodeContent;
        else if ([nodeName compare:NAME_typID] == NSOrderedSame) typID = nodeContent;
        else if ([nodeName compare:NAME_wohnlageID] == NSOrderedSame) wohnlageID = nodeContent;
        else if ([nodeName compare:NAME_zipcode] == NSOrderedSame) zipcode = nodeContent;
        else if ([nodeName compare:Name_md5] == NSOrderedSame) md5 = nodeContent;
        else if ([nodeName compare:NAME_attributes] == NSOrderedSame) {
            attributes = [NSMutableSet setWithCapacity:16];
            NSArray *attribXml = [d objectForKey:XML_NodeChildNodes];
            for (NSDictionary *objAttributeTag in attribXml) {
                NSArray *childNodesXml = [objAttributeTag objectForKey:XML_NodeChildNodes];
                ObjAttribute *oa = [ObjAttribute parseFromXmlNodes:childNodesXml withContext:context];
                [attributes addObject:oa];
            }
        } else NSLog(@"unknown tag %s", [nodeContent UTF8String]);
    }
    
    if (nil == alergic || nil == animals || nil == anlageID || nil == bed_rooms || nil == city || nil == cityID || nil == erbaut || nil == etage || nil == exid || nil == flags || nil == fromDate || nil == latitude || nil == longitude  || nil == group || nil == groupID || nil == houseID || nil == id_ || nil == lageID || nil == land || nil == living_area || nil == max_persons || nil == mindays || nil == name || nil == objnr  || nil == ortslageID || nil == persons || nil == quality || nil == region || nil == regionID || nil == renoviert || nil == smoking || nil == street || nil == timestamp || nil == toDate || nil == typID || nil == wohnlageID || nil == zipcode || nil == md5 || nil == attributes) {
        NSLog(@"ObjInfo2 update: missing tag");
        return;
    }

    self.alergic = [AbstractParser parseBoolean:alergic];
    self.animals = [AbstractParser parseBoolean:animals];
    self.anlageID = [AbstractParser parseInt:anlageID];
    self.bed_rooms = [AbstractParser parseInt:bed_rooms];
    self.city = city;
    self.cityID = [AbstractParser parseInt:cityID];
    self.erbaut = [AbstractParser parseInt:erbaut];
    self.etage = etage;
    //self.exid = exid;
    self.flags = [AbstractParser parseInt:flags];
    self.fromDate = [AbstractParser parseDate:fromDate];
    self.googlemaps_latitude = [AbstractParser parseDecimalNumber:latitude];
    self.googlemaps_longitude = [AbstractParser parseDecimalNumber:longitude];
    self.houseID = [AbstractParser parseInt:houseID];
    self.id_ = [AbstractParser parseInt:id_];
    self.lageID = [AbstractParser parseInt:lageID];
    self.land = land;
    self.living_area = [AbstractParser parseFloat:living_area];
    self.max_persons = [AbstractParser parseInt:max_persons];
    self.mindays = [AbstractParser parseInt:mindays];
    self.name = name;
    self.objnr = objnr;
    self.ortslageID = [AbstractParser parseInt:ortslageID];
    self.persons = [AbstractParser parseInt:persons];
    self.quality = [AbstractParser parseFloat:quality];
    self.region = region;
    self.regionID = [AbstractParser parseInt:regionID];
    self.renoviert = [AbstractParser parseInt:renoviert];
    self.smoking = [AbstractParser parseBoolean:smoking];
    self.street = street;
    self.timestamp = [AbstractParser parseDate:timestamp];
    self.toDate = [AbstractParser parseDate:toDate];
    self.typID = [AbstractParser parseInt:typID];
    self.wohnlageID = [AbstractParser parseInt:wohnlageID];
    self.zipcode = [AbstractParser parseInt:zipcode];
    self.md5hash = DecodeAP16(md5);
    [self removeAttributes:self.attributes]; // remove old attributes
    [self addAttributes:attributes]; // add new attributes;
}


- (NSArray *) OrderedPictures {
    NSArray *unordered = self.pictures.allObjects;
    NSArray *ordered = [unordered sortedArrayUsingFunction:picSort context:NULL];   
    return ordered;
}


- (NSMutableData *) picturesMd5Deep {
    NSMutableData *result = [NSMutableData dataWithLength:16];
    for (ObjPicture *p in self.pictures) XorMd5Hash(result, p.md5hash);
    return result;
}


- (NSMutableData *) textsMd5Deep {
    NSMutableData *result = [NSMutableData dataWithLength:16];
    for (ObjText *t in self.texts) XorMd5Hash(result, t.md5hash);
    return result;
}


- (NSMutableData *) priceInfoMd5Deep {
    NSMutableData *result = [NSMutableData dataWithLength:16];
    for (ObjPriceInfo *pi in self.priceInfo) XorMd5Hash(result, [pi deepMd5Hash]);
    return result;
}


- (NSMutableData *) availabilityInfoMd5Deep {
    NSMutableData *result = [NSMutableData dataWithLength:16];
    for (AvailabilityInfo2 *ai in self.availabilityInfo) XorMd5Hash(result, ai.md5hash);
    return result;
}


- (NSMutableData *) attributesMd5Deep {
    NSMutableData *result = [NSMutableData dataWithLength:16];
    for (ObjAttribute *a in self.attributes) XorMd5Hash(result, a.md5hash);
    return result;
}


- (NSMutableData *) deepMd5Hash {
    NSMutableData *result = [NSMutableData dataWithData: self.md5hash];
    for (AvailabilityInfo2 *a in self.availabilityInfo) XorMd5Hash(result, a.md5hash);
    for (ObjAttribute *a in self.attributes) XorMd5Hash(result, a.md5hash);
    for (ObjPicture *p in self.pictures) XorMd5Hash(result, p.md5hash);
    for (ObjPriceInfo *p in self.priceInfo) XorMd5Hash(result, [p deepMd5Hash]);
    for (ObjText *t in self.texts) XorMd5Hash(result, t.md5hash);
    return result;
}


+ (NSArray *) AllApartments {
    NSManagedObjectContext *context = managedObjectContext();
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:CLASS_ObjInfo2 inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
	[fetchRequest setPredicate:nil];
    NSError *error = nil;
    NSArray *result = [context executeFetchRequest:fetchRequest error:&error];
    [fetchRequest release];
    return result;
}


+ (NSArray *) LocalSearch:(SearchParameters *)sparam {
    
    NSArray *all = [ObjInfo2 AllApartments];

    
    
    NSPredicate *persons = maxPersons(sparam.adults + sparam.children);
    
    NSArray *result = [all filteredArrayUsingPredicate: persons];
    
    return result;
    
}


- (double) FinalCleaningPrice {
    for (ObjPriceInfo *pi in self.priceInfo) {
        for (Price *p in pi.prices) {
            if ([@"ER" compare:p.typ] == NSOrderedSame) {
                return [p.price doubleValue];
            }
        }
    }
    return 0;
}


- (double) LowestPricePerWeek {
    
    double fc = [self FinalCleaningPrice];
    if (0 == fc) return 0;

    NSNumber *lowest;
    
    for (ObjPriceInfo *pi in self.priceInfo) {
        for (Price *p in pi.prices) {
            if ([@"TP" compare:p.typ] == NSOrderedSame && (nil == lowest || [lowest compare:p.price] == NSOrderedDescending)) {
                lowest = p.price;
            }
        }
    }
    
    if (nil == lowest) return 0;
    double result = [lowest doubleValue] * 7 + fc + 19.0;
    return result;
}


@end

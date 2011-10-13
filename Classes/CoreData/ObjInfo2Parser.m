//
//  ApartmentParser.m
//  xmlLoad
//
//  Created by Berndt Reinhold on 05.10.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ObjInfo2Parser.h"
#import "ObjInfo2.h"
#import "ObjAttribute.h"
#import "StringConsts.h"


@implementation ObjInfo2Parser


- (void) closeTag:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName parentName:(NSString *)pName myDict:(NSMutableDictionary *) mDict parentDict:(NSMutableDictionary *) pDict {

    NSMutableSet *mutSet;
    
    if ([NAME_ObjInfo2 compare:elementName] == NSOrderedSame) { //  </ObjInfo2>: create Apartment object
        
        ObjInfo2 *apartment = [NSEntityDescription insertNewObjectForEntityForName:CLASS_ObjInfo2 inManagedObjectContext:context];
        apartment.id_ = [AbstractParser parseInt:[mDict objectForKey:NAME_id]];
        apartment.exid = [mDict objectForKey:NAME_exid];
        apartment.objnr = [mDict objectForKey:NAME_objnr];
        apartment.name = [mDict objectForKey:NAME_name];
        apartment.fromDate = [AbstractParser parseDate:[mDict objectForKey:NAME_fromDate]];
        apartment.toDate = [AbstractParser parseDate:[mDict objectForKey:NAME_toDate]];
        apartment.rooms = [AbstractParser parseInt:[mDict objectForKey:NAME_rooms]];
        apartment.bed_rooms = [AbstractParser parseInt:[mDict objectForKey:NAME_bed_rooms]];
        apartment.living_area = [AbstractParser parseFloat:[mDict objectForKey:NAME_living_area]];
        apartment.persons = [AbstractParser parseInt:[mDict objectForKey:NAME_persons]];
        apartment.max_persons = [AbstractParser parseInt:[mDict objectForKey:NAME_max_persons]];
        apartment.animals = [AbstractParser parseBoolean:[mDict objectForKey:NAME_animals]];
        apartment.smoking = [AbstractParser parseBoolean:[mDict objectForKey:NAME_smoking]];
        apartment.alergic = [AbstractParser parseBoolean:[mDict objectForKey:NAME_alergic]];
        apartment.land = [mDict objectForKey:NAME_land];
        apartment.region = [mDict objectForKey:NAME_region];
        apartment.zipcode = [AbstractParser parseInt:[mDict objectForKey:NAME_zipcode]];
        apartment.city = [mDict objectForKey:NAME_city];
        apartment.street = [mDict objectForKey:NAME_street];
        apartment.etage = [mDict objectForKey:NAME_etage];
        apartment.group = [mDict objectForKey:NAME_group];
        apartment.groupID = [AbstractParser parseInt:[mDict objectForKey:NAME_groupID]];
        apartment.regionID = [AbstractParser parseInt:[mDict objectForKey:NAME_regionID]];
        apartment.cityID = [AbstractParser parseInt:[mDict objectForKey:NAME_cityID]];
        apartment.typID = [AbstractParser parseInt:[mDict objectForKey:NAME_typID]];
        apartment.lageID = [AbstractParser parseInt:[mDict objectForKey:NAME_lageID]];
        apartment.wohnlageID = [AbstractParser parseInt:[mDict objectForKey:NAME_wohnlageID]];
        apartment.ortslageID = [AbstractParser parseInt:[mDict objectForKey:NAME_ortslageID]];
        apartment.houseID = [AbstractParser parseInt:[mDict objectForKey:NAME_houseID]];
        apartment.anlageID = [AbstractParser parseInt:[mDict objectForKey:NAME_anlageID]];
        apartment.mindays = [AbstractParser parseInt:[mDict objectForKey:NAME_mindays]];
        apartment.quality = [AbstractParser parseFloat:[mDict objectForKey:NAME_quality]];
        apartment.erbaut = [AbstractParser parseInt:[mDict objectForKey:NAME_erbaut]];
        apartment.renoviert = [AbstractParser parseInt:[mDict objectForKey:NAME_renoviert]];
        apartment.timestamp = [AbstractParser parseDate:[mDict objectForKey:NAME_timestamp]];
        apartment.flags = [AbstractParser parseInt:[mDict objectForKey:NAME_flags]];
        apartment.googlemaps_latitude = [AbstractParser parseDecimalNumber:[mDict objectForKey:NAME_googlemaps_latitude]];
        apartment.googlemaps_longitude = [AbstractParser parseDecimalNumber:[mDict objectForKey:NAME_googlemaps_longitude]];
        
        NSMutableSet *set = [mDict objectForKey:NAME_AttributeSet];
        if (nil != set) [apartment addAttributes:set];


    } else if ([NAME_googlemaps compare:elementName] == NSOrderedSame) { //  </googlemaps>: propagate googlemaps coordinates to parent node
        NSString *lon = [mDict objectForKey:NAME_longitude];
        if (nil == lon) { NSLog(@"no longitude value"); return; }
        NSString *lat = [mDict objectForKey:NAME_latitude];
        if (nil == lat) { NSLog(@"no latitude value"); return; }
        [pDict setObject:lon forKey:NAME_googlemaps_longitude];
        [pDict setObject:lat forKey:NAME_googlemaps_latitude];
    
        
    } else if ([NAME_ObjAttribute compare:elementName] == NSOrderedSame) { //  </ObjAttribute>: create Attribute node
        NSString *s_id = [mDict objectForKey:NAME_id];
        if (nil == s_id) { NSLog(@"no attribute id"); return; }
        NSString *s_label = [mDict objectForKey:NAME_label];
        if (nil == s_label) { NSLog(@"no attribute label"); return; }
        NSString *s_value = [mDict objectForKey:NAME_value];

        // add ObjAttribute to attributes
        ObjAttribute *a = [NSEntityDescription insertNewObjectForEntityForName:CLASS_ObjAttribute inManagedObjectContext:context];
        a.id_ = [NSNumber numberWithInt:[s_id intValue]];          
        a.label = s_label;
        a.value = (nil == s_value) ? @"" : s_value;
        
        mutSet = [pDict objectForKey:NAME_AttributeSet];
        if (nil == mutSet) {
            mutSet = [NSMutableSet setWithCapacity:16];
            [pDict setObject:mutSet forKey:NAME_AttributeSet];
        }
        [mutSet addObject:a];

    
    } else if ([NAME_attributes compare:elementName] == NSOrderedSame || [NAME_entfernung compare:elementName] == NSOrderedSame) { //  </attributes> | </entfernung>: propagate attribute set to parent node
        mutSet = [mDict objectForKey:NAME_AttributeSet];
        if (nil != mutSet) {
            NSMutableSet *oldSet = [pDict objectForKey:NAME_AttributeSet];
            if (nil != oldSet) [oldSet unionSet:mutSet];
            else [pDict setValue:mutSet forKey:NAME_AttributeSet];
        }
    }
  
}


@end

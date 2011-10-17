//
//  ObjTextParser.m
//  xmlLoad
//
//  Created by Berndt Reinhold on 07.10.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ObjTextParser.h"
#import "ObjText.h"
#import "ObjInfo2.h"
#import "StringConsts.h"
#import "Queries.h"

@implementation ObjTextParser

- (void) closeTag:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName parentName:(NSString *)pName myDict:(NSMutableDictionary *) mDict parentDict:(NSMutableDictionary *) pDict {
    
    if ([CLASS_ObjText compare:elementName] == NSOrderedSame) {
        ObjText *text = [NSEntityDescription insertNewObjectForEntityForName:CLASS_ObjText inManagedObjectContext:context];
        text.key = [mDict objectForKey:NAME_key];
        text.timestamp = [AbstractParser parseDate:[mDict objectForKey:NAME_timestamp]];
        text.text = [mDict objectForKey:NAME_text];
        NSString *exid = [mDict objectForKey:NAME_exid];        
        ObjInfo2 *a = [Queries getApartment:exid context:context];
        if (nil != a) {
            [a addTextsObject:text];
        }
    }
    
}


@end

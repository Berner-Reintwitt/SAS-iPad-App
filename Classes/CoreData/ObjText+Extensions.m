//
//  ObjText+Extensions.m
//  TabBarWithSplitView
//
//  Created by Berndt Reinhold on 10.11.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ObjText+Extensions.h"
#import "StringConsts.h"
#import "AbstractParser.h"
#import "Utils.h"

@implementation ObjText (Extensions)

+ (ObjText *) parseFromXmlNodes:(NSArray *)nodes withContext:(NSManagedObjectContext *)context {
    ObjText *result = nil;
    NSString *exid = nil, *key = nil, *text = nil, *timestamp = nil, *md5 = nil;
    for (NSDictionary *d in nodes) {
        NSString *nodeName = [d objectForKey:XML_NodeName];
        NSString *nodeContent = [d objectForKey:XML_NodeContent];
        if ([nodeName compare:NAME_exid] == NSOrderedSame) exid = nodeContent;
        else if ([nodeName compare:NAME_key] == NSOrderedSame) key = nodeContent;
        else if ([nodeName compare:NAME_text] == NSOrderedSame) text = nodeContent;
        else if ([nodeName compare:NAME_timestamp] == NSOrderedSame) timestamp = nodeContent;
        else if ([nodeName compare:Name_md5] == NSOrderedSame) md5 = nodeContent;
        else NSLog(@"unknown tag %s", [nodeContent UTF8String]);
    }
    if (nil != exid && nil != key && nil != text && nil != timestamp && nil != md5) {
        result = [NSEntityDescription insertNewObjectForEntityForName:CLASS_ObjText inManagedObjectContext:context];
        result.key = key;
        result.timestamp = [AbstractParser parseDate:timestamp];
        result.text = text;
        result.md5hash = DecodeAP16(md5);
    }
    return result;
}

@end

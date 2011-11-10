//
//  ObjAttribute+Extensions.m
//  TabBarWithSplitView
//
//  Created by Berndt Reinhold on 10.11.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ObjAttribute+Extensions.h"
#import "StringConsts.h"
#import "AbstractParser.h"
#import "Utils.h"

@implementation ObjAttribute (Extensions)

+ (ObjAttribute *) parseFromXmlNodes:(NSArray *)nodes withContext:(NSManagedObjectContext *)context {
    ObjAttribute *result = nil;
    NSString *id_ = nil, *label = nil, *value = nil, *md5 = nil;
    for (NSDictionary *d in nodes) {
        NSString *nodeName = [d objectForKey:XML_NodeName];
        NSString *nodeContent = [d objectForKey:XML_NodeContent];
        if ([nodeName compare:NAME_id] == NSOrderedSame) id_ = nodeContent;
        else if ([nodeName compare:NAME_label] == NSOrderedSame) label = nodeContent;
        else if ([nodeName compare:NAME_value] == NSOrderedSame) value = nodeContent;
        else if ([nodeName compare:Name_md5] == NSOrderedSame) md5 = nodeContent;
        else NSLog(@"unknown tag %s", [nodeContent UTF8String]);
    }
    if (!(nil != id_ && nil != label && nil != value && nil != md5)) {
        NSLog(@"ObjAttribute import: missing tag");
        return nil;
    }
    result = [NSEntityDescription insertNewObjectForEntityForName:CLASS_ObjAttribute inManagedObjectContext:context];
    result.label = label;
    result.id_ = [AbstractParser parseInt:id_];
    result.value = value;
    result.md5hash = DecodeAP16(md5);
    return result;
}

@end

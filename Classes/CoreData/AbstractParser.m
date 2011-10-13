//
//  AbstractParser.m
//  xmlLoad
//
//  Created by Berndt Reinhold on 07.10.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "AbstractParser.h"

@implementation AbstractParser


+ (NSNumber *)parseInt:(NSString *)text { return [NSNumber numberWithInt:[text intValue]]; }
+ (NSNumber *)parseFloat:(NSString *)text { return [NSNumber numberWithFloat:[text floatValue]]; }
+ (NSDecimalNumber *)parseDecimalNumber:(NSString *)text { return [NSDecimalNumber decimalNumberWithString:text]; }
+ (NSDate *)parseDate:(NSString *)text {
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss"];
    NSString *s = [text stringByReplacingOccurrencesOfString:@" " withString:@"T"];
    NSDate *date = [dateFormatter dateFromString:s];
    [s release];
    [dateFormatter release];
    //NSLog(@"%s -> %s", [text UTF8String], [[dateFormatter stringFromDate:date] UTF8String]);
    return date;
}


+ (NSNumber *)parseBoolean:(NSString *)text { return [NSNumber numberWithBool: [@"true" compare:text] == NSOrderedSame]; }

- (id)initWithContext:(NSManagedObjectContext *)ctx {
    context = ctx;
    return self;
}





- (void) closeTag:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName parentName:(NSString *)pName myDict:(NSMutableDictionary *) mDict parentDict:(NSMutableDictionary *) pDict {
    @throw [NSException exceptionWithName:NSInternalInconsistencyException reason:[NSString stringWithFormat:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)] userInfo:nil];
}





- (void) parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
    //NSLog(@"didStartElement: %s", [elementName UTF8String]);
    [elementStack addObject:elementName];
    [dictionaryStack addObject:[NSMutableDictionary dictionary]];
}





- (void) parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    //NSLog(@"didEndElement: %s", [elementName UTF8String]);    
    
    NSString *lastElement = elementStack.lastObject;
    if ([elementName compare:lastElement] != NSOrderedSame) {
        NSLog(@"unmatched closing tag </%s> (<%s>)", [elementName UTF8String], [lastElement UTF8String]);
        exit(1);
    }
    [elementStack removeLastObject];
    NSString *parentElement = [elementStack lastObject];
    
    NSMutableDictionary *myDict = [dictionaryStack lastObject];
    [dictionaryStack removeLastObject];
    NSMutableDictionary *parentDict = [dictionaryStack lastObject];
    
    [self closeTag:elementName namespaceURI:namespaceURI qualifiedName:qName parentName:parentElement myDict:myDict parentDict:parentDict];
    
}





- (void) parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    NSString *elementName = elementStack.lastObject;
    NSMutableDictionary *parentDict = [dictionaryStack objectAtIndex:dictionaryStack.count - 2];
    NSString *value = [parentDict objectForKey:elementName];
    value = (nil == value) ? string : [value stringByAppendingString:string];
    [parentDict setObject:value forKey:elementName];
}





- (void) parserDidStartDocument:(NSXMLParser *)parser {
    
    if (nil != elementStack) {
        [elementStack dealloc];
    }
    elementStack = [NSMutableArray arrayWithCapacity:16];
    [elementStack addObject:@"<ROOT>"];
    
    
    if (nil != dictionaryStack) {
        [dictionaryStack dealloc];
    }
    dictionaryStack = [NSMutableArray arrayWithCapacity:16];
    [dictionaryStack addObject:[NSMutableDictionary dictionary]];
    
}





- (void) parserDidEndDocument:(NSXMLParser *)parser {
    [elementStack dealloc];
    elementStack = nil;
    [dictionaryStack dealloc];
    dictionaryStack = nil;
}





@end

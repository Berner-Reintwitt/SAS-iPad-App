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
    NSString *s = [NSString stringWithString: text];
    s = [s stringByReplacingOccurrencesOfString:@" " withString:@"T"];
    NSDate *date = [dateFormatter dateFromString:s];
    [dateFormatter release];
    return date;
}
+ (NSNumber *)parseBoolean:(NSString *)text { return [NSNumber numberWithBool: [@"true" compare:text] == NSOrderedSame]; }
+ (NSMutableData *)parseBase16:(NSString *)base16 {
	NSAssert(nil != base16 && base16.length == 32, @"argument exception");
	NSMutableData *result = [NSMutableData dataWithCapacity:16];
	Byte *buffer = [result mutableBytes];
	for (int i = 15; i >= 0; --i) {
		buffer[i] = (Byte) (
			((([base16 characterAtIndex:i * 2] - 'A') & 0xf) << 4) |
			(([base16 characterAtIndex:i * 2 + 1] - 'A') & 0xf)
		);
	}
	return result;
}


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
    
    [myDict removeAllObjects];
    //[myDict release];
    //[lastElement release];
    
}

- (void) parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    NSString *elementName = elementStack.lastObject;
    NSMutableDictionary *parentDict = [dictionaryStack objectAtIndex:dictionaryStack.count - 2];
    NSString *value = [parentDict objectForKey:elementName];
    NSString *newValue;
    if (nil == value) {
        newValue = string;
    } else {
        newValue = [value stringByAppendingString:string];
    }
    [parentDict setObject:newValue forKey:elementName];
}

- (void) parserDidStartDocument:(NSXMLParser *)parser {
    elementStack = [NSMutableArray arrayWithCapacity:16];
    [elementStack addObject:@"<ROOT>"];
    dictionaryStack = [NSMutableArray arrayWithCapacity:16];
    [dictionaryStack addObject:[NSMutableDictionary dictionary]];
    
}

- (void) parserDidEndDocument:(NSXMLParser *)parser {

    NSInteger n = elementStack.count;
    if (n > 1) {
        NSLog(@"elements left on stack");
    }
    [elementStack removeAllObjects];
    [dictionaryStack removeAllObjects];
}

@end

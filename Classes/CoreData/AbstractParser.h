//
//  AbstractParser.h
//  xmlLoad
//
//  Created by Berndt Reinhold on 07.10.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AbstractParser : NSObject<NSXMLParserDelegate> {
    NSMutableArray *elementStack;
    NSMutableArray *dictionaryStack;
    NSManagedObjectContext *context;
}

+ (NSNumber *)parseInt:(NSString *)text;

+ (NSNumber *)parseFloat:(NSString *)text;

+ (NSDecimalNumber *)parseDecimalNumber:(NSString *)text;

+ (NSDate *)parseDate:(NSString *)text;

+ (NSNumber *)parseBoolean:(NSString *)text;


- (id) initWithContext:(NSManagedObjectContext *)ctx;

- (void) parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict;

- (void) parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName;

- (void) parser:(NSXMLParser *)parser foundCharacters:(NSString *)string;

- (void) parserDidStartDocument:(NSXMLParser *)parser;

- (void) parserDidEndDocument:(NSXMLParser *)parser;


- (void) closeTag:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName parentName:(NSString *)pName myDict:(NSMutableDictionary *) mDict parentDict:(NSMutableDictionary *) pDict;


@end

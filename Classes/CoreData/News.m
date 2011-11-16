//
//  News.m
//  TabBarWithSplitView
//
//  Created by Berndt Reinhold on 11.11.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "News.h"
#import "Utils.h"
#import "XPathQuery.h"
#import "StringConsts.h"

@implementation News

@synthesize Title, Url, Categories, PubDate, Guid, Content;


+ (NSArray *) ReadNews {
    NSMutableArray *result = [NSMutableArray arrayWithCapacity:16];
    NSString *RssFeedUrl = @"http://news.sas-sylt.de/?feed=rss2";
    NSData *feedData = httpGet(RssFeedUrl);
    NSArray *root = PerformXMLXPathQuery(feedData, @"/rss/channel/item");
    
    for (NSDictionary *d in root) {
        News *news = [[News alloc] init];
        NSMutableArray *categories = [NSMutableArray arrayWithCapacity:8];
        NSArray *childNodes = [d objectForKey:XML_NodeChildNodes];
        for (NSDictionary *c in childNodes) {
            NSString *nodeName = [c objectForKey:XML_NodeName];
            NSString *nodeContent = [c objectForKey:XML_NodeContent];
            if ([nodeName compare:@"title"] == NSOrderedSame) {
                news.Title = nodeContent;
            } else if ([nodeName compare:@"link"] == NSOrderedSame) {
                news.Url = nodeContent;
            } else if ([nodeName compare:@"category"] == NSOrderedSame) {
                [categories addObject:nodeContent]; 
            } else if ([nodeName compare:@"guid"] == NSOrderedSame) {
                news.Guid = nodeContent;
            } else if ([nodeName compare:@"content"] == NSOrderedSame) {
                news.Content = nodeContent;
            } else if ([nodeName compare:@"pubDate"] == NSOrderedSame) {
                news.PubDate = nodeContent;
            }
        }
        news.Categories = categories;
        [result addObject:news];
    }
    
    return result;
}

@end

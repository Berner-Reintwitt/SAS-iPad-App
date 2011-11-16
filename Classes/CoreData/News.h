//
//  News.h
//  TabBarWithSplitView
//
//  Created by Berndt Reinhold on 11.11.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface News : NSObject {
    NSString *Title;
    NSString *Url;
    NSString *PubDate;
    NSArray *Categories;
    NSString *Guid;
    NSString *Content;
}

@property (nonatomic, retain) NSString *Title;
@property (nonatomic, retain) NSString *Url;
@property (nonatomic, retain) NSString *PubDate;
@property (nonatomic, retain) NSArray *Categories;
@property (nonatomic, retain) NSString *Guid;
@property (nonatomic, retain) NSString *Content;

+ (NSArray *) ReadNews;


@end

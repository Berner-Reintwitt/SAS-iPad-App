//
//  KeyValueData.h
//  TabBarWithSplitView
//
//  Created by Berndt Reinhold on 08.11.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface KeyValueData : NSManagedObject

@property (nonatomic, retain) NSString * key;
@property (nonatomic, retain) NSData * value;

@end

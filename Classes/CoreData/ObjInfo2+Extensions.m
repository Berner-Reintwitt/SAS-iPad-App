//
//  ObjInfo2+ObjInfo2Extensions.m
//  TabBarWithSplitView
//
//  Created by Berndt Reinhold on 20.10.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ObjInfo2+Extensions.h"
#import "ObjPicture.h"
#import "Utils.h"
#import "StringConsts.h"


static NSInteger picSort(id pic1, id pic2, void *context) {
    int v1 = [((ObjPicture *) pic1).serial intValue];
    int v2 = [((ObjPicture *) pic2).serial intValue];
    return v1 < v2 ? NSOrderedAscending : v1 > v2 ? NSOrderedDescending : NSOrderedSame;
}

@implementation ObjInfo2 (Extensions)

- (NSArray *) OrderedPictures {
    NSArray *unordered = self.pictures.allObjects;
    NSArray *ordered = [unordered sortedArrayUsingFunction:picSort context:NULL];   
    return ordered;
}


+ (NSArray *) AllApartments {
    NSManagedObjectContext *context = managedObjectContext();
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:CLASS_ObjInfo2 inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
	[fetchRequest setPredicate:nil];
    NSError *error = nil;
    NSArray *result = [context executeFetchRequest:fetchRequest error:&error];
    [fetchRequest release];
    return result;
}

+ (NSArray *) LocalSearch:(SearchParameters *)sparam {
    
    NSArray *all = [ObjInfo2 AllApartments];
    /*
    NSExpression *lhs = [NSExpression expressionForKeyPath:NAME_max_persons];
    NSExpression *gtPersons = [NSExpression expressionForConstantValue:[NSNumber numberWithInt: sparam.adults + sparam.children]];
    NSPredicate *gtPersonsPred = [NSComparisonPredicate
                                  predicateWithLeftExpression:lhs
                                  rightExpression:gtPersons
                                  modifier:NSDirectPredicateModifier
                                  type:NSGreaterThanPredicateOperatorType
                                  options:0];
    */
    NSPredicate *pred = [NSPredicate
                         predicateWithFormat:@"(max_persons >= %@)"
                         arguments:[NSNumber numberWithInt:sparam.adults + sparam.children]
                         ];
    
    
    NSArray *result = [all filteredArrayUsingPredicate: pred];
    
    return result;
    
}



@end

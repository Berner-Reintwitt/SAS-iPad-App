//
//  EventRootViewController.h
//  TabBarWithSplitView
//
//  Created by Johannes Böhler on 04.10.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EnhancedSplitViewController.h"
#import "MonatEventDetailView.h"
#import "DomizileFirstDetailViewController.h"
NSUInteger row;


@interface EventRootViewController : UITableViewController <UISplitViewControllerDelegate>{
    
    MonatEventDetailView *firstMonthDetailViewController;
    DomizileFirstDetailViewController *secondMonthDetailViewController;
    NSArray *array1;
    EnhancedSplitViewController *splitViewController;
}

@property (nonatomic, retain) IBOutlet  MonatEventDetailView *firstMonthDetailViewController;
@property (nonatomic, retain) IBOutlet  DomizileFirstDetailViewController *secondMonthDetailViewController;
@property (nonatomic, retain) IBOutlet NSArray *array1;
@property (nonatomic, assign) IBOutlet EnhancedSplitViewController *splitViewController;

@end

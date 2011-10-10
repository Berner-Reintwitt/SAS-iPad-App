//
//  ShuttleServiceRootViewController.h
//  TabBarWithSplitView
//
//  Created by Johannes Böhler on 27.09.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShuttleServiceDetailViewControllerMaserati.h"
#import "EnhancedSplitViewController.h"
#import "ShuttleServiceDetailViewControllerAstonMartin.h"

@interface ShuttleServiceRootViewController : UITableViewController <UISplitViewControllerDelegate>{
    
    ShuttleServiceDetailViewControllerMaserati *firstDetailViewController;
    NSArray *array1;
    EnhancedSplitViewController *splitViewController;
}


@property (nonatomic, retain) IBOutlet NSArray *array1;
@property (nonatomic, assign) IBOutlet EnhancedSplitViewController *splitViewController;
@property (nonatomic, retain) ShuttleServiceDetailViewControllerMaserati *firstDetailViewController;

@end

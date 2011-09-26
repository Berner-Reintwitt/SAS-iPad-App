//
//  RootViewController.h
//  SplitView
//
//  Created by Bart Bruijnesteijn on 3/23/11.
//  Copyright 2011 PiecesOfMyMind Software. All rights reserved.
//





#import <UIKit/UIKit.h>
#import "EnhancedSplitViewController.h"
#import "SecondDetailViewController.h"
@class FirstDetailViewController;


@protocol SubstitutableDetailViewController
- (void)showRootPopoverButtonItem:(UIBarButtonItem *)barButtonItem;
- (void)invalidateRootPopoverButtonItem:(UIBarButtonItem *)barButtonItem;
@end

@interface RootViewController : UITableViewController <UISplitViewControllerDelegate>{
   // UISplitViewController *splitViewController;
    FirstDetailViewController *firstDetailViewController;
    NSArray *array1;
    EnhancedSplitViewController *splitViewController;
}

@property (nonatomic, retain) IBOutlet FirstDetailViewController *firstDetailViewController;
@property (nonatomic, retain) IBOutlet NSArray *array1;
@property (nonatomic, assign) IBOutlet EnhancedSplitViewController *splitViewController;

@end

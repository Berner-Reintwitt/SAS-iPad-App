//
//  RootViewController.h
//  SplitView
//
//  Created by Bart Bruijnesteijn on 3/23/11.
//  Copyright 2011 PiecesOfMyMind Software. All rights reserved.
//





#import <UIKit/UIKit.h>
#import "EnhancedSplitViewController.h"
#import "DomizileSecondDetailViewController.h"
#import "DomizileThirdDetailViewController.h"
#import "DomizileFourthDetailViewController.h"
@class DomizileFirstDetailViewController;


@protocol SubstitutableDetailViewController
- (void)showRootPopoverButtonItem:(UIBarButtonItem *)barButtonItem;
- (void)invalidateRootPopoverButtonItem:(UIBarButtonItem *)barButtonItem;
@end

@interface DomizileRootViewController : UITableViewController <UISplitViewControllerDelegate>{
    DomizileFirstDetailViewController *firstDetailViewController;
    NSArray *array1;
    EnhancedSplitViewController *splitViewController;
}

@property (nonatomic, retain) IBOutlet DomizileFirstDetailViewController *firstDetailViewController;
@property (nonatomic, retain) IBOutlet NSArray *array1;
@property (nonatomic, assign) IBOutlet EnhancedSplitViewController *splitViewController;

@end

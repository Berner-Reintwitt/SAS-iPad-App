//
//  NewsRootViewController.h
//  TabBarWithSplitView
//
//  Created by Johannes Böhler on 04.10.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "EnhancedSplitViewController.h"
#import "NewsDetailView.h"



@interface NewsRootViewController : UITableViewController <UISplitViewControllerDelegate>{
       NSArray *array1;
    EnhancedSplitViewController *splitViewController;
    NewsDetailView *newsDetailView;
}

@property (nonatomic, retain) IBOutlet NewsDetailView *newsDetailView;
@property (nonatomic, retain) IBOutlet NSArray *array1;
@property (nonatomic, assign) IBOutlet EnhancedSplitViewController *splitViewController;

@end

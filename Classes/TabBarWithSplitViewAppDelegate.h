//
//  TabBarWithSplitViewAppDelegate.h
//  TabBarWithSplitView
//
//  Created by Bart Bruijnesteijn on 3/23/11.
//  Copyright 2011 PiecesOfMyMind Software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

#import "ShuttleServiceDetailViewControllerMaserati.h"
#import "ShuttleServiceRootViewController.h"
#import "DomizileRootViewController.h"
#import "DomizileFirstDetailViewController.h"
#import "EnhancedSplitViewController.h"
#import "MonatEventDetailView.h"
#import "EventRootViewController.h"
#import "NewsDetailView.h"
#import "NewsRootViewController.h"
#import "SearchParameters.h"
#import "TabBarSubclass.h"

NSString *date1;
UINavigationController *navigationControllerModalViews;




@class EnhancedSplitViewController;
@class DomizileRootViewController;
@class DomizileFirstDetailViewController;




@interface TabBarWithSplitViewAppDelegate : UIResponder <UIApplicationDelegate, UITabBarControllerDelegate,UINavigationBarDelegate> {
    UIWindow *window;
    TabBarSubclass *tabBarController;
    NewsRootViewController *newsRootViewController;
    NewsDetailView *newsDetailView;
    EnhancedSplitViewController *splitViewControllerDomizile;
    EnhancedSplitViewController *splitViewControllerShuttleService;
    EnhancedSplitViewController *splitViewControllerEvents;
    EnhancedSplitViewController *splitViewControllerNews;
    ShuttleServiceRootViewController *shuttleServiceRootViewController;
    ShuttleServiceDetailViewControllerMaserati *shuttleServiceDetailViewControllerMaserati;
    MonatEventDetailView *firstMonthDetailViewController;
    EventRootViewController *eventRootViewController;
    DomizileFirstDetailViewController *firstDetailViewController;
    DomizileRootViewController *domizileRootViewController;
    NSMutableArray *controllers;
    
    
    
        
}

@property (nonatomic, retain) IBOutlet EnhancedSplitViewController *splitViewControllerNews;
@property (nonatomic, retain) IBOutlet NewsRootViewController *newsRootViewController;
@property (nonatomic, retain) IBOutlet NewsDetailView *newsDetailView;
@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet TabBarSubclass *tabBarController;
@property (nonatomic, retain) IBOutlet EnhancedSplitViewController *splitViewControllerDomizile;
@property (nonatomic, retain) IBOutlet EnhancedSplitViewController *splitViewControllerShuttleService;
@property (nonatomic, retain) IBOutlet EnhancedSplitViewController *splitViewControllerEvents;
@property (nonatomic, retain) IBOutlet DomizileRootViewController *domizileRootViewController;
@property (nonatomic, retain) IBOutlet DomizileFirstDetailViewController *firstDetailViewController;
@property (nonatomic, retain) IBOutlet ShuttleServiceRootViewController *shuttleServiceRootViewController;
@property (nonatomic, retain) IBOutlet ShuttleServiceDetailViewControllerMaserati *shuttleServiceDetailViewControllerMaserati;
@property (nonatomic, retain) IBOutlet MonatEventDetailView *firstMonthDetailViewController;
@property (nonatomic, retain) UINavigationController *navigationControllerModalViews;
@property NSInteger whichTablePopUpView;
@property (nonatomic, retain) NSMutableArray *controllers;
-(BOOL)transferDb;


@end

//
//  TabBarWithSplitViewAppDelegate.h
//  TabBarWithSplitView
//
//  Created by Bart Bruijnesteijn on 3/23/11.
//  Copyright 2011 PiecesOfMyMind Software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShuttleServiceDetailViewControllerMaserati.h"
#import "ShuttleServiceRootViewController.h"

@class EnhancedSplitViewController;
@class DomizileRootViewController;
@class DomizileFirstDetailViewController;



@interface TabBarWithSplitViewAppDelegate : NSObject <UIApplicationDelegate, UITabBarControllerDelegate> {
    UIWindow *window;
    UITabBarController *tabBarController;

    EnhancedSplitViewController *splitViewControllerDomizile;
    EnhancedSplitViewController *splitViewControllerShuttleService;
    DomizileRootViewController *rootViewController;
    DomizileFirstDetailViewController *firstDetailViewController;
    ShuttleServiceRootViewController *shuttleServiceRootViewController;
    ShuttleServiceDetailViewControllerMaserati *shuttleServiceDetailViewControllerMaserati;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UITabBarController *tabBarController;
@property (nonatomic, retain) IBOutlet EnhancedSplitViewController *splitViewControllerDomizile;
@property (nonatomic, retain) IBOutlet EnhancedSplitViewController *splitViewControllerShuttleService;
@property (nonatomic, retain) IBOutlet DomizileRootViewController *rootViewController;
@property (nonatomic, retain) IBOutlet DomizileFirstDetailViewController *firstDetailViewController;
@property (nonatomic, retain) IBOutlet ShuttleServiceRootViewController *shuttleServiceRootViewController;
@property (nonatomic, retain) IBOutlet ShuttleServiceDetailViewControllerMaserati *shuttleServiceDetailViewControllerMaserati;
@end

//
//  TabBarWithSplitViewAppDelegate.h
//  TabBarWithSplitView
//
//  Created by Bart Bruijnesteijn on 3/23/11.
//  Copyright 2011 PiecesOfMyMind Software. All rights reserved.
//

#import <UIKit/UIKit.h>

@class EnhancedSplitViewController;
@class DomizileRootViewController;
@class FirstDetailViewController;


@interface TabBarWithSplitViewAppDelegate : NSObject <UIApplicationDelegate, UITabBarControllerDelegate> {
    UIWindow *window;
    UITabBarController *tabBarController;

    EnhancedSplitViewController *splitViewController;
    DomizileRootViewController *rootViewController;
    FirstDetailViewController *firstDetailViewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UITabBarController *tabBarController;
@property (nonatomic, retain) IBOutlet EnhancedSplitViewController *splitViewController;
@property (nonatomic, retain) IBOutlet DomizileRootViewController *rootViewController;
@property (nonatomic, retain) IBOutlet FirstDetailViewController *firstDetailViewController;

@end

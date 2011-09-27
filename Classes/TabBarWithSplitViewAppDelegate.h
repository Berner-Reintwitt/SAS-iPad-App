//
//  TabBarWithSplitViewAppDelegate.h
//  TabBarWithSplitView
//
//  Created by Bart Bruijnesteijn on 3/23/11.
//  Copyright 2011 PiecesOfMyMind Software. All rights reserved.
//

#import <UIKit/UIKit.h>

@class EnhancedSplitViewController;
<<<<<<< HEAD
@class DomizileRootViewController;
=======
@class RootViewController;
>>>>>>> 80e8fdcbca094ca3a384ab588ab9e5746df64d92
@class FirstDetailViewController;


@interface TabBarWithSplitViewAppDelegate : NSObject <UIApplicationDelegate, UITabBarControllerDelegate> {
    UIWindow *window;
    UITabBarController *tabBarController;

    EnhancedSplitViewController *splitViewController;
<<<<<<< HEAD
    DomizileRootViewController *rootViewController;
=======
    RootViewController *rootViewController;
>>>>>>> 80e8fdcbca094ca3a384ab588ab9e5746df64d92
    FirstDetailViewController *firstDetailViewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UITabBarController *tabBarController;
@property (nonatomic, retain) IBOutlet EnhancedSplitViewController *splitViewController;
<<<<<<< HEAD
@property (nonatomic, retain) IBOutlet DomizileRootViewController *rootViewController;
=======
@property (nonatomic, retain) IBOutlet RootViewController *rootViewController;
>>>>>>> 80e8fdcbca094ca3a384ab588ab9e5746df64d92
@property (nonatomic, retain) IBOutlet FirstDetailViewController *firstDetailViewController;

@end

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
#import "DomizileRootViewController.h"
#import "DomizileFirstDetailViewController.h"
#import "EnhancedSplitViewController.h"
#import "MonatEventDetailView.h"
#import "EventRootViewController.h"
#import "NewsDetailView.h"
#import "NewsRootViewController.h"

@class EnhancedSplitViewController;
@class DomizileRootViewController;
@class DomizileFirstDetailViewController;




@interface TabBarWithSplitViewAppDelegate : UIResponder <UIApplicationDelegate, UITabBarControllerDelegate> {
    UIWindow *window;
    UITabBarController *tabBarController;
    NewsRootViewController *newsRootViewController;
    NewsDetailView *newsDetailView;
    EnhancedSplitViewController *splitViewControllerDomizile;
    EnhancedSplitViewController *splitViewControllerShuttleService;
    EnhancedSplitViewController *splitViewControllerEvents;
    EnhancedSplitViewController *splitViewControllerNews;
    DomizileRootViewController *rootViewController;
    DomizileFirstDetailViewController *firstDetailViewController;
    ShuttleServiceRootViewController *shuttleServiceRootViewController;
    ShuttleServiceDetailViewControllerMaserati *shuttleServiceDetailViewControllerMaserati;
    MonatEventDetailView *firstMonthDetailViewController;
    EventRootViewController *eventRootViewController;
}
@property (nonatomic, retain) IBOutlet EnhancedSplitViewController *splitViewControllerNews;
@property (nonatomic, retain) IBOutlet NewsRootViewController *newsRootViewController;
@property (nonatomic, retain) IBOutlet NewsDetailView *newsDetailView;
@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UITabBarController *tabBarController;
@property (nonatomic, retain) IBOutlet EnhancedSplitViewController *splitViewControllerDomizile;
@property (nonatomic, retain) IBOutlet EnhancedSplitViewController *splitViewControllerShuttleService;
@property (nonatomic, retain) IBOutlet  EnhancedSplitViewController *splitViewControllerEvents;
@property (nonatomic, retain) IBOutlet DomizileRootViewController *rootViewController;
@property (nonatomic, retain) IBOutlet DomizileFirstDetailViewController *firstDetailViewController;
@property (nonatomic, retain) IBOutlet ShuttleServiceRootViewController *shuttleServiceRootViewController;
@property (nonatomic, retain) IBOutlet ShuttleServiceDetailViewControllerMaserati *shuttleServiceDetailViewControllerMaserati;
@property (nonatomic, retain) IBOutlet MonatEventDetailView *firstMonthDetailViewController;
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end

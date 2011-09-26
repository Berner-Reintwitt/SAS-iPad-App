//
//  TabBarWithSplitViewAppDelegate.m
//  TabBarWithSplitView
//
//  Created by Bart Bruijnesteijn on 3/23/11.
//  Copyright 2011 PiecesOfMyMind Software. All rights reserved.
//

#import "TabBarWithSplitViewAppDelegate.h"
#import "RootViewController.h"
#import "FirstDetailViewController.h"
#import "EnhancedSplitViewController.h"

@implementation TabBarWithSplitViewAppDelegate

@synthesize window;
@synthesize tabBarController;
@synthesize splitViewController;
@synthesize rootViewController;
@synthesize firstDetailViewController;


#pragma mark -
#pragma mark Application lifecycle

-(void) makeSplitViewController {
    NSMutableArray *controllers = [NSMutableArray arrayWithArray:tabBarController.viewControllers];
    
    int index = 0; 
    
    for (UIViewController *controller in tabBarController.viewControllers) {
        if (index == 2) {
            firstDetailViewController = [[FirstDetailViewController alloc] initWithNibName:@"FirstDetailViewController" bundle:nil];
            rootViewController = [[RootViewController alloc] initWithStyle:UITableViewStylePlain];
            rootViewController.firstDetailViewController = firstDetailViewController;
            rootViewController.navigationItem.title = @"List";
            UINavigationController *nav = [[[UINavigationController alloc] initWithRootViewController:rootViewController] autorelease];
            
            splitViewController = [[EnhancedSplitViewController alloc] init];
            splitViewController.tabBarItem = controller.tabBarItem;
            splitViewController.viewControllers = [NSArray arrayWithObjects:nav, firstDetailViewController, nil];
            splitViewController.delegate = firstDetailViewController;
            splitViewController.barButton = firstDetailViewController.barButton;
            splitViewController.pc  =firstDetailViewController.popoverController;
            [controllers replaceObjectAtIndex:index withObject:splitViewController];
        }
        index++;
    }
    
    tabBarController.delegate = self;
    tabBarController.viewControllers = controllers;
}

- (BOOL)isPortrait {
  //  UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
    return NO;
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
    if ([self isPortrait]) {
        if (viewController != splitViewController) {
            [firstDetailViewController removeBarButtonItem];
        }
        else {
            [firstDetailViewController addBarButtonItem:firstDetailViewController.barButton forPopoverController:firstDetailViewController.popoverController];
        }
    }
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    
    // Override point for customization after app launch.
    [self makeSplitViewController];
    
	// Set the tab bar controller as the window's root view controller and display.
    self.window.rootViewController = self.tabBarController;
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive.
     */
}


- (void)applicationWillTerminate:(UIApplication *)application {
    /*
     Called when the application is about to terminate.
     */
}


#pragma mark -
#pragma mark UITabBarControllerDelegate methods

/*
 // Optional UITabBarControllerDelegate method
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
}
 */

/*
 // Optional UITabBarControllerDelegate method
- (void)tabBarController:(UITabBarController *)tabBarController didEndCustomizingViewControllers:(NSArray *)viewControllers changed:(BOOL)changed {
}
 */

#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    /*
     Free up as much memory as possible by purging cached data objects that can be recreated (or reloaded from disk) later.
     */
}


- (void)dealloc {
    [splitViewController release];
    [rootViewController release];
    [firstDetailViewController release];
    
    [tabBarController release];
    [window release];
	
    [super dealloc];
}

@end


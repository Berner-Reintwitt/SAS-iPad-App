//
//  TabBarWithSplitViewAppDelegate.m
//  TabBarWithSplitView
//
//  Created by Bart Bruijnesteijn on 3/23/11.
//  Copyright 2011 PiecesOfMyMind Software. All rights reserved.
//

#import "TabBarWithSplitViewAppDelegate.h"
#import "DomizileRootViewController.h"
#import "DomizileFirstDetailViewController.h"
#import "EnhancedSplitViewController.h"

@implementation TabBarWithSplitViewAppDelegate

@synthesize window;
@synthesize tabBarController;
@synthesize splitViewControllerDomizile;
@synthesize rootViewController;
@synthesize firstDetailViewController;
@synthesize shuttleServiceDetailViewControllerMaserati;
@synthesize splitViewControllerShuttleService;
@synthesize shuttleServiceRootViewController;


#pragma mark -
#pragma mark Application lifecycle

-(void) makeSplitViewController {
    NSMutableArray *controllers = [NSMutableArray arrayWithArray:tabBarController.viewControllers];
    
    int index = 0; 
    
    for (UIViewController *controller in tabBarController.viewControllers) {
        if (index == 1) {
            firstDetailViewController = [[DomizileFirstDetailViewController alloc] initWithNibName:@"FirstDetailViewController" bundle:nil];
            
            
            
            rootViewController = [[DomizileRootViewController alloc] initWithStyle:UITableViewStylePlain];
            rootViewController.firstDetailViewController = firstDetailViewController;
            rootViewController.navigationItem.title = @"List";
            
            
            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:rootViewController] ;
            
            
            splitViewControllerDomizile = [[EnhancedSplitViewController alloc] init];
            
            //setzt als TabbarItem des SplitViewControllers das tab abr item des xib Files 
            splitViewControllerDomizile.tabBarItem = controller.tabBarItem;
            
            //schickt DetailView samt NavigationController an den SPlitviewController
            splitViewControllerDomizile.viewControllers = [NSArray arrayWithObjects:nav, firstDetailViewController, nil];
            
            //firstDetailViewController ist die Delegate des SlitViewControllers und erhält dessen Nachrichten
            splitViewControllerDomizile.delegate = firstDetailViewController;
            splitViewControllerDomizile.barButton = firstDetailViewController.barButton;
            splitViewControllerDomizile.pc  =firstDetailViewController.popoverController;
            
            
            //der Controller welcher bisher in der Tabbar registriert ist wird überschrieben
            
            [controllers replaceObjectAtIndex:index withObject:splitViewControllerDomizile];
        }
        
        
        
        
        else if (index == 3) {
            shuttleServiceDetailViewControllerMaserati = [[ShuttleServiceDetailViewControllerMaserati alloc] initWithNibName:@"ShuttleServiceDetailViewControllerMaserati" bundle:nil];
            
            
            
            shuttleServiceRootViewController = [[ShuttleServiceRootViewController alloc] initWithStyle:UITableViewStylePlain];
            shuttleServiceRootViewController.firstDetailViewController = shuttleServiceDetailViewControllerMaserati;
            shuttleServiceRootViewController.navigationItem.title = @"ShuttleService";
            
            
            UINavigationController *nav = [[[UINavigationController alloc] initWithRootViewController:shuttleServiceRootViewController] autorelease];
            
            
            splitViewControllerShuttleService = [[EnhancedSplitViewController alloc] init];
            
            //setzt als TabbarItem des SplitViewControllers das tab abr item des xib Files 
             splitViewControllerShuttleService.tabBarItem = controller.tabBarItem;
            
            //schickt DetailView samt NavigationController an den SPlitviewController
            splitViewControllerShuttleService.viewControllers = [NSArray arrayWithObjects:nav, shuttleServiceDetailViewControllerMaserati, nil];
            
            //firstDetailViewController ist die Delegate des SlitViewControllers und erhält dessen Nachrichten
            splitViewControllerShuttleService.delegate = shuttleServiceDetailViewControllerMaserati;
          
            //  splitViewControllerShuttleService.barButton = shuttleServiceDetailViewControllerMaserati.barButton;
           // splitViewControllerShuttleService.pc  =shuttleServiceDetailViewControllerMaserati.popoverController;
            
            
            //der Controller welcher bisher in der Tabbar registriert ist wird überschrieben
            
            [controllers replaceObjectAtIndex:index withObject:splitViewControllerShuttleService];
        }

        index++;
        NSLog(@"%d",index);
    }
    
    tabBarController.delegate = self;
    tabBarController.viewControllers = controllers;
}

- (BOOL)isPortrait {
   // UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
    return NO;
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
       
   /* if ([self isPortrait]) {
        if (viewController != splitViewController) {
            [firstDetailViewController removeBarButtonItem];
        }
        else {
            [firstDetailViewController addBarButtonItem:firstDetailViewController.barButton forPopoverController:firstDetailViewController.popoverController];
        }
    }*/
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
    [splitViewControllerDomizile release];
    [rootViewController release];
    [firstDetailViewController release];
    
    [tabBarController release];
    [window release];
	
    [super dealloc];
}

@end


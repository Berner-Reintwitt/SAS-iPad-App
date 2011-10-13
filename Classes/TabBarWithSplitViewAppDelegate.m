//
//  TabBarWithSplitViewAppDelegate.m
//  TabBarWithSplitView
//
//  Created by Bart Bruijnesteijn on 3/23/11.
//  Copyright 2011 PiecesOfMyMind Software. All rights reserved.
//

#import "TabBarWithSplitViewAppDelegate.h"



@implementation TabBarWithSplitViewAppDelegate

@synthesize window;
@synthesize tabBarController;
@synthesize splitViewControllerDomizile;
@synthesize domizileRootViewController;
@synthesize firstDetailViewController;
@synthesize shuttleServiceDetailViewControllerMaserati;
@synthesize splitViewControllerShuttleService;
@synthesize shuttleServiceRootViewController;
@synthesize firstMonthDetailViewController;
@synthesize splitViewControllerEvents;
@synthesize newsDetailView;
@synthesize newsRootViewController;
@synthesize splitViewControllerNews;
@synthesize whichTablePopUpView;



@synthesize managedObjectContext = __managedObjectContext;
@synthesize managedObjectModel = __managedObjectModel;
@synthesize persistentStoreCoordinator = __persistentStoreCoordinator;



#pragma mark -
#pragma mark Application lifecycle

-(void) makeSplitViewController {
    NSMutableArray *controllers = [NSMutableArray arrayWithArray:tabBarController.viewControllers];
    
    int index = 0; 
    
    for (UIViewController *controller in tabBarController.viewControllers) {
        if (index == 1) {
            firstDetailViewController = [[DomizileFirstDetailViewController alloc] initWithNibName:@"DomizileFirstDetailViewController" bundle:nil];
            
            
            
            domizileRootViewController = [[DomizileRootViewController alloc] initWithStyle:UITableViewStylePlain];
            domizileRootViewController.firstDetailViewController = firstDetailViewController;
            domizileRootViewController.navigationItem.title = @"List";
            
            
            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:domizileRootViewController] ;
            
            
            splitViewControllerDomizile = [[EnhancedSplitViewController alloc] init];
            
            //setzt als TabbarItem des SplitViewControllers das tab abr item des xib Files 
            splitViewControllerDomizile.tabBarItem = controller.tabBarItem;
            
            //schickt DetailView samt NavigationController an den SPlitviewController
            
            
            UINavigationController *firstDetailNavigationController = [[UINavigationController alloc] initWithRootViewController:firstDetailViewController];
            [firstDetailViewController release];
            [splitViewControllerDomizile setViewControllers:[NSArray arrayWithObjects:nav, firstDetailNavigationController, nil]];

           // splitViewControllerDomizile.viewControllers = [NSArray arrayWithObjects:nav, firstDetailViewController, nil];
            //firstDetailViewController ist die Delegate des SlitViewControllers und erhält dessen Nachrichten
            
            
            splitViewControllerDomizile.delegate = firstDetailViewController;
            splitViewControllerDomizile.barButton = firstDetailViewController.barButton;
            splitViewControllerDomizile.pc  =firstDetailViewController.popoverController;
            
            
            //der Controller welcher bisher in der Tabbar registriert ist wird überschrieben
            
            [controllers replaceObjectAtIndex:index withObject:splitViewControllerDomizile];
        }
        
        
        
        
        else if (index == 2) {
            shuttleServiceDetailViewControllerMaserati = [[ShuttleServiceDetailViewControllerMaserati alloc] initWithNibName:@"ShuttleServiceDetailViewControllerMaserati" bundle:nil];
            
            
            
            shuttleServiceRootViewController = [[ShuttleServiceRootViewController alloc] initWithStyle:UITableViewStylePlain];
            shuttleServiceRootViewController.firstDetailViewController = shuttleServiceDetailViewControllerMaserati;
            shuttleServiceRootViewController.navigationItem.title = @"ShuttleService";
            
            
            UINavigationController *nav = [[[UINavigationController alloc] initWithRootViewController:shuttleServiceRootViewController] autorelease];
            
            
            splitViewControllerShuttleService = [[EnhancedSplitViewController alloc] init];
            
            //setzt als TabbarItem des SplitViewControllers das tab abr item des xib Files 
             splitViewControllerShuttleService.tabBarItem = controller.tabBarItem;
            
            //schickt DetailView samt NavigationController an den SPlitviewController
            
            
            
            UINavigationController *firstDetailNavigationController = [[UINavigationController alloc] initWithRootViewController:shuttleServiceDetailViewControllerMaserati];
            [firstDetailViewController release];
            [splitViewControllerShuttleService setViewControllers:[NSArray arrayWithObjects:nav, firstDetailNavigationController, nil]];
            
            
            //splitViewControllerShuttleService.viewControllers = [NSArray arrayWithObjects:nav,shuttleServiceDetailViewControllerMaserati, nil];
            //firstDetailViewController ist die Delegate des SlitViewControllers und erhält dessen Nachrichten
            
            
            
            splitViewControllerShuttleService.delegate = shuttleServiceDetailViewControllerMaserati;
          
            //  splitViewControllerShuttleService.barButton = shuttleServiceDetailViewControllerMaserati.barButton;
           // splitViewControllerShuttleService.pc  =shuttleServiceDetailViewControllerMaserati.popoverController;
            
            
            //der Controller welcher bisher in der Tabbar registriert ist wird überschrieben
            
            [controllers replaceObjectAtIndex:index withObject:splitViewControllerShuttleService];
        }
        
        
        
        else if (index == 4) {
            firstMonthDetailViewController = [[MonatEventDetailView alloc] initWithNibName:@"MonatEventDetailView" bundle:nil];
            
            
            
            eventRootViewController = [[EventRootViewController alloc] initWithStyle:UITableViewStylePlain];
            eventRootViewController.firstMonthDetailViewController = firstMonthDetailViewController;
            eventRootViewController.navigationItem.title = @"Events";
            
            
            UINavigationController *nav = [[[UINavigationController alloc] initWithRootViewController:eventRootViewController] autorelease];
            
            
            splitViewControllerEvents = [[EnhancedSplitViewController alloc] init];
            
            //setzt als TabbarItem des SplitViewControllers das tab abr item des xib Files 
            splitViewControllerEvents.tabBarItem = controller.tabBarItem;
            
            
            UINavigationController *firstDetailNavigationController = [[UINavigationController alloc] initWithRootViewController:firstMonthDetailViewController];
            [firstMonthDetailViewController release];
            [splitViewControllerEvents setViewControllers:[NSArray arrayWithObjects:nav, firstDetailNavigationController, nil]];

            
            
            
            //schickt DetailView samt NavigationController an den SPlitviewController
           // splitViewControllerEvents.viewControllers = [NSArray arrayWithObjects:nav, firstMonthDetailViewController, nil];
            
            //firstDetailViewController ist die Delegate des SlitViewControllers und erhält dessen Nachrichten
            splitViewControllerEvents.delegate = firstMonthDetailViewController;
            
            //  splitViewControllerShuttleService.barButton = shuttleServiceDetailViewControllerMaserati.barButton;
            // splitViewControllerShuttleService.pc  =shuttleServiceDetailViewControllerMaserati.popoverController;
            
            
            //der Controller welcher bisher in der Tabbar registriert ist wird überschrieben
            
            [controllers replaceObjectAtIndex:index withObject:splitViewControllerEvents];
        }

        else if (index == 5) {
            newsDetailView = [[NewsDetailView alloc] initWithNibName:@"NewsDetailView" bundle:nil];
            
            
            
            newsRootViewController = [[NewsRootViewController alloc] initWithStyle:UITableViewStylePlain];
            newsRootViewController.newsDetailView = newsDetailView;
            newsRootViewController.navigationItem.title = @"News";
            
            
            UINavigationController *nav = [[[UINavigationController alloc] initWithRootViewController:newsRootViewController] autorelease];
            
            
            splitViewControllerNews = [[EnhancedSplitViewController alloc] init];
            
            //setzt als TabbarItem des SplitViewControllers das tab abr item des xib Files 
            splitViewControllerNews.tabBarItem = controller.tabBarItem;
            
            //schickt DetailView samt NavigationController an den SPlitviewController
            splitViewControllerNews.viewControllers = [NSArray arrayWithObjects:nav, newsDetailView, nil];
            
            //firstDetailViewController ist die Delegate des SlitViewControllers und erhält dessen Nachrichten
            splitViewControllerNews.delegate = newsDetailView;
           
            
            
            //der Controller welcher bisher in der Tabbar registriert ist wird überschrieben
            
            [controllers replaceObjectAtIndex:index withObject:splitViewControllerNews];
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
    
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];

    
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
    [domizileRootViewController release];
    [firstDetailViewController release];
    
    [tabBarController release];
    [window release];
	
    [super dealloc];
}










- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil)
    {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error])
        {
            /*
             Replace this implementation with code to handle the error appropriately.
             
             abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
             */
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        } 
    }
}








#pragma mark - Core Data stack

/**
 Returns the managed object context for the application.
 If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
 */
- (NSManagedObjectContext *)managedObjectContext
{
    if (__managedObjectContext != nil)
    {
        return __managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil)
    {
        __managedObjectContext = [[NSManagedObjectContext alloc] init];
        [__managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return __managedObjectContext;
}

/**
 Returns the managed object model for the application.
 If the model doesn't already exist, it is created from the application's model.
 */
- (NSManagedObjectModel *)managedObjectModel
{
    if (__managedObjectModel != nil)
    {
        return __managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"SAS_iPad_App" withExtension:@"momd"];
    __managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return __managedObjectModel;
}

/**
 Returns the persistent store coordinator for the application.
 If the coordinator doesn't already exist, it is created and the application's store added to it.
 */
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (__persistentStoreCoordinator != nil)
    {
        return __persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"SAS_iPad_App.sqlite"];
    
    NSError *error = nil;
    __persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![__persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error])
    {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
         
         Typical reasons for an error here include:
         * The persistent store is not accessible;
         * The schema for the persistent store is incompatible with current managed object model.
         Check the error message to determine what the actual problem was.
         
         
         If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
         
         If you encounter schema incompatibility errors during development, you can reduce their frequency by:
         * Simply deleting the existing store:
         [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
         
         * Performing automatic lightweight migration by passing the following dictionary as the options parameter: 
         [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:YES], NSMigratePersistentStoresAutomaticallyOption, [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption, nil];
         
         Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
         
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }    
    
    return __persistentStoreCoordinator;
}



#pragma mark - Application's Documents directory

/**
 Returns the URL to the application's Documents directory.
 */
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}


@end


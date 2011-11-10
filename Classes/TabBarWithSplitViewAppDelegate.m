//
//  TabBarWithSplitViewAppDelegate.m
//  TabBarWithSplitView
//
//  Created by Bart Bruijnesteijn on 3/23/11.
//  Copyright 2011 PiecesOfMyMind Software. All rights reserved.
//

#import "TabBarWithSplitViewAppDelegate.h"
#import "CoreData/Queries.h"
#import "CoreData/Utils.h"
#import "SuchergebnisseKarte.h"
#import "Home.h"

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
@synthesize controllers;



#pragma mark -
#pragma mark Application lifecycle



- (void) copyDatabaseIfNeeded {
    NSString *sourcePath = [[NSBundle mainBundle] pathForResource:@"Apartments" ofType:@"sqlite"];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *destinationPath = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"Apartments.sqlite"];

    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    
    [Queries incrementalImport:managedObjectContext()];
    
    if (![fileManager fileExistsAtPath:destinationPath]) {
        [fileManager copyItemAtPath:sourcePath toPath:destinationPath error:&error];
        //[Queries initialImport:managedObjectContext()];
    } else {
        NSDictionary *dict = [fileManager fileAttributesAtPath:destinationPath traverseLink:NO];
        NSNumber *number = [dict objectForKey:NSFileSize];
        if (nil != number && [number intValue] < 500000){
            [fileManager copyItemAtPath:sourcePath toPath:destinationPath error:&error];
        }        
    }
    
    
    
}





- (void) makeSplitViewController {
    controllers = [NSMutableArray arrayWithArray:tabBarController.viewControllers];
    
    int index = 0; 
    
    for (UIViewController *controller in tabBarController.viewControllers) {
      /*  if (index == 1) {
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
            UIImage *img= [UIImage imageNamed:@"domizile_btn_tabbar.png"];
            splitViewControllerDomizile.tabBarItem.image=img;
            
        
            //der Controller welcher bisher in der Tabbar registriert ist wird überschrieben
            
            [controllers replaceObjectAtIndex:index withObject:splitViewControllerDomizile];
        }
        
        
        
        
         if (index == 2) {
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
            UIImage *img= [UIImage imageNamed:@"shuttle_btn_tabbar.png"];
            splitViewControllerShuttleService.tabBarItem.image=img;

            
            //der Controller welcher bisher in der Tabbar registriert ist wird überschrieben
            
            [controllers replaceObjectAtIndex:index withObject:splitViewControllerShuttleService];
        }
        
        */
        
         if (index == 3) {
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

            
            UIImage *img= [UIImage imageNamed:@"events_btn.png"];
            splitViewControllerEvents.tabBarItem.image=img;
            
            //schickt DetailView samt NavigationController an den SPlitviewController
           // splitViewControllerEvents.viewControllers = [NSArray arrayWithObjects:nav, firstMonthDetailViewController, nil];
            
            //firstDetailViewController ist die Delegate des SlitViewControllers und erhält dessen Nachrichten
            splitViewControllerEvents.delegate = firstMonthDetailViewController;
            
            //  splitViewControllerShuttleService.barButton = shuttleServiceDetailViewControllerMaserati.barButton;
            // splitViewControllerShuttleService.pc  =shuttleServiceDetailViewControllerMaserati.popoverController;
            
            
            //der Controller welcher bisher in der Tabbar registriert ist wird überschrieben
            
            [controllers replaceObjectAtIndex:index withObject:splitViewControllerEvents];
        }

        else if (index == 4) {
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
            UIImage *img= [UIImage imageNamed:@"news_btn.png"];
            splitViewControllerNews.tabBarItem.image=img;
            
            
            //der Controller welcher bisher in der Tabbar registriert ist wird überschrieben
            
            [controllers replaceObjectAtIndex:index withObject:splitViewControllerNews];
        }

        
        

        index++;
        NSLog(@"%d",index);
    }
    tabBarController.viewControllers = controllers;
    tabBarController.delegate = self;
    
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
   /* SuchergebnisseKarte *suchergebnisseKarte=[[SuchergebnisseKarte alloc]initWithNibName:@"SuchergebnisseKarte" bundle:nil];
    Home *home =[[Home alloc]initWithNibName:@"Home" bundle:nil];
    
    navigationControllerModalViews=[[UINavigationController alloc]initWithRootViewController:home];
    navigationControllerModalViews.modalPresentationStyle=UIModalPresentationCurrentContext;
    navigationControllerModalViews.modalTransitionStyle=UIModalTransitionStyleCrossDissolve;
    navigationControllerModalViews.tabBarItem.title=@"Home";
    UIImage *img= [UIImage imageNamed:@"home_btn_tabbar.png"];
    navigationControllerModalViews.tabBarItem.image=img;
    
    [controllers replaceObjectAtIndex:0 withObject:navigationControllerModalViews];*/
    [self makeSplitViewController];
   
   
    
    
    // Override point for customization after app launch.
    
    // Set the tab bar controller as the window's root view controller and display.
    
    self.window.rootViewController = self.tabBarController;
    [self.window makeKeyAndVisible];
    
    //startImport();
    
    
    [self copyDatabaseIfNeeded];
    
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
    saveContext();    
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
- (BOOL)transferDb {
    NSError **error;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"Apartments.sqlite"]; 
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSLog(@"Path doesnt exist");
    if ([fileManager fileExistsAtPath: path])
    {
        NSString *bundle =  [[ NSBundle mainBundle] pathForResource:@"preferenze" ofType:@"plist"];
        [fileManager copyItemAtPath:bundle toPath:path error:error];
        return YES;
        NSLog(@"Path exists");
        
    }
   NSLog(@"Path doesnt exist");
    return NO;
}



- (void)dealloc {
    [splitViewControllerDomizile release];
    [domizileRootViewController release];
    [firstDetailViewController release];
    
    [tabBarController release];
    [window release];
	
    [super dealloc];
}


#pragma mark - Application's Documents directory

@end


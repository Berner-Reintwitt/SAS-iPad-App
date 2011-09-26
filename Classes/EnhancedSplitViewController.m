//
//  EnhancedSplitViewController.m
//  Enhanced SplitViewController
//
//  Created by Bart Bruijnesteijn on 3/23/11.
//  Copyright 2011 PiecesOfMyMind Software. All rights reserved.
//

#import "EnhancedSplitViewController.h"
#import <objc/message.h>

@implementation EnhancedSplitViewController

@synthesize barButton, pc;

- (void)viewDidLoad {
    [super viewDidLoad];
    
   	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(willRotate:)
												 name:UIApplicationWillChangeStatusBarOrientationNotification object:nil];

	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(didRotate:)
												 name:UIApplicationDidChangeStatusBarOrientationNotification object:nil];	
}

- (void)willRotate:(id)sender {
	if (![self isViewLoaded]) { 
		return;
    }
    
	NSNotification *notification = sender;
	if (!notification) {
		return;
    }
    
	UIInterfaceOrientation toOrientation = [[notification.userInfo valueForKey:UIApplicationStatusBarOrientationUserInfoKey] integerValue];

	UITabBarController *tabBar = self.tabBarController;
	BOOL notModal = (!tabBar.modalViewController);
	BOOL isSelectedTab = [self.tabBarController.selectedViewController isEqual:self];
    
	NSTimeInterval duration = [[UIApplication sharedApplication] statusBarOrientationAnimationDuration];
    
	if (!isSelectedTab || !notModal)  { 
		[super willRotateToInterfaceOrientation:toOrientation duration:duration];
        
		UIViewController *master = [self.viewControllers objectAtIndex:0];
		NSObject *theDelegate = (NSObject *)self.delegate;
       
		if (UIInterfaceOrientationIsPortrait(toOrientation)) {
			if (theDelegate && [theDelegate respondsToSelector:@selector(splitViewController:willHideViewController:withBarButtonItem:forPopoverController:)]) {
                
				@try {
					objc_msgSend(theDelegate, @selector(splitViewController:willHideViewController:withBarButtonItem:forPopoverController:), self, master, barButton, pc);
				}
				@catch (NSException * e) {
					NSLog(@"There was a nasty error while notifyng splitviewcontrollers of an orientation change: %@", [e description]);
				}
			}
		}
		else if (UIInterfaceOrientationIsLandscape(toOrientation)) {
			if (theDelegate && [theDelegate respondsToSelector:@selector(splitViewController:willShowViewController:invalidatingBarButtonItem:)]) {
				@try {
					objc_msgSend(theDelegate, @selector(splitViewController:willShowViewController:invalidatingBarButtonItem:), self, master, barButton);
				}
				@catch (NSException * e) {
					NSLog(@"There was a nasty error while notifyng splitviewcontrollers of an orientation change: %@", [e description]);
				}
			}
		}
	}

}

- (void)didRotate:(id)sender {
//	if (![self isViewLoaded]) {
//		return;
//    }
//    
//	NSNotification *notification = sender;
//	if (!notification) {
//		return;
//    }
//    
//	UIInterfaceOrientation fromOrientation = [[notification.userInfo valueForKey:UIApplicationStatusBarOrientationUserInfoKey] integerValue];
//	
//	UITabBarController *tabBar = self.tabBarController;
//	BOOL notModal = (!tabBar.modalViewController);
//	BOOL isSelectedTab = [self.tabBarController.selectedViewController isEqual:self];
//	
//	if (!isSelectedTab || !notModal)  { 
//		[super didRotateFromInterfaceOrientation:fromOrientation];
//	}

	if (![self isViewLoaded]) // we haven't even loaded up yet, let's turn away from this place
		return;
    
	NSNotification *notification = sender;
	if (!notification)
		return;
	UIInterfaceOrientation fromOrientation = [[notification.userInfo valueForKey:UIApplicationStatusBarOrientationUserInfoKey] integerValue];
	//UIInterfaceOrientation toOrientation = [UIApplication sharedApplication].statusBarOrientation;
    
	UITabBarController *tabBar = self.tabBarController;
	BOOL notModal = (!tabBar.modalViewController);
	BOOL isSelectedTab = [self.tabBarController.selectedViewController isEqual:self];
    
	if (!isSelectedTab || !notModal)  { // I don't think we're visible...
		[super didRotateFromInterfaceOrientation:fromOrientation];
	}
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
    [super viewDidUnload];
}


- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];

	[super dealloc];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}

@end

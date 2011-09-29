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

//
//  SuchergebnisseHausDetail.m
//  TabBarWithSplitView
//
//  Created by Johannes Böhler on 19.10.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "SuchergebnisseHausDetail.h"

@implementation SuchergebnisseHausDetail

@synthesize calender;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{   [calender.view setFrame:CGRectMake(600, 500, calender.view.frame.size.width, calender.view.frame.size.height)];
     
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}

@end

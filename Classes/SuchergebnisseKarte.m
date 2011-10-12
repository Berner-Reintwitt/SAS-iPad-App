//
//  SuchergebnisseKarte.m
//  TabBarWithSplitView
//
//  Created by Johannes Böhler on 12.10.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "SuchergebnisseKarte.h"
#import "TabBarWithSplitViewAppDelegate.h"
#import "SortierenNachPopOver.h"

@implementation SuchergebnisseKarte
@synthesize zurueckNavigationButtonItem;

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
{
    [self setZurueckNavigationButtonItem:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}

- (IBAction)zurueckWasPressed:(id)sender {
    TabBarWithSplitViewAppDelegate *appDelegate = (TabBarWithSplitViewAppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate.domizileRootViewController.splitViewController dismissModalViewControllerAnimated:YES];
    NSLog(@"Hallo0");
    
    
}
- (void)dealloc {
    [zurueckNavigationButtonItem release];
    [super dealloc];
}
- (IBAction)suchergebnisseButtonWasPressed:(id)sender {
    SortierenNachPopOver *sortierenNachPopOver =[[SortierenNachPopOver alloc] initWithNibName:@"SortierenNachPopOver" bundle:nil];
    
    UIPopoverController *popoverControllerDomiz=[[UIPopoverController alloc] initWithContentViewController:sortierenNachPopOver];
    [popoverControllerDomiz presentPopoverFromRect:[sender frame] inView:self.view permittedArrowDirections:UIPopoverArrowDirectionLeft animated:YES];
    
}
@end

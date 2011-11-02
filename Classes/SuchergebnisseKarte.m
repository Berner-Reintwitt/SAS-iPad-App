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
#import "SuchergebnisseHausDetail.h"

@implementation SuchergebnisseKarte


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
    button=[[UIBarButtonItem alloc]initWithTitle:@"zurück" style:UIBarButtonItemStyleBordered target:self action:@selector (zurueckWasPressed:)];
    [button setTitle:@"zurück"];
                       
   // self.navigationItem.leftBarButtonItem=button;
    [button setTag:1];
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
   
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}

- (void)zurueckWasPressed:(id)sender {
        TabBarWithSplitViewAppDelegate *appDelegate = (TabBarWithSplitViewAppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate.domizileRootViewController.splitViewController dismissModalViewControllerAnimated:YES];
    NSLog(@"Hallo0");
    
    
}
- (void)dealloc {
   
    [super dealloc];
}
- (IBAction)suchergebnisseButtonWasPressed:(id)sender {
    SortierenNachPopOver *sortierenNachPopOver =[[SortierenNachPopOver alloc] initWithNibName:@"SortierenNachPopOver" bundle:nil];
    
    UIPopoverController *popoverControllerDomiz=[[UIPopoverController alloc] initWithContentViewController:sortierenNachPopOver];
    [popoverControllerDomiz presentPopoverFromRect:[sender frame] inView:self.view permittedArrowDirections:UIPopoverArrowDirectionLeft animated:YES];
    
}

- (IBAction)detailAnsichtWasPressed:(id)sender {
    TabBarWithSplitViewAppDelegate *appDelegate = (TabBarWithSplitViewAppDelegate *)[[UIApplication sharedApplication] delegate];
    
    
    SuchergebnisseHausDetail *suchergebnissHaus=[[SuchergebnisseHausDetail alloc]initWithNibName:@"SuchergebnisseHausDetail" bundle:nil];
    
   // suchergebnissHaus.modalPresentationStyle=UIModalPresentationFullScreen;
    //suchergebnissHaus.modalTransitionStyle=UIModalTransitionStyleFlipHorizontal;
    
   
    
    [navigationControllerModalViews pushViewController:suchergebnissHaus animated:YES];
}


@end

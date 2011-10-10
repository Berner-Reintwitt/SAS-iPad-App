//
//  Wetter.m
//  TabBarWithSplitView
//
//  Created by Johannes Böhler on 04.10.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "WetterViewController.h"

@implementation WetterViewController




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
    
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}

- (IBAction)orteButtonWasPressed:(id)sender {
    

    popUpViewController=[[SearchPopUpViewController alloc] initWithNibName:@"WetterOrtePopUpView" bundle:nil];
        
    
    
    
    popover=[[UIPopoverController alloc]initWithContentViewController:popUpViewController];
    [popUpViewController release];
    [popover presentPopoverFromBarButtonItem:sender permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    
    
    
}

- (IBAction)searchButtonWasPressed:(id)sender {
    
    
    popUpViewController=[[SearchPopUpViewController alloc] initWithNibName:@"SearchPopUpViewController" bundle:nil];
        
   
    
    
    popover=[[UIPopoverController alloc]initWithContentViewController:popUpViewController];
    [popUpViewController release];
    [popover presentPopoverFromBarButtonItem:sender permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];

    
    
    
}
- (void)dealloc {
  
    [super dealloc];
}
@end

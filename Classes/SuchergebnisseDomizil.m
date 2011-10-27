//
//  SuchergebnisseDomizil.m
//  TabBarWithSplitView
//
//  Created by Johannes Böhler on 25.10.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "SuchergebnisseDomizil.h"

@implementation SuchergebnisseDomizil
@synthesize scrollView;

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
{   scrollView.frame = CGRectMake(0, 325,1024 , 748);
    
    //---set the content size of the scroll view---
    [scrollView setContentSize:CGSizeMake(1600, 748)];
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [self setScrollView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}


- (IBAction)scroll:(id)sender {
    NSLog(@"Hallo");
    UIScrollView *scrollview=  (UIScrollView *)self.view;
    [scrollview scrollRectToVisible:CGRectMake(340, 750, 1024, 768) animated:YES];
    
}
- (void)dealloc {
    [scrollView release];
    [super dealloc];
}
@end

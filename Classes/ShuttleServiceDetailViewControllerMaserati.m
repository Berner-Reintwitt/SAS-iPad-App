//
//  ShuttleServiceDetailViewControllerMaserati.m
//  TabBarWithSplitView
//
//  Created by Johannes Böhler on 27.09.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ShuttleServiceDetailViewControllerMaserati.h"

@implementation ShuttleServiceDetailViewControllerMaserati
@synthesize secondSmallImg;
@synthesize firstSmallImg;
@synthesize bigImg;

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


- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [[event allTouches] anyObject];
    CGPoint location = [touch locationInView:touch.view];
    
    if (touch.view.tag == 1) {
        //bigImg=
    }
    
    NSLog(@"tag=%@", [NSString stringWithFormat:@"%i", touch.view.tag]);
    
}

- (void)viewDidUnload
{
    [self setBigImg:nil];
    [self setSecondSmallImg:nil];
    [self setFirstSmallImg:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return NO;
}

- (void)dealloc {
    [bigImg release];
    [secondSmallImg release];
    [firstSmallImg release];
    [super dealloc];
}
@end

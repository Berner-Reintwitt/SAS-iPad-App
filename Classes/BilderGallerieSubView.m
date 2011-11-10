//
//  BilderGallerieSubView.m
//  TabBarWithSplitView
//
//  Created by Johannes Böhler on 10.11.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "BilderGallerieSubView.h"

@implementation BilderGallerieSubView

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
{   
    
    UIImage *img=[[UIImage alloc]init];
    //scrollView=[[UIScrollView alloc]init];
    scrollView.frame = CGRectMake( 0,0, 720, 400);
    self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width * 10, self.scrollView.frame.size.height);
    
    //---set the content size of the scroll view---
    for( int i=0;i<10;i++){
        CGRect frame;
        frame.origin.x = self.scrollView.frame.size.width * i;
        frame.origin.y = 0;
        frame.size = self.scrollView.frame.size;
        
        
        UIImage *img = [UIImage imageNamed:@"pig.png"];
        UIImageView *imgView=[[UIImageView alloc]initWithFrame:frame];
        imgView.image=img;
        
        [self.scrollView addSubview:imgView];
        }
    [scrollView scrollRectToVisible:CGRectMake(0, 0, scrollView.frame.size.width, scrollView.frame.size.height)animated:YES];

    
    
    
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

@end

//
//  SuchergebnisseDomizil.m
//  TabBarWithSplitView
//
//  Created by Johannes Böhler on 25.10.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "SuchergebnisseDomizil.h"

@implementation SuchergebnisseDomizil
@synthesize mapView;
@synthesize table;
@synthesize myscrollView;
@synthesize pageControl;
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
{   scrollView.frame = CGRectMake( 0,0,1024 , 748);
    
    //---set the content size of the scroll view---
    [scrollView setContentSize:CGSizeMake(1900, 748)];
    NSArray *colors = [NSArray arrayWithObjects:[UIColor redColor], [UIColor greenColor], [UIColor blueColor], [UIColor blackColor],nil];
    for (int i = 0; i < colors.count; i++) {
        CGRect frame;
        frame.origin.x = self.myscrollView.frame.size.width * i;
        frame.origin.y = 0;
        frame.size = self.myscrollView.frame.size;
        
        UIView *subview = [[UIView alloc] initWithFrame:frame];
        subview.backgroundColor = [colors objectAtIndex:i];
        [self.myscrollView addSubview:subview];
        pageControl.numberOfPages=[colors count];
        [subview release];
        
        // Do any additional setup after loading the view from its nib.
    }
    self.myscrollView.contentSize = CGSizeMake(self.myscrollView.frame.size.width * colors.count, self.myscrollView.frame.size.height);
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{   
    
    [self setMyscrollView:nil];
    [self setPageControl:nil];
    [self setMyscrollView:nil];
    [self setPageControl:nil];
    [super viewDidUnload];
    [self setScrollView:nil];
    [self setMapView:nil];
    [self setTable:nil];
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
    
    CGRect frame;
    frame.origin.x = mapView.frame.size.width+50;
    //frame.origin.y = 0;
    frame.origin.y=0;
    frame.size = CGSizeMake(1024, 748);
    [self.scrollView scrollRectToVisible:frame animated:YES];
    
   // [scrollview scrollRectToVisible:CGRectMake(340, 750, 1024, 768) animated:YES];
    
}

- (IBAction)srollBack:(id)sender {
    
    CGRect frame;
    frame.origin.x = 0;
    
    frame.origin.y=0;
    frame.size = CGSizeMake(1024, 748);
    [self.scrollView scrollRectToVisible:frame animated:YES];
}
- (void)dealloc {
    
    [myscrollView release];
    [pageControl release];
    [super dealloc];

    [scrollView release];
    [mapView release];
    [table release];
    [myscrollView release];
    [pageControl release];
    [super dealloc];
}
- (IBAction)switchFrame:(id)sender {
    
    scrollView.frame=CGRectMake(mapView.frame.size.width, 0, 1024, 748);
    
}




-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    // Update the page when more than 50% of the previous/next page is visible
    CGFloat pageWidth = myscrollView.frame.size.width;
    int page = floor((myscrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    pageControl.currentPage = page;
    
}


- (IBAction)changePage:(id)sender {
    CGRect frame;
    frame.origin.x = self.myscrollView.frame.size.width * self.pageControl.currentPage;
    frame.origin.y = 0;
    frame.size = self.myscrollView.frame.size;
    [self.myscrollView scrollRectToVisible:frame animated:YES];
    
    
}




@end

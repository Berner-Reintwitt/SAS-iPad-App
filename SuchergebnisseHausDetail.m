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
@synthesize myscrollView;
@synthesize pageControl;

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
{   NSArray *colors = [NSArray arrayWithObjects:[UIColor redColor], [UIColor greenColor], [UIColor blueColor], [UIColor blackColor],nil];
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
}

- (void)viewDidUnload
{   [calender.view setFrame:CGRectMake(600, 500, calender.view.frame.size.width, calender.view.frame.size.height)];
     
    [self setMyscrollView:nil];
    [self setPageControl:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    // Update the page when more than 50% of the previous/next page is visible
    CGFloat pageWidth = myscrollView.frame.size.width;
    int page = floor((myscrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    pageControl.currentPage = page;

}

- (void)dealloc {
    [myscrollView release];
    [pageControl release];
    [super dealloc];
}
- (IBAction)changePage:(id)sender {
    CGRect frame;
    frame.origin.x = self.myscrollView.frame.size.width * self.pageControl.currentPage;
    frame.origin.y = 0;
    frame.size = self.myscrollView.frame.size;
    [self.myscrollView scrollRectToVisible:frame animated:YES];
    
    
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    pageControlBeingUsed = NO;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    pageControlBeingUsed = NO;
}
@end

//
//  NewsRootViewController.m
//  TabBarWithSplitView
//
//  Created by Johannes Böhler on 04.10.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "NewsRootViewController.h"

@implementation NewsRootViewController

@synthesize newsDetailView;
@synthesize array1;
@synthesize splitViewController;
@synthesize tableCell;

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

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/


- (void)viewDidLoad
{   
   
    array1=[[NSArray alloc]initWithObjects:@"News 1", @"News 2", @"News 3", @"News 4", nil];
    self.clearsSelectionOnViewWillAppear = NO;
   // self.contentSizeForViewInPopover = CGSizeMake(320.0, 600.0);
    self.navigationItem.title=@"News";
    self.tableView.rowHeight=100;        
    [super viewDidLoad];
}


- (void)viewDidUnload
{
    [self setTableCell:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return NO;
}

#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)aTableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)aTableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 5;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"CellIdentifier";
    
    // Dequeue or create a cell of the appropriate type.
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
       NSArray *nib=[[NSBundle mainBundle] loadNibNamed:@"NewsRootViewContrTableCell" owner:self options:nil];
        cell=self.tableCell;
    }
    // Configure the cell.
    //cell.textLabel.text = [array1 objectAtIndex:indexPath.row];
    
    return cell;
}

#pragma mark -
#pragma mark Table view delegate



- (void)tableView:(UITableView *)aTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // firstDetailViewController.detailItem = [NSString stringWithFormat:@"Row %d", indexPath.row];
    NSUInteger row = indexPath.row;
    
    
    
    if(row==0){
        
         newsDetailView.textView.text=@"Autounfall adjgojadhgdgpjagjdasojgijnas";
    }
    
    else if(row==1){
        
        newsDetailView.textView.text=@"Unwetter über sdgndslgndsgdskgj";
        
    }
    
    else if(row==2){
        
        newsDetailView.textView.text=@"Rezept";
        
    }
    else if(row==3){
        
        newsDetailView.textView.text=@"leckeres Rezept";
        
    }
    
    else if(row==4){
        
        newsDetailView.textView.text=@"letzte Zeile";
        
    }
    
}

- (void)dealloc {
    [tableCell release];
    [super dealloc];
}
@end

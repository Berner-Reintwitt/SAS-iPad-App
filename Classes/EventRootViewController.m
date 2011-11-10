//
//  EventRootViewController.m
//  TabBarWithSplitView
//
//  Created by Johannes Böhler on 04.10.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "EventRootViewController.h"
#

@implementation EventRootViewController

@synthesize firstMonthDetailViewController;
@synthesize secondMonthDetailViewController;
@synthesize array1;
@synthesize splitViewController;
@synthesize cellTextfield;
@synthesize tableViewCell;




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
{   self.tableView.rowHeight=100; 
    array1=[[NSArray alloc]initWithObjects:@"November 2011",@"Dezember 2011",@"Januar 2012",@"Februar 2012",@"März 2012",@"April 2012",@"Mai 2012",@"Juni 2012",@"Juli 2012",@"August 2012",@"September 2012",nil];
    self.clearsSelectionOnViewWillAppear = NO;
    self.contentSizeForViewInPopover = CGSizeMake(320.0, 600.0);
    self.navigationItem.title=@"Events";

    [super viewDidLoad];
}


- (void)viewDidUnload
{
    [self setCellTextfield:nil];
    
    [self setTableViewCell:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}


#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)aTableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)aTableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [array1 count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = nil;
    
    
    cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    
    if (cell == nil) {
        NSArray *nib=[[NSBundle mainBundle] loadNibNamed:@"EventRootControllerTableCell" owner:self options:nil];
        cell = self.tableViewCell;
    }
    // Configure the cell...
    self.cellTextfield.text = [array1 objectAtIndex:indexPath.row];
    
    return cell;
}

#pragma mark -
#pragma mark Table view delegate



- (void)tableView:(UITableView *)aTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // firstDetailViewController.detailItem = [NSString stringWithFormat:@"Row %d", indexPath.row];
    
    NSUInteger row = indexPath.row;
    NSArray *array;
    if(row==0){
        array= [[NSArray alloc]initWithObjects:@"1. November ",@"2.November....",@"3.November", nil];
    }
    
    else if (row==1){
        array=[[NSArray alloc]initWithObjects:@"1.Dezember",@"2.Dezember......",@"3.Dezember",@"4.Dezember", nil];
        
        
    }
    else if (row==2){
        array=[[NSArray alloc]initWithObjects:@"1.Jan",@"2.Jan......",@"3.Jan",@"4.Jan", nil];
        
        
    }
    
    else if (row==3){
        array=[[NSArray alloc]initWithObjects:@"1.Feb",@"2.Feb......",@"3.Feb",@"4.Feb", nil];
        
        
    }
       
   
    
    
  
    
}


- (void)dealloc {
    [cellTextfield release];
   
    [tableViewCell release];
    [super dealloc];
}
@end

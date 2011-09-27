//
//  ShuttleServiceRootViewController.m
//  TabBarWithSplitView
//
//  Created by Johannes Böhler on 27.09.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ShuttleServiceRootViewController.h"

@implementation ShuttleServiceRootViewController
@synthesize firstDetailViewController;
//@synthesize splitViewController;
@synthesize array1;

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
    [super viewDidLoad];
    array1=[[NSArray alloc]initWithObjects:@"Maserati",@"Aston Martin",nil];
   // self.clearsSelectionOnViewWillAppear = NO;
    self.contentSizeForViewInPopover = CGSizeMake(320.0, 600.0);
    self.navigationItem.title=@"ShuttleService";

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
	return NO;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)aTableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)aTableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [array1 count];
}


- (void)tableView:(UITableView *)aTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSUInteger row = indexPath.row;
    
    
    if(row==0){
        firstDetailViewController=[[ShuttleServiceDetailViewControllerMaserati alloc] initWithNibName:@"ShuttleServiceDetailViewControllerMaserati" bundle:nil];
        UINavigationController *firstDetailNavigationController = [[UINavigationController alloc] initWithRootViewController:firstDetailViewController];
        [firstDetailViewController release];
        [self.splitViewController setViewControllers:[NSArray arrayWithObjects:self.navigationController, firstDetailNavigationController, nil]];
        
        
        
        
    }
    
    
    else if(row==1){
        
        
        ShuttleServiceDetailViewControllerAstonMartin *secondDetailViewController=[[ShuttleServiceDetailViewControllerAstonMartin alloc] initWithNibName:@"ShuttleServiceDetailViewControllerAstonMartin" bundle:nil];
        UINavigationController *secondDetailNavigationController = [[UINavigationController alloc] initWithRootViewController:secondDetailViewController];
        [secondDetailViewController release];
        [self.splitViewController setViewControllers:[NSArray arrayWithObjects:self.navigationController, secondDetailNavigationController, nil]];
    }
    
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"CellIdentifier";
    
    // Dequeue or create a cell of the appropriate type.
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    // Configure the cell.
    cell.textLabel.text = [array1 objectAtIndex:indexPath.row];
    
    return cell;
}





@end

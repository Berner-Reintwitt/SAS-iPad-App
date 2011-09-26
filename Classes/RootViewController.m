//
//  RootViewController.m
//  SplitView
//
//  Created by KLM95628 on 3/23/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "RootViewController.h"
#import "FirstDetailViewController.h"
#import "TabBarWithSplitViewAppDelegate.h"

@implementation RootViewController
@synthesize firstDetailViewController;
@synthesize array1;
@synthesize secondDetailViewController;
//@synthesize splitViewController;
#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    array1=[[NSArray alloc]initWithObjects:@"Suchen und Buchen ",@"Alle Domizile",@"Sonder Offerten",@"Suche über Orte",nil];
    self.clearsSelectionOnViewWillAppear = NO;
    self.contentSizeForViewInPopover = CGSizeMake(320.0, 600.0);
    self.navigationItem.title=@"Domizile";
}

// Ensure that the view controller supports rotation and that the split view can therefore show in both portrait and landscape.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
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
    return [array1 count];
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

#pragma mark -
#pragma mark Table view delegate



- (void)tableView:(UITableView *)aTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
   // firstDetailViewController.detailItem = [NSString stringWithFormat:@"Row %d", indexPath.row];
    
    NSUInteger row = indexPath.row;
    
   
    if(indexPath.row==0){
        FirstDetailViewController *firstDetailViewCOntroller=[[firstDetailViewCOntroller alloc] initWithNibName:@"FirstDetailViewController" bundle:nil];
        UINavigationController *firstDetailNavigationController = [[UINavigationController alloc] initWithRootViewController:firstDetailViewCOntroller];
        [firstDetailViewCOntroller release];
        [self.splitViewController setViewControllers:[NSArray arrayWithObjects:self.navigationController, firstDetailNavigationController, nil]];
        
        
        
        
    }
    
    
    else if( indexPath.row==1){
        
    
    SecondDetailViewController *secondDetailViewController=[[SecondDetailViewController alloc] initWithNibName:@"SecondDetailViewController" bundle:nil];
    UINavigationController *secondDetailNavigationController = [[UINavigationController alloc] initWithRootViewController:secondDetailViewController];
    [secondDetailViewController release];
    [self.splitViewController setViewControllers:[NSArray arrayWithObjects:self.navigationController, secondDetailNavigationController, nil]];
    }
    
    
    
                         
      //  detailViewController = sec;
 
  
    // Update the split view controller's view controllers array.
   // NSArray *viewControllers = [[NSArray alloc] initWithObjects:self.navigationController, detailViewController, nil];
  //  splitViewController.viewControllers=viewControllers;
   // [viewControllers release];
    
  /*  // Dismiss the popover if it's present.
    if (popoverController != nil) {
        [popoverController dismissPopoverAnimated:YES];
    }
    
    // Configure the new view controller's popover button (after the view has been displayed and its toolbar/navigation bar has been created).
    if (rootPopoverButtonItem != nil) {
        [detailViewController showRootPopoverButtonItem:self.rootPopoverButtonItem];
    }
    */
   // [detailViewController release];

}

#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
    self.firstDetailViewController = nil;
    
    [super viewDidUnload];
}

- (void)dealloc {
    [firstDetailViewController release];
    
    [super dealloc];
}

@end


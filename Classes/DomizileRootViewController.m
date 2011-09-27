//
//  RootViewController.m
//  SplitView
//
//  Created by KLM95628 on 3/23/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "DomizileRootViewController.h"
#import "FirstDetailViewController.h"
#import "TabBarWithSplitViewAppDelegate.h"

@implementation DomizileRootViewController
@synthesize firstDetailViewController;
@synthesize array1;

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
    
   
    if(row==0){
        firstDetailViewController=[[FirstDetailViewController alloc] initWithNibName:@"FirstDetailViewController" bundle:nil];
        UINavigationController *firstDetailNavigationController = [[UINavigationController alloc] initWithRootViewController:firstDetailViewController];
        [firstDetailViewController release];
        [self.splitViewController setViewControllers:[NSArray arrayWithObjects:self.navigationController, firstDetailNavigationController, nil]];
        
        
        
        
    }
    
    
    else if(row==1){
        
    
    SecondDetailViewController *secondDetailViewController=[[SecondDetailViewController alloc] initWithNibName:@"SecondDetailViewController" bundle:nil];
    UINavigationController *secondDetailNavigationController = [[UINavigationController alloc] initWithRootViewController:secondDetailViewController];
    [secondDetailViewController release];
    [self.splitViewController setViewControllers:[NSArray arrayWithObjects:self.navigationController, secondDetailNavigationController, nil]];
    }
    
    
    else if (row==2){
        ThirdDetailViewController*thirdDetailViewController=[[ThirdDetailViewController alloc] initWithNibName:@"ThirdDetailViewController" bundle:nil];
        UINavigationController *thirdDetailNavigationController = [[UINavigationController alloc] initWithRootViewController:thirdDetailViewController];
        [thirdDetailViewController release];
        [self.splitViewController setViewControllers:[NSArray arrayWithObjects:self.navigationController, thirdDetailNavigationController, nil]];
        
        
    }
    
    
    else if (row==3){
        FourthDetailViewControllern*fourthDetailViewController=[[FourthDetailViewControllern alloc] initWithNibName:@"FourthDetailViewControllern" bundle:nil];
        UINavigationController *fourthDetailNavigationController = [[UINavigationController alloc] initWithRootViewController:fourthDetailViewController];
        [fourthDetailViewController release];
        [self.splitViewController setViewControllers:[NSArray arrayWithObjects:self.navigationController, fourthDetailNavigationController, nil]];
        
        
        
        
        
        
    }

                         
     

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

//
//  SecondDetailViewController.m
//  TabBarWithSplitView
//
//  Created by Johannes Böhler on 21.09.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "DomizileThirdDetailViewController.h"
#import "SortierenNachPopOver.h"
#import "SuchergebnisseKarte.h"
#import "TabBarWithSplitViewAppDelegate.h"

@implementation DomizileThirdDetailViewController
@synthesize firstTextLabel;
@synthesize listData;
@synthesize domizilCell;
@synthesize table;


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
   
    NSArray *array = [[NSArray alloc] initWithObjects:@"Sleepy", @"Sneezy",@"Bashful", @"Happy", @"Doc", @"Grumpy",@"Dopey", @"Thorin", @"Dorin", @"Nori", @"Ori", @"Balin", @"Dwalin", @"Fili", @"Kili", @"Oin", @"Gloin", @"Bifur", @"Bofur", @"Bombur", nil];
    self.listData = array; 
    [array release];
    
    [super viewDidLoad]; 
    
    
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    NSString *sectionHeader = nil;
    sectionHeader=@"Domizile";
    return  sectionHeader;
    
}

- (void)viewDidUnload
{   self.listData = nil;
    [self setFirstTextLabel:nil];
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

#pragma mark - #pragma mark Table View Data Source Methods 
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section { 
    return [self.listData count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //  static NSString *SimpleTableIdentifier = @"SimpleTableIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: @"DomizilCell"];
    
    if (cell == nil) { 
        NSArray *nib=[[NSBundle mainBundle] loadNibNamed:@"DomizilCellThirdViewController" owner:self options:nil];
        

        //cell = [[[UITableViewCell alloc]
        //initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"DomizilCell"] autorelease];
        cell=self.domizilCell;              
    }
    
    firstTextLabel.text=@"hallo";
    //  cell.imageView.image = image;
    //   cell.detailTextLabel.text=@"Hallo";
    // NSUInteger row = [indexPath row]; cell.textLabel.text = [listData objectAtIndex:row]; 
    return cell;
}
- (void)dealloc {
    [firstTextLabel release];
    [table release];
    [super dealloc];
}
- (IBAction)sortierenNachButtonWasPressed:(id)sender {
    
    
    SortierenNachPopOver *sortierenNachPopOver =[[SortierenNachPopOver alloc] initWithNibName:@"SortierenNachPopOver" bundle:nil];
    
    UIPopoverController *popoverControllerDomiz=[[UIPopoverController alloc] initWithContentViewController:sortierenNachPopOver];
    [popoverControllerDomiz presentPopoverFromRect:[sender frame] inView:self.view permittedArrowDirections:UIPopoverArrowDirectionLeft animated:YES];
}

- (IBAction)karteButtonWasPressed:(id)sender {
    
    TabBarWithSplitViewAppDelegate *appDelegate = (TabBarWithSplitViewAppDelegate *)[[UIApplication sharedApplication] delegate];  
    SuchergebnisseKarte *suchergebnisseKarte=[[SuchergebnisseKarte alloc]initWithNibName:@"SuchergebnisseKarte" bundle:nil];
    
    suchergebnisseKarte.modalPresentationStyle=UIModalPresentationFullScreen;
    suchergebnisseKarte.modalTransitionStyle=UIModalTransitionStylePartialCurl;
    [self presentModalViewController:suchergebnisseKarte animated:YES];
    
    
    
}
@end

//
//  MonatEventDetailView.m
//  TabBarWithSplitView
//
//  Created by Johannes Böhler on 04.10.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "MonatEventDetailView.h"

@implementation MonatEventDetailView
@synthesize detailTable;

@synthesize listData;
@synthesize table;
@synthesize detailTableCell;


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
{   /* NSArray *array = [[NSArray alloc] initWithObjects:@"Sleepy", @"Sneezy",@"Bashful", @"Happy", @"Doc", @"Grumpy",@"Dopey", @"Thorin", @"Dorin", @"Nori", @"Ori", @"Balin", @"Dwalin", @"Fili", @"Kili", @"Oin", @"Gloin", @"Bifur", @"Bofur", @"Bombur", nil];
    */
    listData=  [[NSArray alloc] initWithObjects:@"bla", @"bla1", @"bla2", @"bla3",nil];
   

    //self.listData = array2; 
   // [array release];
    
    [super viewDidLoad];
    
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [self setTable:nil];
    [self setDetailTableCell:nil];
    [self setDetailTable:nil];
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

-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = nil;
    
    
    cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    
    if (cell == nil) {
        NSArray *nib=[[NSBundle mainBundle] loadNibNamed:@"MonatEventDetailTableCell" owner:self options:nil];
        cell = self.detailTableCell;
    }
    // Configure the cell...
        
    return cell;

    }


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //If this is the selected index we need to return the height of the cell
    //in relation to the label height otherwise we just return the minimum label height with padding
    if(selectedIndex == indexPath.row)
    {
//return [self getLabelHeightForIndex:indexPath.row] + COMMENT_LABEL_PADDING * 2;
    }
    else {
        ////return COMMENT_LABEL_MIN_HEIGHT + COMMENT_LABEL_PADDING * 2;
    }
}
    

- (void)dealloc {
    [table release];
    [detailTableCell release];
    [detailTable release];
    [super dealloc];
}
- (IBAction)detailsWasPressed:(id)sender {
    
    [sender resignFirstResponder];
    
    
}
@end

//
//  MonatEventDetailView.m
//  TabBarWithSplitView
//
//  Created by Johannes Böhler on 04.10.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "MonatEventDetailView.h"

@implementation MonatEventDetailView

@synthesize listData;
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
   
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"] autorelease];
    }
    
    // Configure the cell...
    
        cell.textLabel.text = [listData objectAtIndex:indexPath.row];
    
   /* else if (a==1){
             NSLog(@"ich war hier");
         cell.textLabel.text = [array2 objectAtIndex:indexPath.row];}*/
        
    
    return cell;

    }


    
    

- (void)dealloc {
    [table release];
    [super dealloc];
}
@end

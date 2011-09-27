//
//  FirstTableViewController.m
//  TabBarWithSplitView
//
//  Created by MiniMac on 20.09.11.
//  Copyright 2011 neveling.net GmbH. All rights reserved.
//

#import "FirstTableViewController.h"


@implementation FirstTableViewController
@synthesize listData;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{   
    [listData release];
    [super dealloc];
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

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
}
*/

- (void)viewDidUnload
{
    
    self.listData=nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}
-(void)viewDidLoad{
    
    NSArray *array=[[NSArray alloc]initWithObjects:@"Sleepy",@"Sneezy",@"Sleepy2",@"Sneezy2",@"Sleepy4",@"Sneezy6",@"Sleepy8",@"Sneezy9",@"Sleepy10",@"Sneezy11",nil];
    self.listData=array;
    [array release];
    [super viewDidLoad];
    
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}


#pragma mark
#pragma Table View Data Source Methods

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [self.listData count];
}

-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *SimpleTableIdentifier=@"Test";
    
    UITableViewCell *cell= [tableView dequeueReusableCellWithIdentifier:SimpleTableIdentifier];
    if(cell==nil){
        
        cell=[[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:SimpleTableIdentifier]autorelease];
        
    }
    
    NSUInteger row=[indexPath row];
    cell.textLabel.text=[listData objectAtIndex:row];
    return cell;
}

@end

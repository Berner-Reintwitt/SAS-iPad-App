//
//  AuswahlPopUpViewController.m
//  TabBarWithSplitView
//
//  Created by Johannes Böhler on 12.10.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ButtonsPopUpViewController.h"

@implementation ButtonsPopUpViewController

@synthesize array0;
@synthesize array1;
@synthesize array2;
@synthesize array3;
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
    array0=[[NSArray alloc]initWithObjects:@"Alle",@"1-Raum-Appartment",@"2-Raum-Appartment",@"3-Raum-Appartment",@"4-Raum-Appartment",@"Haus",@"Hausteil",nil];
    array1=[[NSArray alloc]initWithObjects:@"Alle",@"Erdgeschoss",@"Obergeschoss", nil];
    array2=[[NSArray alloc]initWithObjects:@"Alle",@"< 50 m^2",@"50 m^2- 80 m^2", @"> 80 m^2", nil];
    array3=[[NSArray alloc]initWithObjects:@"Alle",@"Braderup",@"Hörnum",@"Kampen",@"Keitum",@"List",@"Munkmarsch",@"Wenningstedt",@"Westerland", nil];
   
    self.contentSizeForViewInPopover = CGSizeMake(300.0, 400.0);
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
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
	return YES;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    TabBarWithSplitViewAppDelegate *appDelegate = (TabBarWithSplitViewAppDelegate *)[[UIApplication sharedApplication] delegate];
    if( appDelegate.domizileRootViewController.firstDetailViewController.whichTablePopupView==0){
        return  [self.array0 count];
    }
    else if( appDelegate.domizileRootViewController.firstDetailViewController.whichTablePopupView==1){
        return  [self.array1 count];
    }
    else if( appDelegate.domizileRootViewController.firstDetailViewController.whichTablePopupView==2){
        return  [self.array2 count];
    }
    else if( appDelegate.domizileRootViewController.firstDetailViewController.whichTablePopupView==3){
        return  [self.array3 count];
    }
    
    
}

-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TabBarWithSplitViewAppDelegate *appDelegate = (TabBarWithSplitViewAppDelegate *)[[UIApplication sharedApplication] delegate];
    
    if( appDelegate.domizileRootViewController.firstDetailViewController.whichTablePopupView==0){
        static NSString *CellIdentifier = @"Cell";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if (cell == nil) {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        }
        
        // Configure the cell...
        cell.textLabel.text = [array0 objectAtIndex:indexPath.row];
        return cell;
    }
    
    else if(appDelegate.domizileRootViewController.firstDetailViewController.whichTablePopupView==1){
        static NSString *CellIdentifier = @"Cell";
        
        
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if (cell == nil) {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        }
        
        // Configure the cell...
        cell.textLabel.text = [array1 objectAtIndex:indexPath.row];
        return cell;
    }
    
    
    else if(appDelegate.domizileRootViewController.firstDetailViewController.whichTablePopupView==2){
        static NSString *CellIdentifier = @"Cell";
        
       
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if (cell == nil) {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        }
        
        // Configure the cell...
        cell.textLabel.text = [array2 objectAtIndex:indexPath.row];
        return cell;
    }
    
    else if(appDelegate.domizileRootViewController.firstDetailViewController.whichTablePopupView==3){
        static NSString *CellIdentifier = @"Cell";
        
        
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if (cell == nil) {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        }
        
        // Configure the cell...
        cell.textLabel.text = [array3 objectAtIndex:indexPath.row];
        return cell;
    }


    
    
    
    
}


@end

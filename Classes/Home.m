//
//  SecondViewController.m
//  TabBarWithSplitView
//
//  Created by Bart Bruijnesteijn on 3/23/11.
//  Copyright 2011 PiecesOfMyMind Software. All rights reserved.
//

#import "Home.h"
#import "SearchPopUpViewController.h"
#import "TabBarWithSplitViewAppDelegate.h"
#import "SuchergebnisseKarte.h"
#import "ButtonsPopUpViewController.h"
#import "SuchergebnisseDomizil.h"

#import "CoreData/ObjInfo2+Extensions.h"


@implementation Home

@synthesize table3;
@synthesize popover;
@synthesize  popoverController;
@synthesize listData1;
@synthesize listData2;
@synthesize listData3;
@synthesize table1;
@synthesize table2;

@synthesize homePop;

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}

//-(void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
//    [[NSNotificationCenter defaultCenter] postNotificationName:UIApplicationDidChangeStatusBarOrientationNotification object:self userInfo:nil];
//}

- (void) didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void) viewDidUnload {
    [self setTable1:nil];
    [self setTable2:nil];
    [self setTable3:nil];
  

    [super viewDidUnload];
}

- (void) dealloc {
    [table1 release];
    [table2 release];
    [table3 release];


    [super dealloc];
}

/*- (IBAction) buttonTapped:(id)sender {
    
    SearchPopUpViewController *searchpopup=[[ SearchPopUpViewController alloc]init];
    popover=[[UIPopoverController alloc]initWithContentViewController:searchpopup];
    [searchpopup release];
    [popover presentPopoverFromBarButtonItem:sender permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    
}*/



- (void) viewDidLoad {
    
    appDelegate = (TabBarWithSplitViewAppDelegate *)[[UIApplication sharedApplication] delegate];  
    homePop=[[HomePopUpViewController alloc]initWithNibName:@"HomePopUpViewController" bundle:nil];
    NSArray *array1=[[NSArray alloc]initWithObjects:@"Paul",@"Paul1",@"Paul2",@"Paul4",@"Paul5",nil];
    NSArray *array2=[[NSArray alloc]initWithObjects:@"Hallo",@"Hallo1",@"Hallo2",@"Hallo3",@"Hallo4",@"Hallo5",@"Hallo6",@"Hallo7",@"Hallo8",@"Hallo9",@"Hallo10",@"Hallo11",nil];
    NSArray *array3=[[NSArray alloc]initWithObjects:@"Pallim",@"Pallim2",@"Pallim3",@"Pallim4",@"Pallim5",nil];
    
    self.listData1=array1;
    self.listData2=array2;
    self.listData3=array3;
    
    param=[SearchParameters globalSearchParameters ];
    cellCount=0;
    zielPopOver=YES;
    
    [super viewDidLoad];
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == table1) {
        cellCount = [self.listData1 count];
    } else if (tableView == table2) {
        cellCount = [self.listData2 count];
    } else if (tableView == table3) {
        cellCount = [self.listData3 count];
    }
    return  cellCount;
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = nil;

    if (tableView == table1) {
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        }
        // Configure the cell...
        cell.textLabel.text = [listData1 objectAtIndex:indexPath.row];
    }
    else if (tableView == table2) {
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        }
        // Configure the cell...
        cell.textLabel.text = [listData2 objectAtIndex:indexPath.row];
    }
    else if (tableView == table3) {
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        }
        // Configure the cell...
        cell.textLabel.text = [listData3 objectAtIndex:indexPath.row];
    }
    return cell;
}

-(void)searchPopUpViewWasPressed:(id)sender{
    
    
    
   popoverController=[[UIPopoverController alloc] initWithContentViewController:homePop];
    [popoverController presentPopoverFromRect:[sender frame] inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    
    
}


@end

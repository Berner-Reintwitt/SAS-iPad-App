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

@implementation Home
@synthesize table3;
@synthesize erwachseneStepper;
@synthesize uebernachtungStepper;
@synthesize uebernachtungLabel;
@synthesize erwachseneLabel;
@synthesize anreiseButton;
@synthesize abreiseButton;
@synthesize zielPopOver;
@synthesize  popover;
@synthesize listData1;
@synthesize listData2;
@synthesize listData3;
@synthesize table1;
@synthesize table2;
@synthesize anreiseButtonIsSelected;

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}

//-(void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
//    [[NSNotificationCenter defaultCenter] postNotificationName:UIApplicationDidChangeStatusBarOrientationNotification object:self userInfo:nil];
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
    [self setTable1:nil];
    [self setTable2:nil];
    [self setTable3:nil];
    [self setErwachseneStepper:nil];
    [self setUebernachtungStepper:nil];
    [self setUebernachtungLabel:nil];
    [self setErwachseneLabel:nil];
    [self setAnreiseButton:nil];
    [self setAbreiseButton:nil];
    [super viewDidUnload];
}

- (void)dealloc {
    [table1 release];
    [table2 release];
    [table3 release];
    [erwachseneStepper release];
    [uebernachtungStepper release];
    [uebernachtungLabel release];
    [erwachseneLabel release];
    [anreiseButton release];
    [abreiseButton release];
    [super dealloc];
}

- (IBAction)buttonTapped:(id)sender {
    
    SearchPopUpViewController *searchpopup=[[ SearchPopUpViewController alloc]init];
    popover=[[UIPopoverController alloc]initWithContentViewController:searchpopup];
    [searchpopup release];
    [popover presentPopoverFromBarButtonItem:sender permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    
}

- (IBAction)detailSucheButtonWasPressed:(id)sender {
    
   // UIViewController *viewcontroller=[appDelegate.tabBarController.viewControllers objectAtIndex:2];
    appDelegate.tabBarController.selectedIndex=1;
}


    
    - (IBAction)suchenButtonWasPressed:(id)sender {
        
        
        SuchergebnisseKarte *suchergebnisseKarte=[[SuchergebnisseKarte alloc]initWithNibName:@"SuchergebnisseKarte" bundle:nil];
        
        suchergebnisseKarte.modalPresentationStyle=UIModalPresentationFullScreen;
        suchergebnisseKarte.modalTransitionStyle=UIModalTransitionStyleFlipHorizontal;
        
        //appDelegate.window.rootViewController=navigationControllerModalViews;
        
        [self.navigationController pushViewController:suchergebnisseKarte animated:YES];
        
    
}

- (IBAction)erwachseneStepperWasPressed:(id)sender {
    erwachseneLabel.text =[[NSString alloc]initWithFormat:@"%d",(int)erwachseneStepper.value];
   
    param.adults=erwachseneStepper.value;
}

- (IBAction)uebernachtungStepperWasPressed:(id)sender {
    
    uebernachtungLabel.text=[[NSString alloc]initWithFormat:@"%d",(int)uebernachtungStepper.value];
    
    
}

- (IBAction)zielButtonWasPressed:(id)sender {
    appDelegate.whichTablePopUpView=4;
    ButtonsPopUpViewController *auswahlViewContr =[[ButtonsPopUpViewController alloc] initWithNibName:@"ButtonsPopUpViewController" bundle:nil];
    
    
    [auswahlViewContr.table reloadData];
    UIPopoverController *popoverControllerDomiz=[[UIPopoverController alloc] initWithContentViewController:auswahlViewContr];
    [popoverControllerDomiz presentPopoverFromRect:[sender frame] inView:self.view permittedArrowDirections:UIPopoverArrowDirectionLeft animated:YES];
    

    
    
}

- (IBAction)domizilTypButtonWasPressed:(id)sender {
    appDelegate.whichTablePopUpView=5;
    ButtonsPopUpViewController *auswahlViewContr =[[ButtonsPopUpViewController alloc] initWithNibName:@"ButtonsPopUpViewController" bundle:nil];
 
    [auswahlViewContr.table reloadData];
    UIPopoverController *popoverControllerDomiz=[[UIPopoverController alloc] initWithContentViewController:auswahlViewContr];
    [popoverControllerDomiz presentPopoverFromRect:[sender frame] inView:self.view permittedArrowDirections:UIPopoverArrowDirectionLeft animated:YES];
}

- (IBAction)anreiseButtonIsPressed:(id)sender {
    anreiseButtonIsSelected=YES;
    CalendarPopUpViewController *calenderp=[[CalendarPopUpViewController alloc] initWithNibName:@"CalenderPopUpViewController" bundle:nil];
     UIPopoverController * popoverController=[[UIPopoverController alloc]initWithContentViewController:calenderp];
    [popoverController presentPopoverFromRect:[sender frame] inView:self.view permittedArrowDirections:UIPopoverArrowDirectionLeft animated:YES];
    
}

- (IBAction)abreiseButtonIsPressed:(id)sender {
    anreiseButtonIsSelected=NO;
    CalendarPopUpViewController *calenderp=[[CalendarPopUpViewController alloc] initWithNibName:@"CalenderPopUpViewController" bundle:nil];
    UIPopoverController * popoverController=[[UIPopoverController alloc]initWithContentViewController:calenderp];
    [popoverController presentPopoverFromRect:[sender frame] inView:self.view permittedArrowDirections:UIPopoverArrowDirectionLeft animated:YES];
}

-(void)viewDidLoad{
    anreiseButtonIsSelected=YES;
    appDelegate = (TabBarWithSplitViewAppDelegate *)[[UIApplication sharedApplication] delegate];  
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



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if(tableView == table1) {cellCount=[self.listData1 count];return  cellCount;}
    else if( tableView == table2) {cellCount=[self.listData2 count];return  cellCount;}
    else if( tableView == table3) {cellCount=[self.listData3 count];return  cellCount;}
    
    
}

-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *CellIdentifier = @"Cell";
    

    if (tableView == table1) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
                if (cell == nil) {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        }
    
    // Configure the cell...
	 cell.textLabel.text = [listData1 objectAtIndex:indexPath.row];
    return cell;

    }
    
    else if (tableView == table2) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
        if (cell == nil) {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        }
        
        // Configure the cell...
        cell.textLabel.text = [listData2 objectAtIndex:indexPath.row];
        return cell;       
    }
    
    else if (tableView == table3) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if (cell == nil) {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        }
        
        // Configure the cell...
        cell.textLabel.text = [listData3 objectAtIndex:indexPath.row];
        return cell;       
    }

    
    
    }

@end

//
//  HomePopUpViewController.m
//  TabBarWithSplitView
//
//  Created by Johannes Böhler on 26.10.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "HomePopUpViewController.h"
#import "SuchergebnisseKarte.h"

#import "TabBarWithSplitViewAppDelegate.h"
#import "CoreData/ObjInfo2+Extensions.h"
#import "SuchergebnisseDomizil.h"
#import "Home.h"

@implementation HomePopUpViewController

@synthesize uebernachtungLabel,zielPopOver,uebernachtungStepper,erwachseneStepper,erwachseneLabel,abreiseButton,anreiseButton,anreiseButtonIsSelected;

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

{    appDelegate = (TabBarWithSplitViewAppDelegate *)[[UIApplication sharedApplication] delegate]; 
    param=[SearchParameters globalSearchParameters ];
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


- (IBAction) detailSucheButtonWasPressed:(id)sender {
     
    // UIViewController *viewcontroller=[appDelegate.tabBarController.viewControllers objectAtIndex:2];
    appDelegate.tabBarController.selectedIndex=1;
}

- (IBAction) suchenButtonWasPressed:(id)sender {
   /* SuchergebnisseKarte *suchergebnisseKarte = [[SuchergebnisseKarte alloc]initWithNibName:@"SuchergebnisseKarte" bundle:nil];
    
    suchergebnisseKarte.modalPresentationStyle = UIModalPresentationFullScreen;
    suchergebnisseKarte.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    
    //appDelegate.window.rootViewController=navigationControllerModalViews;
    
    
    NSArray *searchResultList = [ObjInfo2 LocalSearch:[SearchParameters globalSearchParameters]];
    
    SuchergebnisseDomizil *suchergdom=[[SuchergebnisseDomizil alloc]initWithNibName:@"SuchergebnisseDomizil" bundle:nil];
    // [self.view addSubview:suchergdom.view];
    
    
    
    [self.navigationController pushViewController:suchergebnisseKarte animated:YES];*/
    
    
    Home *home =(Home *)[appDelegate.tabBarController.viewControllers objectAtIndex:0];
    [home.popoverController dismissPopoverAnimated:YES];
    appDelegate.tabBarController.selectedIndex=1;
}



- (IBAction) erwachseneStepperWasPressed:(id)sender {
    erwachseneLabel.text =[[NSString alloc]initWithFormat:@"%d",(int)erwachseneStepper.value];
    
    param.adults=erwachseneStepper.value;
}

- (IBAction) uebernachtungStepperWasPressed:(id)sender {
    
    uebernachtungLabel.text=[[NSString alloc]initWithFormat:@"%d",(int)uebernachtungStepper.value];
    
    
}

- (IBAction) zielButtonWasPressed:(id)sender {
    appDelegate.whichTablePopUpView=4;
    ButtonsPopUpViewController *auswahlViewContr =[[ButtonsPopUpViewController alloc] initWithNibName:@"ButtonsPopUpViewController" bundle:nil];
    
    [auswahlViewContr.table reloadData];
    UIPopoverController *popoverControllerDomiz=[[UIPopoverController alloc] initWithContentViewController:auswahlViewContr];
    [popoverControllerDomiz presentPopoverFromRect:[sender frame] inView:self.view permittedArrowDirections:UIPopoverArrowDirectionLeft animated:YES];
    
}

- (IBAction) domizilTypButtonWasPressed:(id)sender {
    appDelegate.whichTablePopUpView = 5;
    ButtonsPopUpViewController *auswahlViewContr =[[ButtonsPopUpViewController alloc] initWithNibName:@"ButtonsPopUpViewController" bundle:nil];
    
    [auswahlViewContr.table reloadData];
    UIPopoverController *popoverControllerDomiz=[[UIPopoverController alloc] initWithContentViewController:auswahlViewContr];
    [popoverControllerDomiz presentPopoverFromRect:[sender frame] inView:self.view permittedArrowDirections:UIPopoverArrowDirectionLeft animated:YES];
}

- (IBAction) anreiseButtonIsPressed:(id)sender {
    anreiseButtonIsSelected = YES;
    CalendarPopUpViewController *calenderp=[[CalendarPopUpViewController alloc] initWithNibName:@"CalenderPopUpViewController" bundle:nil];
    UIPopoverController * popoverController=[[UIPopoverController alloc]initWithContentViewController:calenderp];
    [popoverController presentPopoverFromRect:[sender frame] inView:self.view permittedArrowDirections:UIPopoverArrowDirectionLeft animated:YES];
    
}

- (IBAction) abreiseButtonIsPressed:(id)sender {
    anreiseButtonIsSelected = NO;
    CalendarPopUpViewController *calenderp=[[CalendarPopUpViewController alloc] initWithNibName:@"CalenderPopUpViewController" bundle:nil];
    UIPopoverController * popoverController=[[UIPopoverController alloc]initWithContentViewController:calenderp];
    [popoverController presentPopoverFromRect:[sender frame] inView:self.view permittedArrowDirections:UIPopoverArrowDirectionLeft animated:YES];
}

-(CGSize)contentSizeForViewInPopover{
    
    CGSize cgsize ={ 450 ,400};
    
    return cgsize;
    
}

    



@end

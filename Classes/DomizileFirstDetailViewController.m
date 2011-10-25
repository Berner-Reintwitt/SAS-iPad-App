//
//  ThirdViewController.m
//  SplitView
//
//  Created by Bart Bruijnesteijn on 3/23/11.
//  Copyright 2011 PiecesOfMyMind Software. All rights reserved.
//

#import "DomizileFirstDetailViewController.h"
#import "DomizileRootViewController.h"
#import "SearchPopUpViewController.h"
#import "SuchergebnisseKarte.h"
#import "SuchergebnisseHausDetail.h"
#import "SuchergebnisseDomizil.h"


@interface DomizileFirstDetailViewController ()
- (void)configureView;
@end

@implementation DomizileFirstDetailViewController


@synthesize AnreiseButtonAuswaehlen;
@synthesize fruehesteAnreiseButton;

@synthesize popoverController;
@synthesize frueheAnreiseIsSelected;
@synthesize spaetesteAnreiseButton;
@synthesize uebernachtungInkrementer;
@synthesize uebernachtungInkrementerLabel;
@synthesize erWachseneInkrementer;
@synthesize erwachseneInkrementerLabel;
@synthesize budgetSlider;
@synthesize budgetTextField;
@synthesize whichTablePopupView;
@synthesize selectTablePopUpView;




@synthesize toolbar, barButton, detailItem, detailDescriptionLabel;


#pragma mark -
#pragma mark Managing the detail item

/*
 When setting the detail item, update the view and dismiss the popover controller if it's showing.
 */
- (void)setDetailItem:(id)newDetailItem {
    if (detailItem != newDetailItem) {
        [detailItem release];
        detailItem = [newDetailItem retain];
        
        // Update the view.
        [self configureView];
    }
    
    if (self.popoverController != nil) {
        [self.popoverController dismissPopoverAnimated:YES];
    }               
}


- (void)configureView {
    // Update the user interface for the detail item.
    detailDescriptionLabel.text = [detailItem description];   
}

#pragma mark -
#pragma mark Split view support

- (void)addBarButtonItem:(UIBarButtonItem*)barButtonItem forPopoverController: (UIPopoverController*)pc {
    UIBarButtonItem *first = nil;
    if (toolbar.items.count > 0) {
        first = [toolbar.items objectAtIndex:0];
    }
    
    if (![first.title isEqual:barButtonItem.title])  {
        barButtonItem.title = @"Items List";
        NSMutableArray *items = [[toolbar items] mutableCopy];
        [items insertObject:barButtonItem atIndex:0];
        [toolbar setItems:items animated:YES];
        [items release];
        
        self.popoverController = pc;
    }
}

- (void)removeBarButtonItem {
    if (toolbar.items.count > 0) {
        NSMutableArray *items = [[toolbar items] mutableCopy];
        [items removeObjectAtIndex:0];
        [toolbar setItems:items animated:YES];
        [items release];
        
        // Next line removed to fix bug: popoverController 
        // not dismissed in specific situations
        // self.popoverController = nil;
    }
}

- (IBAction)fruehesteAnreiseButtonWasPressed:(id)sender {
   
    
  [popoverController presentPopoverFromRect:[sender frame] inView:self.view permittedArrowDirections:UIPopoverArrowDirectionLeft animated:YES]; 
    
    frueheAnreiseIsSelected=YES;
    
}


- (IBAction)spaetesteAnreiseButtonWasPressed:(id)sender {
        [popoverController presentPopoverFromRect:[sender frame] inView:self.view permittedArrowDirections:UIPopoverArrowDirectionLeft animated:YES];    
        
        frueheAnreiseIsSelected=false;
    
}

- (IBAction)uebernachtungStepperWasPressed:(id)sender {
    int a= (int)uebernachtungInkrementer.value;
    NSString *inkval= [[NSString alloc]initWithFormat:@"%d",a];
    uebernachtungInkrementerLabel.text= inkval;
    
    
}

- (IBAction)erwachseneStepperWasPressed:(id)sender {
    
    
    int a= (int)erWachseneInkrementer.value;
    NSString *inkval= [[NSString alloc]initWithFormat:@"%d",a];
    erwachseneInkrementerLabel.text=inkval;

    
}

- (IBAction)domizilTypWasPressed:(id)sender {
    TabBarWithSplitViewAppDelegate * appDelegate=(TabBarWithSplitViewAppDelegate *)[[UIApplication sharedApplication] delegate];  

    appDelegate.whichTablePopUpView=0;
    ButtonsPopUpViewController *auswahlViewContr =[[ButtonsPopUpViewController alloc] initWithNibName:@"ButtonsPopUpViewController" bundle:nil];

    
    [auswahlViewContr.table reloadData];
    UIPopoverController *popoverControllerDomiz=[[UIPopoverController alloc] initWithContentViewController:auswahlViewContr];
    [popoverControllerDomiz presentPopoverFromRect:[sender frame] inView:self.view permittedArrowDirections:UIPopoverArrowDirectionLeft animated:YES];
    
}

- (IBAction)etageDesDomizilsWasPressed:(id)sender {
     TabBarWithSplitViewAppDelegate * appDelegate=(TabBarWithSplitViewAppDelegate *)[[UIApplication sharedApplication] delegate]; 
     appDelegate.whichTablePopUpView=1;    
   ButtonsPopUpViewController *auswahlViewContr =[[ButtonsPopUpViewController alloc] initWithNibName:@"ButtonsPopUpViewController" bundle:nil];
     [auswahlViewContr.table reloadData];
    UIPopoverController *popoverControllerDomiz=[[UIPopoverController alloc] initWithContentViewController:auswahlViewContr];
    [popoverControllerDomiz presentPopoverFromRect:[sender frame] inView:self.view permittedArrowDirections:UIPopoverArrowDirectionLeft animated:YES];
   

    
    
}
-(void)navigationBar:(UINavigationBar *)navigationBar didPopItem:(UINavigationItem *)item{
    
    
}

- (IBAction)groesseDesDomizilsWasPressed:(id)sender {
     TabBarWithSplitViewAppDelegate * appDelegate=(TabBarWithSplitViewAppDelegate *)[[UIApplication sharedApplication] delegate]; 
    appDelegate.whichTablePopUpView=2;    
    ButtonsPopUpViewController *auswahlViewContr =[[ButtonsPopUpViewController alloc] initWithNibName:@"ButtonsPopUpViewController" bundle:nil];
    [auswahlViewContr.table reloadData];
    UIPopoverController *popoverControllerDomiz=[[UIPopoverController alloc] initWithContentViewController:auswahlViewContr];
    [popoverControllerDomiz presentPopoverFromRect:[sender frame] inView:self.view permittedArrowDirections:UIPopoverArrowDirectionLeft animated:YES];
    
}

- (IBAction)valueInTextFieldChanged:(id)sender {
    int d= [budgetTextField.text intValue];
    budgetSlider.value=d;
    
}

- (IBAction)sliderValueChanged:(id)sender {
    int sliderValue= budgetSlider.value;
    budgetTextField.text=[NSString stringWithFormat:@"%d", sliderValue];

}

- (IBAction)touchResetTextField:(id)sender {
    int a=0;
    budgetTextField.text=nil;
}




- (IBAction)urlaubsortButtonWasPressed:(id)sender {
     TabBarWithSplitViewAppDelegate * appDelegate=(TabBarWithSplitViewAppDelegate *)[[UIApplication sharedApplication] delegate]; 
    
    appDelegate.whichTablePopUpView=3;
    
    ButtonsPopUpViewController *auswahlViewContr =[[ButtonsPopUpViewController alloc] initWithNibName:@"ButtonsPopUpViewController" bundle:nil];
    [auswahlViewContr.table reloadData];
    UIPopoverController *popoverControllerDomiz=[[UIPopoverController alloc] initWithContentViewController:auswahlViewContr];
    [popoverControllerDomiz presentPopoverFromRect:[sender frame] inView:self.view permittedArrowDirections:UIPopoverArrowDirectionLeft animated:YES];
}

- (IBAction)suchenButtonWasPressed:(id)sender {

    TabBarWithSplitViewAppDelegate * appDelegate=(TabBarWithSplitViewAppDelegate *)[[UIApplication sharedApplication] delegate];
    SuchergebnisseKarte *suchergebnisseKarte=[[SuchergebnisseKarte alloc]initWithNibName:@"SuchergebnisseKarte" bundle:nil];
   
    suchergebnisseKarte.modalPresentationStyle=UIModalPresentationFullScreen;
    suchergebnisseKarte.modalTransitionStyle=UIModalTransitionStyleFlipHorizontal;
   
    SuchergebnisseDomizil *suchergdom=[[SuchergebnisseDomizil alloc]initWithNibName:@"SuchergebnisseDomizil" bundle:nil];
    
   // [self.view addSubview:suchergdom.view];
     
     [appDelegate.tabBarController presentModalViewController:suchergebnisseKarte animated:YES];
    
    
}




- (void)splitViewController: (UISplitViewController*)svc willHideViewController:(UIViewController *)aViewController withBarButtonItem:(UIBarButtonItem*)barButtonItem forPopoverController: (UIPopoverController*)pc {
   
    
    self.barButton = barButtonItem;
    [self addBarButtonItem:barButtonItem forPopoverController:pc];
    
       
        
        
        
    

}

- (void)splitViewController: (UISplitViewController*)svc willShowViewController:(UIViewController *)aViewController invalidatingBarButtonItem:(UIBarButtonItem*)barButtonItem {
    self.barButton = barButtonItem;
    [self removeBarButtonItem];
}



     
    




#pragma mark -
#pragma mark Rotation support

// Ensure that the view controller supports rotation and that the split view can therefore show in both portrait and landscape.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return NO;
}

#pragma mark -
#pragma mark View lifecycle
-(void)viewWillAppear:(BOOL)animated{
    whichTablePopupView=0;
    CalendarPopUpViewController *calenderp=[[CalendarPopUpViewController alloc] initWithNibName:@"CalenderPopUpViewController" bundle:nil];
    
   
    
    popoverController=[[UIPopoverController alloc]initWithContentViewController:calenderp];
    
}

- (void)viewDidUnload {
    self.popoverController = nil;
    self.toolbar = nil;
    
    self.detailItem = nil;
    self.detailDescriptionLabel = nil;
    
    
   
   

    [fruehesteAnreiseLabel release];
    fruehesteAnreiseLabel = nil;
    [self setAnreiseButtonAuswaehlen:nil];
    [AnreiseButtonAuswaehlen release];
    AnreiseButtonAuswaehlen = nil;
    [fruehesteAnreiseButton release];
    fruehesteAnreiseButton = nil;
    [spaetesteAnreiseButton release];
    spaetesteAnreiseButton = nil;
    
    [self setUebernachtungInkrementer:nil];
    [self setUebernachtungInkrementerLabel:nil];
    [self setErWachseneInkrementer:nil];
    [self setErwachseneInkrementerLabel:nil];
   
    [self setBudgetSlider:nil];
    [self setBudgetTextField:nil];
    [super viewDidUnload];
}



-(void)viewDidLoad{
    
    
}

#pragma mark -
#pragma mark Memory management

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    [popoverController release];
    [toolbar release];
    
    [detailItem release];
    [detailDescriptionLabel release];
	
    
    [AnreiseButtonAuswaehlen release];

   
    [fruehesteAnreiseButton release];
  
    [spaetesteAnreiseButton release];
    
    [uebernachtungInkrementer release];
    [uebernachtungInkrementerLabel release];
    [erWachseneInkrementer release];
    [erwachseneInkrementerLabel release];
    
    [budgetSlider release];
    [budgetTextField release];
    [super dealloc];
}




@end

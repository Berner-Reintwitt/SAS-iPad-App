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
    [super viewDidUnload];
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
    [super dealloc];
}




@end

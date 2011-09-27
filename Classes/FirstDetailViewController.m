//
//  ThirdViewController.m
//  SplitView
//
//  Created by Bart Bruijnesteijn on 3/23/11.
//  Copyright 2011 PiecesOfMyMind Software. All rights reserved.
//

#import "FirstDetailViewController.h"
<<<<<<< HEAD
#import "DomizileRootViewController.h"
=======
#import "RootViewController.h"
>>>>>>> 80e8fdcbca094ca3a384ab588ab9e5746df64d92


@interface FirstDetailViewController ()
- (void)configureView;
@end

@implementation FirstDetailViewController

@synthesize AnreiseButtonAuswaehlen;
@synthesize fruehesteAnreiseButton;

@synthesize datePicker;
@synthesize fruehesteAnreiseLabel;
@synthesize spaetesteAnreiseLabel;





@synthesize toolbar, barButton, popoverController, detailItem, detailDescriptionLabel;


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
    [datePicker setHidden:NO]; 
    NSString *date= [[ NSString alloc]initWithFormat:@"%@",datePicker.date]; 
    fruehesteAnreiseLabel.text =date ;
    [fruehesteAnreiseLabel setHidden:NO];
    [AnreiseButtonAuswaehlen setHidden:NO];
    frueherDatePicker=YES;
    
}

- (IBAction)fruehesteAnreiseButtonAuswaehlenWaspressed:(id)sender {
   
    if(frueherDatePicker){
        NSString *date= [[ NSString alloc]initWithFormat:@"%@",datePicker.date]; 
        fruehesteAnreiseLabel.text =date ;
        [fruehesteAnreiseButton setHighlighted:NO];
        [AnreiseButtonAuswaehlen setHidden:YES];
        [datePicker setHidden:YES];
        
    }
    
    else if (!frueherDatePicker){
        
        NSString *date= [[ NSString alloc]initWithFormat:@"%@",datePicker.date]; 
        spaetesteAnreiseLabel.text=date;
        [spaetesteAnreiseButton setHighlighted:NO];
        [AnreiseButtonAuswaehlen setHidden:YES];
        [datePicker setHidden:YES];

    }
}
- (IBAction)spaetesteAnreiseButtonWasPressed:(id)sender {
        [spaetesteAnreiseLabel setHidden:NO];
        NSLog(@"Hallo");
        [datePicker setHidden:NO];
        [AnreiseButtonAuswaehlen setHidden:NO];
        NSString *date= [[ NSString alloc]initWithFormat:@"%@",datePicker.date]; 
        spaetesteAnreiseLabel.text=date;
        frueherDatePicker=false;
    
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

- (void)viewDidUnload {
    self.popoverController = nil;
    self.toolbar = nil;
    
    self.detailItem = nil;
    self.detailDescriptionLabel = nil;
    
    [self setDatePicker:nil];
    [self setDatePicker:nil];
    [datePicker release];
    datePicker = nil;
   

    [fruehesteAnreiseLabel release];
    fruehesteAnreiseLabel = nil;
    [self setAnreiseButtonAuswaehlen:nil];
    [AnreiseButtonAuswaehlen release];
    AnreiseButtonAuswaehlen = nil;
    [fruehesteAnreiseButton release];
    fruehesteAnreiseButton = nil;
    [spaetesteAnreiseButton release];
    spaetesteAnreiseButton = nil;
    [spaetesteAnreiseLabel release];
    spaetesteAnreiseLabel = nil;
    [super viewDidUnload];
}


-(void)viewDidLoad{
    
    CLLocationManager *locationManager=[[CLLocationManager alloc] init];
    locationManager.delegate=self;
    mapView.showsUserLocation=TRUE;
    locationManager.desiredAccuracy=kCLLocationAccuracyBestForNavigation;
    
    [locationManager startUpdatingLocation];
    
    
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation{
	
	location=newLocation.coordinate;
	//One location is obtained.. just zoom to that location
    
	MKCoordinateRegion region;
	region.center=location;
	//Set Zoom level using Span
	MKCoordinateSpan span;
	span.latitudeDelta=.005;
	span.longitudeDelta=.005;
	region.span=span;
    
	[mapView setRegion:region animated:TRUE]; 
    
}

#pragma mark -
#pragma mark Memory management

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    [popoverController release];
    [toolbar release];
    
    [detailItem release];
    [detailDescriptionLabel release];
	
    [datePicker release];
    [datePicker release];
    [datePicker release];
    [fruehesteAnreiseLabel release];
    [AnreiseButtonAuswaehlen release];

   
    [fruehesteAnreiseButton release];
  
    [spaetesteAnreiseButton release];
    [spaetesteAnreiseLabel release];
    [super dealloc];
}

@end

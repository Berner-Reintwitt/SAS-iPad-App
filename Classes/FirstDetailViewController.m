//
//  ThirdViewController.m
//  SplitView
//
//  Created by Bart Bruijnesteijn on 3/23/11.
//  Copyright 2011 PiecesOfMyMind Software. All rights reserved.
//

#import "FirstDetailViewController.h"
#import "RootViewController.h"


@interface FirstDetailViewController ()
- (void)configureView;
@end

@implementation FirstDetailViewController

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
	
    [super dealloc];
}

@end

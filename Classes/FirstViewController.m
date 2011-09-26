//
//  FirstViewController.m
//  TabBarWithSplitView
//
//  Created by Bart Bruijnesteijn on 3/23/11.
//  Copyright 2011 PiecesOfMyMind Software. All rights reserved.
//

#import "FirstViewController.h"
#import "SearchPopUpViewController.h"

@implementation FirstViewController
@synthesize popover;

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}

//-(void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
//    [[NSNotificationCenter defaultCenter] postNotificationName:UIApplicationDidChangeStatusBarOrientationNotification object:self userInfo:nil];
//}


-(void)viewDidLoad{
    
    CLLocationManager *locationManager=[[CLLocationManager alloc] init];
    locationManager.delegate=self;
    mapView.showsUserLocation=TRUE;
    locationManager.desiredAccuracy=kCLLocationAccuracyBestForNavigation;
    
    [locationManager startUpdatingLocation];
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
    [super viewDidUnload];
}
-(void)viewWillAppear:(BOOL)animated{
    
    self.navigationController.toolbar.translucent=YES;
    
}

- (void)dealloc {
    [super dealloc];
}

- (IBAction)buttonPressed:(id)sender {
    
    SearchPopUpViewController *searchpopup=[[ SearchPopUpViewController alloc]init];
    popover=[[UIPopoverController alloc]initWithContentViewController:searchpopup];
    [searchpopup release];
    [popover presentPopoverFromBarButtonItem:sender permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];

    
    
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

@end

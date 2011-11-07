//
//  FirstViewController.m
//  TabBarWithSplitView
//
//  Created by Bart Bruijnesteijn on 3/23/11.
//  Copyright 2011 PiecesOfMyMind Software. All rights reserved.
//

#import "Orte.h"
#import "SearchPopUpViewController.h"

@implementation Orte
@synthesize mapView;
@synthesize popover;
@synthesize orte;

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}

//-(void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
//    [[NSNotificationCenter defaultCenter] postNotificationName:UIApplicationDidChangeStatusBarOrientationNotification object:self userInfo:nil];
//}


-(void)viewDidLoad{
    /*
    Wenningstedt.latitude=54.9333333;
    Wenningstedt.longitude=8.3166667;
    Kampen.latitude=54.95;
    Kampen.longitude=8.35;
    Braderup.latitude=54.8333;
    Braderup.longitude=8.9;
    Keitum.latitude=54.9;
    Keitum.longitude=8.3833333;
    List.latitude=55.0167;
    List.longitude=8.4333;
    Westerland.latitude=54.9;
    Westerland.longitude=8.3;
    Munkmarsch.latitude=54.9166667;
    Munkmarsch.longitude=8.3666667;
    Hoernum.latitude=54.75;
    Hoernum.longitude=8.26667;
    
    
    
    
    CLLocationManager *locationManager=[[CLLocationManager alloc] init];
    locationManager.delegate=self;
    mapView.showsUserLocation=TRUE;
    locationManager.desiredAccuracy=kCLLocationAccuracyBestForNavigation;
    
    [locationManager startUpdatingLocation];*/
    orte=[[NSArray alloc]initWithObjects:@"Wenningstedt",@"Kampen",@"Braderup",@"Keitum",@"List",@"Westerland",@"Munkmarsch",@"Hoernum", nil];
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
    [self setMapView:nil];
    [super viewDidUnload];
}
-(void)viewWillAppear:(BOOL)animated{
    /*MKPointAnnotation *annot = [[MKPointAnnotation alloc] init];
    annot.coordinate = Wenningstedt;
    [self.mapView addAnnotation:annot];
    [annot release];
    MKPointAnnotation *annot1 = [[MKPointAnnotation alloc] init];
    annot1.coordinate=Kampen;
    [self.mapView addAnnotation:annot1];
    [annot1 release];
    MKPointAnnotation *annot2 = [[MKPointAnnotation alloc] init];
    annot2.coordinate=Keitum;
    [self.mapView addAnnotation:annot2];
    [annot2 release];
    

    
    CLLocationCoordinate2D zoomLocation;
    zoomLocation.latitude =54.9333333;
    zoomLocation.longitude=8.3166667;
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(zoomLocation, 10000, 10000);
    MKCoordinateRegion adjustedRegion = [mapView regionThatFits:viewRegion];                
    [mapView setRegion:adjustedRegion animated:YES];   
    */
        
}

- (void)dealloc {
    [mapView release];
    [super dealloc];
}

- (IBAction)buttonPressed:(id)sender {
    
    SearchPopUpViewController *popUpViewController=[[SearchPopUpViewController alloc] initWithNibName:@"OrteAuswahlPopUp" bundle:nil];
    
    
    
    
    popover=[[UIPopoverController alloc]initWithContentViewController:popUpViewController];
    [popUpViewController release];
    
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

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 8;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = nil;
    
    
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        }
        // Configure the cell...
        cell.textLabel.text = [orte objectAtIndex:indexPath.row];

    return cell;
    
    
}

@end

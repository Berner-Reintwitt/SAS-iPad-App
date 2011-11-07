//
//  FirstViewController.h
//  TabBarWithSplitView
//
//  Created by Bart Bruijnesteijn on 3/23/11.
//  Copyright 2011 PiecesOfMyMind Software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/Mapkit.h>
#define METERS_PER_MILE 1609.344

@interface Orte : UIViewController <MKMapViewDelegate,UIPopoverControllerDelegate, UISplitViewControllerDelegate, UITableViewDelegate,UITableViewDataSource>{
    
    UIPopoverController *popover;
    
    
    MKPlacemark *mPlacemark;
	CLLocationCoordinate2D location;
    MKMapView *mapView;
    CLLocationCoordinate2D Wenningstedt;
    CLLocationCoordinate2D Kampen;
    CLLocationCoordinate2D Braderup;
    CLLocationCoordinate2D Keitum;
    CLLocationCoordinate2D List;
    CLLocationCoordinate2D Westerland;
    CLLocationCoordinate2D Munkmarsch;
    CLLocationCoordinate2D Hoernum;
    NSArray *orte;
}

@property (nonatomic, retain)  NSArray *orte;
@property (nonatomic, retain) UIPopoverController *popover;
- (IBAction)buttonPressed:(id)sender;
@property (retain, nonatomic) IBOutlet MKMapView *mapView;

@end

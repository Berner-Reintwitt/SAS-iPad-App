//
//  FirstViewController.h
//  TabBarWithSplitView
//
//  Created by Bart Bruijnesteijn on 3/23/11.
//  Copyright 2011 PiecesOfMyMind Software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/Mapkit.h>
#import "GastronomieSubView.h"
#import "BilderGallerieSubView.h"
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
    IBOutlet UITableViewCell *tableViewCell;
    IBOutlet UILabel *cellTextLabel;
    IBOutlet UIScrollView *scrollView;
    UITableView *table;
    IBOutlet UIView *segmentedControlView;
    IBOutlet UISegmentedControl *segmentedControl;
    GastronomieSubView *gastroSub;
    BilderGallerieSubView *bildgalSub;
    
}
- (IBAction)listWasPressed:(id)sender;
@property (retain, nonatomic) IBOutlet UITableViewCell *tableViewCell;
@property (retain, nonatomic) IBOutlet UILabel *cellTextLabel;
@property (retain, nonatomic) IBOutlet UIScrollView *scrollView;
@property (retain, nonatomic) IBOutlet UITableView *table;
@property (nonatomic, retain)  NSArray *orte;
@property (nonatomic, retain) UIPopoverController *popover;
- (IBAction)buttonPressed:(id)sender;
@property (retain, nonatomic) IBOutlet MKMapView *mapView;
@property (retain, nonatomic) IBOutlet UIView *segmentedControlView;
- (IBAction)segmentedControlValueChanged:(id)sender;
@property (retain, nonatomic) IBOutlet UISegmentedControl *segmentedControl;

@end

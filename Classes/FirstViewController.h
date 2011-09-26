//
//  FirstViewController.h
//  TabBarWithSplitView
//
//  Created by Bart Bruijnesteijn on 3/23/11.
//  Copyright 2011 PiecesOfMyMind Software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/Mapkit.h>

@interface FirstViewController : UIViewController <MKMapViewDelegate,UIPopoverControllerDelegate, UISplitViewControllerDelegate>{
    
    UIPopoverController *popover;
    
    MKMapView *mapView;
    MKPlacemark *mPlacemark;
	CLLocationCoordinate2D location;
}
@property (nonatomic, retain) UIPopoverController *popover;
- (IBAction)buttonPressed:(id)sender;

@end

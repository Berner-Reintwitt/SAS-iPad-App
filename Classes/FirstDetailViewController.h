//
//  ThirdViewController.h
//  SplitView
//
//  Created by Bart Bruijnesteijn on 3/23/11.
//  Copyright 2011 PiecesOfMyMind Software All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/Mapkit.h>
@interface FirstDetailViewController : UIViewController <MKMapViewDelegate,UIPopoverControllerDelegate, UISplitViewControllerDelegate> {
    
    UIPopoverController *popoverController;
    UIToolbar *toolbar;
    UIBarButtonItem *barButton;
    
    id detailItem;
    UILabel *detailDescriptionLabel;
    MKMapView *mapView;
    MKPlacemark *mPlacemark;
	CLLocationCoordinate2D location;

}

@property (nonatomic, retain) IBOutlet UIPopoverController *popoverController;
@property (nonatomic, retain) IBOutlet UIToolbar *toolbar;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *barButton;

@property (nonatomic, retain) id detailItem;
@property (nonatomic, retain) IBOutlet UILabel *detailDescriptionLabel;

- (void)addBarButtonItem:(UIBarButtonItem*)barButtonItem forPopoverController: (UIPopoverController*)pc;
- (void)removeBarButtonItem;

@end

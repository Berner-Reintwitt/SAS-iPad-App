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
   
    IBOutlet UIButton *fruehesteAnreiseButton;
    IBOutlet UILabel *fruehesteAnreiseLabel;
    IBOutlet UIDatePicker *datePicker;
    IBOutlet UIButton *AnreiseButtonAuswaehlen;
    IBOutlet UIButton *spaetesteAnreiseButton;
    IBOutlet UILabel *spaetesteAnreiseLabel;
    Boolean frueherDatePicker;
   }

@property (nonatomic, retain) IBOutlet UIPopoverController *popoverController;
@property (nonatomic, retain) IBOutlet UIToolbar *toolbar;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *barButton;

@property (nonatomic, retain) id detailItem;
@property (nonatomic, retain) IBOutlet UILabel *detailDescriptionLabel;
@property (retain, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (retain, nonatomic) IBOutlet UILabel *fruehesteAnreiseLabel;
@property (retain, nonatomic) IBOutlet UIButton *AnreiseButtonAuswaehlen;
@property (retain, nonatomic) IBOutlet UIButton *fruehesteAnreiseButton;
@property (retain, nonatomic) IBOutlet UILabel *spaetesteAnreiseLabel;


- (void)addBarButtonItem:(UIBarButtonItem*)barButtonItem forPopoverController: (UIPopoverController*)pc;
- (void)removeBarButtonItem;
- (IBAction)fruehesteAnreiseButtonWasPressed:(id)sender;
- (IBAction)fruehesteAnreiseButtonAuswaehlenWaspressed:(id)sender;
- (IBAction)spaetesteAnreiseButtonWasPressed:(id)sender;


@end

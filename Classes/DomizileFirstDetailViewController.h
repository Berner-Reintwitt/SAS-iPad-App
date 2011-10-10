//
//  ThirdViewController.h
//  SplitView
//
//  Created by Bart Bruijnesteijn on 3/23/11.
//  Copyright 2011 PiecesOfMyMind Software All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/Mapkit.h>

#import "CalendarPopUpViewController.h"

@interface DomizileFirstDetailViewController : UIViewController <UIPopoverControllerDelegate, UISplitViewControllerDelegate > {
    
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
    IBOutlet UIButton *AnreiseButtonAuswaehlen;
    IBOutlet UIButton *spaetesteAnreiseButton;
    UIStepper *uebernachtungInkrementer;
    UIStepper *erWachseneInkrementer;
    UILabel *uebernachtungInkrementerLabel;
    UILabel *erwachseneInkrementerLabel;
    Boolean frueheAnreiseIsSelected;
    
    
   }

@property (nonatomic, retain) IBOutlet UIPopoverController *popoverController;
@property (nonatomic, retain) IBOutlet UIToolbar *toolbar;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *barButton;

@property (nonatomic, retain) id detailItem;
@property (nonatomic, retain) IBOutlet UILabel *detailDescriptionLabel;
@property  Boolean frueheAnreiseIsSelected;


@property (retain, nonatomic) IBOutlet UIButton *AnreiseButtonAuswaehlen;
@property (retain, nonatomic) IBOutlet UIButton *fruehesteAnreiseButton;
@property (retain, nonatomic) IBOutlet UIButton *spaetesteAnreiseButton;
@property (retain, nonatomic) IBOutlet UIStepper *uebernachtungInkrementer;
@property (retain, nonatomic) IBOutlet UILabel *uebernachtungInkrementerLabel;
@property (retain, nonatomic) IBOutlet UIStepper *erWachseneInkrementer;
@property (retain, nonatomic) IBOutlet UILabel *erwachseneInkrementerLabel;



- (void)addBarButtonItem:(UIBarButtonItem*)barButtonItem forPopoverController: (UIPopoverController*)pc;
- (void)removeBarButtonItem;
- (IBAction)fruehesteAnreiseButtonWasPressed:(id)sender;
- (IBAction)spaetesteAnreiseButtonWasPressed:(id)sender;
- (IBAction)uebernachtungStepperWasPressed:(id)sender;
- (IBAction)erwachseneStepperWasPressed:(id)sender;



@end

//
//  ThirdViewController.h
//  SplitView
//
//  Created by Bart Bruijnesteijn on 3/23/11.
//  Copyright 2011 PiecesOfMyMind Software All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/Mapkit.h>
#import "ButtonsPopUpViewController.h"
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
    Boolean whichTablePopupView ;
    IBOutlet UIButton *fruehesteAnreiseButton;
    IBOutlet UILabel *fruehesteAnreiseLabel;
    IBOutlet UIButton *AnreiseButtonAuswaehlen;
    IBOutlet UIButton *spaetesteAnreiseButton;
    UIStepper *uebernachtungInkrementer;
    UIStepper *erWachseneInkrementer;
    UILabel *uebernachtungInkrementerLabel;
    UILabel *erwachseneInkrementerLabel;
    Boolean frueheAnreiseIsSelected;
    NSInteger selectTablePopUpView ;
    UISlider *budgetSlider;
    UITextField *budgetTextField;
    
    
   }

@property (nonatomic, retain) IBOutlet UIPopoverController *popoverController;
@property (nonatomic, retain) IBOutlet UIToolbar *toolbar;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *barButton;

@property (nonatomic, retain) id detailItem;
@property (nonatomic, retain) IBOutlet UILabel *detailDescriptionLabel;
@property  Boolean frueheAnreiseIsSelected;
@property  Boolean whichTablePopupView ;
@property NSInteger selectTablePopUpView ;


@property (retain, nonatomic) IBOutlet UIButton *AnreiseButtonAuswaehlen;
@property (retain, nonatomic) IBOutlet UIButton *fruehesteAnreiseButton;
@property (retain, nonatomic) IBOutlet UIButton *spaetesteAnreiseButton;
@property (retain, nonatomic) IBOutlet UIStepper *uebernachtungInkrementer;
@property (retain, nonatomic) IBOutlet UILabel *uebernachtungInkrementerLabel;
@property (retain, nonatomic) IBOutlet UIStepper *erWachseneInkrementer;
@property (retain, nonatomic) IBOutlet UILabel *erwachseneInkrementerLabel;
@property (retain, nonatomic) IBOutlet UISlider *budgetSlider;
@property (retain, nonatomic) IBOutlet UITextField *budgetTextField;



- (void)addBarButtonItem:(UIBarButtonItem*)barButtonItem forPopoverController: (UIPopoverController*)pc;
- (void)removeBarButtonItem;
- (IBAction)fruehesteAnreiseButtonWasPressed:(id)sender;
- (IBAction)spaetesteAnreiseButtonWasPressed:(id)sender;
- (IBAction)uebernachtungStepperWasPressed:(id)sender;
- (IBAction)erwachseneStepperWasPressed:(id)sender;
- (IBAction)domizilTypWasPressed:(id)sender;
- (IBAction)etageDesDomizilsWasPressed:(id)sender;

- (IBAction)urlaubsortButtonWasPressed:(id)sender;
- (IBAction)groesseDesDomizilsWasPressed:(id)sender;
- (IBAction)valueInTextFieldChanged:(id)sender;
- (IBAction)sliderValueChanged:(id)sender;
- (IBAction)touchResetTextField:(id)sender;
- (IBAction)suchenButtonWasPressed:(id)sender;


@end

//
//  HomePopUpViewController.h
//  TabBarWithSplitView
//
//  Created by Johannes Böhler on 26.10.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchParameters.h"
#import "TabBarWithSplitViewAppDelegate.h"


@interface HomePopUpViewController : UIViewController{

Boolean zielPopOver;
UIStepper *erwachseneStepper;
UIStepper *uebernachtungStepper;
UILabel *uebernachtungLabel;
UILabel *erwachseneLabel;
UIButton *anreiseButton;
UIButton *abreiseButton;
Boolean anreiseButtonIsSelected; 
SearchParameters *param;
TabBarWithSplitViewAppDelegate *appDelegate;
    
    
    
}


@property Boolean zielPopOver;
@property (retain, nonatomic) IBOutlet UIStepper *erwachseneStepper;
@property (retain, nonatomic) IBOutlet UIStepper *uebernachtungStepper;
@property (retain, nonatomic) IBOutlet UILabel *uebernachtungLabel;
@property (retain, nonatomic) IBOutlet UILabel *erwachseneLabel;
@property (retain, nonatomic) IBOutlet UIButton *anreiseButton;
@property (retain, nonatomic) IBOutlet UIButton *abreiseButton;
@property Boolean anreiseButtonIsSelected;

- (IBAction)detailSucheButtonWasPressed:(id)sender;
- (IBAction)suchenButtonWasPressed:(id)sender;
- (IBAction)erwachseneStepperWasPressed:(id)sender;
- (IBAction)uebernachtungStepperWasPressed:(id)sender;
- (IBAction)zielButtonWasPressed:(id)sender;
- (IBAction)domizilTypButtonWasPressed:(id)sender;
- (IBAction)anreiseButtonIsPressed:(id)sender;
- (IBAction)abreiseButtonIsPressed:(id)sender;
- (void)changeTab;

@end

//
//  SecondViewController.h
//  TabBarWithSplitView
//
//  Created by Bart Bruijnesteijn on 3/23/11.
//  Copyright 2011 PiecesOfMyMind Software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TabBarWithSplitViewAppDelegate.h"

Boolean zielPopOver;

@interface Home : UIViewController <UITableViewDelegate, UITableViewDataSource, UIPopoverControllerDelegate>{
     NSArray *listData1;
     NSArray *listData2;
     NSArray *listData3;
    UITableView *table1;
    UITableView *table2;
    UITableView *table3;
    NSInteger cellCount;
    UIStepper *erwachseneStepper;
    UIStepper *uebernachtungStepper;
     UILabel *uebernachtungLabel;
    UILabel *erwachseneLabel;
    TabBarWithSplitViewAppDelegate *appDelegate ;
    UIButton *anreiseButton;
    UIButton *abreiseButton;
    Boolean anreiseButtonIsSelected;

   
    
    
    
    
}

@property (nonatomic, retain) UIPopoverController *popover;
@property (nonatomic,retain) NSArray *listData1;
@property (nonatomic,retain) NSArray *listData2;
@property (nonatomic,retain) NSArray *listData3;
@property Boolean zielPopOver;
@property (nonatomic, retain) IBOutlet UITableView *table1;
@property (nonatomic, retain) IBOutlet UITableView *table2;
@property (retain, nonatomic) IBOutlet UITableView *table3;
@property (retain, nonatomic) IBOutlet UIStepper *erwachseneStepper;
@property (retain, nonatomic) IBOutlet UIStepper *uebernachtungStepper;
@property (retain, nonatomic) IBOutlet UILabel *uebernachtungLabel;
@property (retain, nonatomic) IBOutlet UILabel *erwachseneLabel;
@property (retain, nonatomic) IBOutlet UIButton *anreiseButton;
@property (retain, nonatomic) IBOutlet UIButton *abreiseButton;
@property Boolean anreiseButtonIsSelected;

- (IBAction)buttonTapped:(id)sender;
- (IBAction)detailSucheButtonWasPressed:(id)sender;
- (IBAction)suchenButtonWasPressed:(id)sender;
- (IBAction)erwachseneStepperWasPressed:(id)sender;
- (IBAction)uebernachtungStepperWasPressed:(id)sender;
- (IBAction)zielButtonWasPressed:(id)sender;
- (IBAction)domizilTypButtonWasPressed:(id)sender;
- (IBAction)anreiseButtonIsPressed:(id)sender;
- (IBAction)abreiseButtonIsPressed:(id)sender;

@end

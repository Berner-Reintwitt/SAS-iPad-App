//
//  SecondViewController.h
//  TabBarWithSplitView
//
//  Created by Bart Bruijnesteijn on 3/23/11.
//  Copyright 2011 PiecesOfMyMind Software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TabBarWithSplitViewAppDelegate.h"
#import "HomePopUpViewController.h"

Boolean zielPopOver;

@interface Home : UIViewController <UITableViewDelegate, UITableViewDataSource, UIPopoverControllerDelegate>{
     NSArray *listData1;
     NSArray *listData2;
     NSArray *listData3;
    UITableView *table1;
    UITableView *table2;
    UITableView *table3;
    NSInteger cellCount;
    UIPopoverController *popoverController;
 
    TabBarWithSplitViewAppDelegate *appDelegate ;
 
    SearchParameters * param;
    HomePopUpViewController *homePop;
   
    
    
    
    
}

@property (nonatomic, retain) UIPopoverController *popover;
@property (nonatomic,retain) NSArray *listData1;
@property (nonatomic,retain) NSArray *listData2;
@property (nonatomic,retain) NSArray *listData3;

@property (nonatomic, retain) IBOutlet UITableView *table1;
@property (nonatomic, retain) IBOutlet UITableView *table2;
@property (retain, nonatomic) IBOutlet UITableView *table3;
@property (retain, nonatomic) UIPopoverController *popoverController;
@property (retain,nonatomic) IBOutlet HomePopUpViewController *homePop;

- (IBAction)buttonTapped:(id)sender;
- (IBAction)searchPopUpViewWasPressed:(id)sender;
-(void) changeTab;



@end

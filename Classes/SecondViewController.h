//
//  SecondViewController.h
//  TabBarWithSplitView
//
//  Created by Bart Bruijnesteijn on 3/23/11.
//  Copyright 2011 PiecesOfMyMind Software. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface SecondViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>{
     NSArray *listData1;
     NSArray *listData2;
     NSArray *listData3;
    UITableView *table1;
    UITableView *table2;
    UITableView *table3;
    NSInteger cellCount;
    
    
    
    
}

@property (nonatomic, retain) UIPopoverController *popover;
@property (nonatomic,retain) NSArray *listData1;
@property (nonatomic,retain) NSArray *listData2;
@property (nonatomic,retain) NSArray *listData3;

@property (nonatomic, retain) IBOutlet UITableView *table1;
@property (nonatomic, retain) IBOutlet UITableView *table2;
@property (retain, nonatomic) IBOutlet UITableView *table3;

- (IBAction)buttonTapped:(id)sender;

@end

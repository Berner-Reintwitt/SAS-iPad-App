//
//  ThirdDetailViewController.h
//  TabBarWithSplitView
//
//  Created by Johannes Böhler on 27.09.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DomizileThirdDetailViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
{
    UITableViewCell *domizilCell;
    NSArray *listData;
    UILabel *firstTextLabel;
    UITableView *table;
    
} 


@property (retain, nonatomic) IBOutlet UILabel *firstTextLabel;
@property (nonatomic,retain) NSArray *listData;
@property (retain, nonatomic) IBOutlet  UITableViewCell *domizilCell;
@property (retain, nonatomic) IBOutlet UITableView *table;
- (IBAction)sortierenNachButtonWasPressed:(id)sender;
- (IBAction)karteButtonWasPressed:(id)sender;

@end

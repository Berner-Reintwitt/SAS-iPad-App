//
//  SecondDetailViewController.h
//  TabBarWithSplitView
//
//  Created by Johannes Böhler on 21.09.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#define textLabel1	1 
#define textLabel2	2

@interface SecondDetailViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
{
    UITableViewCell *domizilCell;
    NSArray *listData;
    UILabel *firstTextLabel;

} 


@property (retain, nonatomic) IBOutlet UILabel *firstTextLabel;
@property (nonatomic,retain) NSArray *listData;
@property (retain, nonatomic) IBOutlet  UITableViewCell *domizilCell;

@end

//
//  MonatEventDetailView.h
//  TabBarWithSplitView
//
//  Created by Johannes Böhler on 04.10.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class EventRootViewController;
 NSArray *listData;
@interface MonatEventDetailView : UIViewController  <UITableViewDelegate, UITableViewDataSource, UISplitViewControllerDelegate>{
    
    
    NSArray *listData;
    NSArray *array2;
    UITableView *table;
}


@property (nonatomic, retain) NSArray *listData;
@property (retain, nonatomic) IBOutlet UITableView *table;

@end

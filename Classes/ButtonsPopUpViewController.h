//
//  AuswahlPopUpViewController.h
//  TabBarWithSplitView
//
//  Created by Johannes Böhler on 10.10.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TabBarWithSplitViewAppDelegate.h"



@interface ButtonsPopUpViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, UIPopoverControllerDelegate>{
    
    
    NSArray *array0;
    NSArray *array1;
    NSArray *array2;
    NSArray *array3;
    IBOutlet UITableView *table;
    
}
@property (retain, nonatomic) NSArray *array0;
@property (retain, nonatomic) NSArray *array1;
@property (retain, nonatomic) NSArray *array2;
@property (retain, nonatomic) NSArray *array3;
@property (retain, nonatomic) IBOutlet UITableView *table;

@end

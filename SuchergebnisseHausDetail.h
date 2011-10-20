//
//  SuchergebnisseHausDetail.h
//  TabBarWithSplitView
//
//  Created by Johannes Böhler on 19.10.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TKCalendarMonthTableViewController.h"

@interface SuchergebnisseHausDetail : UIViewController <TKCalendarMonthViewDataSource,TKCalendarMonthViewDelegate>
{
    TKCalendarMonthViewController *calender;
    
    
    
}

@property (nonatomic, retain) TKCalendarMonthViewController *calender;

@end

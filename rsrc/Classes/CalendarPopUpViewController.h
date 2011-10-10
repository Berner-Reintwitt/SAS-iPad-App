//
//  CalendarPopUpViewController.h
//  TabBarWithSplitView
//
//  Created by Johannes Böhler on 06.10.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TKCalendarMonthView.h"



@interface CalendarPopUpViewController : UIViewController<TKCalendarMonthViewDelegate, TKCalendarMonthViewDataSource>{
    
    NSDate *date;
    TKCalendarMonthView *calendar;
}
@property (nonatomic, retain) IBOutlet  NSDate *date;

@end

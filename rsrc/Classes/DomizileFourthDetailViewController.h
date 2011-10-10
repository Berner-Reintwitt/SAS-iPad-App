//
//  FourthDetailViewControllern.h
//  TabBarWithSplitView
//
//  Created by Johannes Böhler on 27.09.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <MapKit/Mapkit.h>

@interface DomizileFourthDetailViewController : UIViewController <UITableViewDelegate, UITableViewDataSource,MKMapViewDelegate>
{
    UITableViewCell *domizilCell;
    NSArray *listData;
    UILabel *firstTextLabel;
    
    
} 


@property (retain, nonatomic) IBOutlet UILabel *firstTextLabel;
@property (nonatomic,retain) NSArray *listData;
@property (retain, nonatomic) IBOutlet  UITableViewCell *domizilCell;

@end

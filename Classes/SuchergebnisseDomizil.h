//
//  SuchergebnisseDomizil.h
//  TabBarWithSplitView
//
//  Created by Johannes Böhler on 25.10.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/Mapkit.h>

@interface SuchergebnisseDomizil : UIViewController<UIScrollViewDelegate, UITableViewDelegate,UITableViewDataSource>{
    
    UIScrollView *scrollView;
    MKMapView *mapView;
    UITableView *table;
    UIScrollView *myscrollView;
    UIPageControl *pageControl;
    NSArray * apartments;
    UIImageView *domizilImageView;
    UITableViewCell *domizilCell;
    UILabel *firstTextLabel;

    
    
}
- (IBAction)scroll:(id)sender;
- (IBAction)srollBack:(id)sender;
@property (retain, nonatomic) IBOutlet UIScrollView *scrollView;

@property (retain, nonatomic) IBOutlet MKMapView *mapView;
@property (retain, nonatomic) IBOutlet UITableView *table;
@property (retain, nonatomic) IBOutlet UIScrollView *myscrollView;
@property (retain, nonatomic) IBOutlet UIPageControl *pageControl;
@property (retain, nonatomic) IBOutlet UIImageView *domizilImageView;
@property (retain, nonatomic) IBOutlet  UITableViewCell *domizilCell;
@property (retain, nonatomic) IBOutlet UILabel *firstTextLabel;

@end

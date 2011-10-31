//
//  SuchergebnisseDomizil.h
//  TabBarWithSplitView
//
//  Created by Johannes Böhler on 25.10.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/Mapkit.h>

@interface SuchergebnisseDomizil : UIViewController<UIScrollViewDelegate>{
    
    UIScrollView *scrollView;
    MKMapView *mapView;
    IBOutlet UITableView *table;
    UIScrollView *myscrollView;
    UIPageControl *pageControl;
}
- (IBAction)scroll:(id)sender;
- (IBAction)srollBack:(id)sender;
@property (retain, nonatomic) IBOutlet UIScrollView *scrollView;
- (IBAction)switchFrame:(id)sender;
@property (retain, nonatomic) IBOutlet MKMapView *mapView;
@property (retain, nonatomic) IBOutlet UITableView *table;
@property (retain, nonatomic) IBOutlet UIScrollView *myscrollView;
@property (retain, nonatomic) IBOutlet UIPageControl *pageControl;

@end

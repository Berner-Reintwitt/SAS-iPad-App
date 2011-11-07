//
//  SuchergebnisseDomizil.h
//  TabBarWithSplitView
//
//  Created by Johannes Böhler on 25.10.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/Mapkit.h>
#import "CoreData/ObjInfo2.h"
#import "CoreData/ObjInfo2+Extensions.h"
#import "ObjText.h"

@interface SuchergebnisseDomizil : UIViewController<UIScrollViewDelegate, UITableViewDelegate,UITableViewDataSource, MKMapViewDelegate, UIPageViewControllerDelegate,UIPageViewControllerDataSource>{
    
    UIScrollView *scrollView;
    MKMapView *mapView;
    UITableView *table;
    UIScrollView *myscrollView;
    UIPageControl *pageControl;
    NSArray * apartments;
    UIImageView *domizilImageView;
    UITableViewCell *domizilCell;
    UILabel *firstTextLabel;
    UILabel *reiseZeit;
    UILabel *personenLabel;
    UILabel *preisProWoche;
    UILabel *raueme;
    int row;
    int cellcounter;
    MKPointAnnotation *annot;
    NSMutableDictionary *annotAppartmentDict;
    NSMutableDictionary *apartmentAnnotDict;
    ObjInfo2 *currentObj;
    Boolean detailViewIsActive;
    UITextView *objektBeschreibung;
    UIWebView *webView;
    IBOutlet UILabel *eckdatenWohnfl;
    
    IBOutlet UILabel *eckdatenRaeume;
    IBOutlet UILabel *eckdatenPersonen;
    Boolean rowwasselected;
    IBOutlet UILabel *domizilNameLabelueberBild;
   
   
    
}

- (IBAction)searchResultsButtonWasPressed:(id)sender;

- (IBAction)srollBack:(id)sender;
-(void)fillDetailInfo:(int)rownumber;
@property (retain, nonatomic) IBOutlet UILabel *domizilNameLabelueberBild;

@property (retain, nonatomic) IBOutlet UIScrollView *scrollView;
@property (retain, nonatomic) IBOutlet UILabel *eckdatenPersonen;
@property (retain, nonatomic) IBOutlet UILabel *eckdatenWohnfl;
@property (retain, nonatomic) IBOutlet UILabel *eckdatenRaeume;
@property (retain, nonatomic) IBOutlet MKMapView *mapView;
@property (retain, nonatomic) IBOutlet UITableView *table;
@property (retain, nonatomic) IBOutlet UIScrollView *myscrollView;
@property (retain, nonatomic) IBOutlet UIPageControl *pageControl;
@property (retain, nonatomic) IBOutlet UIImageView *domizilImageView;
@property (retain, nonatomic) IBOutlet  UITableViewCell *domizilCell;
@property (retain, nonatomic) IBOutlet UILabel *firstTextLabel;
@property (retain, nonatomic) IBOutlet UILabel *reiseZeit;
@property (retain, nonatomic) IBOutlet UILabel *personen;
@property (retain, nonatomic) IBOutlet UILabel *preisProWoche;
@property (retain, nonatomic) IBOutlet UILabel *raueme;
@property (retain, nonatomic) IBOutlet UILabel *personenLabel;
@property (retain, nonatomic) IBOutlet UILabel *qualitaet;
@property (retain, nonatomic)  NSMutableDictionary *annotAppartmentDict;
@property (retain, nonatomic)  NSMutableDictionary *appartmentAnnotDict;
@property (retain, nonatomic) IBOutlet UITextView *objektBeschreibung;
@property (retain, nonatomic) IBOutlet UIWebView *webView;


@end

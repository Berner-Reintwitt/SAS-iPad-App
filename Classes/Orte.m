//
//  FirstViewController.m
//  TabBarWithSplitView
//
//  Created by Bart Bruijnesteijn on 3/23/11.
//  Copyright 2011 PiecesOfMyMind Software. All rights reserved.
//

#import "Orte.h"
#import "SearchPopUpViewController.h"

@implementation Orte
@synthesize segmentedControl;
@synthesize mapView;
@synthesize segmentedControlView;
@synthesize popover;
@synthesize tableViewCell;
@synthesize cellTextLabel;
@synthesize scrollView;
@synthesize orte;
@synthesize table;

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}

//-(void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
//    [[NSNotificationCenter defaultCenter] postNotificationName:UIApplicationDidChangeStatusBarOrientationNotification object:self userInfo:nil];
//}


-(void)viewDidLoad{
    /*
    Wenningstedt.latitude=54.9333333;
    Wenningstedt.longitude=8.3166667;
    Kampen.latitude=54.95;
    Kampen.longitude=8.35;
    Braderup.latitude=54.8333;
    Braderup.longitude=8.9;
    Keitum.latitude=54.9;
    Keitum.longitude=8.3833333;
    List.latitude=55.0167;
    List.longitude=8.4333;
    Westerland.latitude=54.9;
    Westerland.longitude=8.3;
    Munkmarsch.latitude=54.9166667;
    Munkmarsch.longitude=8.3666667;
    Hoernum.latitude=54.75;
    Hoernum.longitude=8.26667;
    
    
    
    
    CLLocationManager *locationManager=[[CLLocationManager alloc] init];
    locationManager.delegate=self;
    mapView.showsUserLocation=TRUE;
    locationManager.desiredAccuracy=kCLLocationAccuracyBestForNavigation;
    
    [locationManager startUpdatingLocation];*/
    orte=[[NSArray alloc]initWithObjects:@"Wenningstedt",@"Kampen",@"Braderup",@"Keitum",@"List",@"Westerland",@"Munkmarsch",@"Hoernum", nil];
    
    //scrollView=[[UIScrollView alloc]init];
    scrollView.frame = CGRectMake( 0,330, 1024, 748);
    
    //---set the content size of the scroll view---
    [scrollView setContentSize:CGSizeMake(1725, 740)];
    
    table.bounces=NO;
    CGRect tablerect=CGRectMake(700, 0, 330, 700);
    table=[[UITableView alloc]initWithFrame:tablerect ];
    table.dataSource=self;
    table.delegate=self;
    table.rowHeight=88;
    table.separatorColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:1];
    [scrollView addSubview:table];
    gastroSub=[[GastronomieSubView alloc]initWithNibName:@"GastronomieSubView" bundle:nil];
    bildgalSub=[[BilderGallerieSubView alloc]initWithNibName:@"BilderGallerieSubView" bundle:nil];
    [segmentedControlView addSubview:gastroSub.view];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
    [self setMapView:nil];
    [self setTableViewCell:nil];
    [self setCellTextLabel:nil];
    [self setScrollView:nil];
    [self setSegmentedControlView:nil];
    [self setSegmentedControl:nil];
    [super viewDidUnload];
}
-(void)viewWillAppear:(BOOL)animated{
    /*MKPointAnnotation *annot = [[MKPointAnnotation alloc] init];
    annot.coordinate = Wenningstedt;
    [self.mapView addAnnotation:annot];
    [annot release];
    MKPointAnnotation *annot1 = [[MKPointAnnotation alloc] init];
    annot1.coordinate=Kampen;
    [self.mapView addAnnotation:annot1];
    [annot1 release];
    MKPointAnnotation *annot2 = [[MKPointAnnotation alloc] init];
    annot2.coordinate=Keitum;
    [self.mapView addAnnotation:annot2];
    [annot2 release];
    

    
    CLLocationCoordinate2D zoomLocation;
    zoomLocation.latitude =54.9333333;
    zoomLocation.longitude=8.3166667;
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(zoomLocation, 10000, 10000);
    MKCoordinateRegion adjustedRegion = [mapView regionThatFits:viewRegion];                
    [mapView setRegion:adjustedRegion animated:YES];   
    */
        
}

- (void)dealloc {
    [mapView release];
    [tableViewCell release];
    [cellTextLabel release];
    [scrollView release];
    [segmentedControlView release];
    [segmentedControl release];
    [super dealloc];
}

- (IBAction)buttonPressed:(id)sender {
    
    SearchPopUpViewController *popUpViewController=[[SearchPopUpViewController alloc] initWithNibName:@"OrteAuswahlPopUp" bundle:nil];
    
    
    
    
    popover=[[UIPopoverController alloc]initWithContentViewController:popUpViewController];
    [popUpViewController release];
    
    [popover presentPopoverFromBarButtonItem:sender permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];    
    
}



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 8;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = nil;
    
    
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    

        if (cell == nil) {
            NSArray *nib=[[NSBundle mainBundle] loadNibNamed:@"OrteTableViewCell" owner:self options:nil];
            cell = self.tableViewCell;
        }
        // Configure the cell...
        self.cellTextLabel.text = [orte objectAtIndex:indexPath.row];

    return cell;
    
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CGRect frame;
    frame.origin.x = 700;
    
    frame.origin.y=0;
    frame.size = CGSizeMake(1024, 748);
   // [self fillDetailInfo:indexPath.row];
   // [self.scrollView scrollRectToVisible:frame animated:YES];
    [self.scrollView scrollRectToVisible:CGRectMake(700, 0, 1024, 768) animated:YES];
    
}

- (IBAction)listWasPressed:(id)sender {
    
    NSLog(@"ListwasPRessed");
    
    CGRect frame;
    frame.origin.x = 700;
    
    frame.origin.y=0;
    frame.size = CGSizeMake(1024, 748);
    // [self fillDetailInfo:indexPath.row];
    // [self.scrollView scrollRectToVisible:frame animated:YES];
    [self.scrollView scrollRectToVisible:CGRectMake(700, 0, 1024, 768) animated:YES];
}
- (IBAction)segmentedControlValueChanged:(id)sender {
    
    if (segmentedControl.selectedSegmentIndex==0){
        [segmentedControlView addSubview:gastroSub.view];
        
    }
    
    else if (segmentedControl.selectedSegmentIndex==1){
        
        
        [segmentedControlView addSubview:bildgalSub.view];
        
    }
    
    else{
        
        
        
    }
    
}
@end

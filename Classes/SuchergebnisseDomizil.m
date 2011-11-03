//
//  SuchergebnisseDomizil.m
//  TabBarWithSplitView
//
//  Created by Johannes Böhler on 25.10.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "SuchergebnisseDomizil.h"

#import "CoreData/Queries.h"
#import "CoreData/Utils.h"
#import "CoreData/ObjPicture.h"
#import "CoreData/ScaledImage.h"
#import "SuchergebnisseHausDetail.h"
#import "CoreData/ScaledImage+Extensions.h"

@implementation SuchergebnisseDomizil
@synthesize mapView;
@synthesize table;
@synthesize myscrollView;
@synthesize pageControl;
@synthesize scrollView;
@synthesize domizilImageView;
@synthesize domizilCell;
@synthesize firstTextLabel;
@synthesize reiseZeit;
@synthesize personen;
@synthesize qualitaet;
@synthesize preisProWoche;
@synthesize raueme;
@synthesize personenLabel;
@synthesize annotAppartmentDict;
@synthesize objektBeschreibung;
@synthesize webView;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{   detailViewIsActive=false;
   // scrollView=[[UIScrollView alloc]init];
    CGRect tablerect=CGRectMake(680, 150, 350, 695);
    
    table=[[UITableView alloc]initWithFrame:tablerect ];
    table.dataSource=self;
    table.delegate=self;
    table.rowHeight=92;
    table.separatorColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:1];
   
    
    [scrollView addSubview:table];
    row= -5;
    cellcounter=0;
    
    
    scrollView.frame = CGRectMake( 0,0,1024 , 748);
    
    //---set the content size of the scroll view---
    [scrollView setContentSize:CGSizeMake(1900, 748)];
    NSArray *colors = [NSArray arrayWithObjects:[UIColor redColor], [UIColor greenColor], [UIColor blueColor], [UIColor blackColor],nil];
    /*for (int i = 0; i < colors.count; i++) {
        CGRect frame;
        frame.origin.x = self.myscrollView.frame.size.width * i;
        frame.origin.y = 0;
        frame.size = self.myscrollView.frame.size;
        
        UIView *subview = [[UIView alloc] initWithFrame:frame];
        subview.backgroundColor = [colors objectAtIndex:i];
        [self.myscrollView addSubview:subview];
        pageControl.numberOfPages=[colors count];
        [subview release];
        
        // Do any additional setup after loading the view from its nib.
    }
    self.myscrollView.contentSize = CGSizeMake(self.myscrollView.frame.size.width * colors.count, self.myscrollView.frame.size.height);*/
    
    
    
    
    
    
    //MapView mit den in der Tabelle enthaltenen Domizilen initialisieren
    ObjInfo2 *obj ;
    CLLocationCoordinate2D a;
    apartments= [Queries getAllApartments:managedObjectContext()];
    
    for(obj in apartments){
        
        // [apartments objectAtIndex:obj];
        
        a.latitude=obj.googlemaps_latitude.doubleValue;
        a.longitude= obj.googlemaps_longitude.doubleValue;
        
        annot = [[MKPointAnnotation alloc]init] ;
        annot.coordinate=a;
        annot.title=obj.name;
        annot.subtitle=@"frei";
        
        
        [annotAppartmentDict setObject:obj forKey:annot]; 
        
        
        
        [mapView selectAnnotation:annot animated:YES];
        [self.mapView addAnnotation : annot];
        
        
        
    }
    CLLocationCoordinate2D zoomLocation;
    zoomLocation.latitude =54.9333333;
    zoomLocation.longitude=8.3166667;
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(a, 5000, 5000);
    MKCoordinateRegion adjustedRegion = [mapView regionThatFits:viewRegion];                
    [mapView setRegion:adjustedRegion animated:YES];  
    
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(void)viewDidAppear:(BOOL)animated{
    
    SearchParameters *param=[SearchParameters globalSearchParameters];
    
    [NSDateFormatter setDefaultFormatterBehavior:NSDateFormatterBehavior10_4]; 
    NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init]  autorelease];    
    [dateFormatter setDateStyle:NSDateFormatterFullStyle];
    [dateFormatter setTimeStyle:NSDateFormatterNoStyle]; 
    NSString *dateFrom= [dateFormatter stringFromDate:[param dateFrom]];
    NSString *dateTo= [dateFormatter stringFromDate:[param dateTo]];
    
    

    NSString *a=[NSString stringWithFormat:@"%@%@%@%@",@"Reisezeit: ",dateFrom,@" - ",dateTo];
    reiseZeit.text=(@"%@",a);
    NSString *b=[NSString stringWithFormat:@"%@%d%@%d%@",@"Personen: ",[param adults],@" Erwachsene / ",[param children],@" Kinder "];
    personen.text=b;
    
    
}

- (void)viewDidUnload
{   
    
    [self setMyscrollView:nil];
    [self setPageControl:nil];
    [self setMyscrollView:nil];
    [self setPageControl:nil];
    [self setReiseZeit:nil];
    [self setPersonenLabel:nil];
    [self setPersonen:nil];
    [self setPreisProWoche:nil];
    [self setRaueme:nil];
    [self setPersonenLabel:nil];
    [self setQualitaet:nil];
    [self setObjektBeschreibung:nil];
    [self setWebView:nil];
    [super viewDidUnload];
    [self setScrollView:nil];
    [self setMapView:nil];
    [self setTable:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}


- (void)sroll {
    
    CGRect frame;
    frame.origin.x = mapView.frame.size.width;
    
    frame.origin.y=0;
    frame.size = CGSizeMake(1024, 748);
    
    [self.scrollView scrollRectToVisible:frame animated:YES];
    
    
    
}

- (IBAction)srollBack:(id)sender {
    
    CGRect frame;
    frame.origin.x = 0;
    
    frame.origin.y=0;
    frame.size = CGSizeMake(1024, 748);
    [self.scrollView scrollRectToVisible:frame animated:YES];
}
- (void)dealloc {
    
    [myscrollView release];
    [pageControl release];
    [reiseZeit release];
    [personenLabel release];
    [preisProWoche release];
    [raueme release];
    [personenLabel release];
    [personen release];
    [qualitaet release];
    [objektBeschreibung release];
    [webView release];
    [super dealloc];

    [scrollView release];
    [mapView release];
    
    [myscrollView release];
    [pageControl release];
    [super dealloc];
}





-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    // Update the page when more than 50% of the previous/next page is visible
    CGFloat pageWidth = myscrollView.frame.size.width;
    int page = floor((myscrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    pageControl.currentPage = page;
    
}


- (IBAction)changePage:(id)sender {
    CGRect frame;
    frame.origin.x = self.myscrollView.frame.size.width * self.pageControl.currentPage;
    frame.origin.y = 0;
    frame.size = self.myscrollView.frame.size;
    [self.myscrollView scrollRectToVisible:frame animated:YES];
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section { 
    apartments= [Queries getAllApartments:managedObjectContext()];
    NSInteger count=[apartments count];
    return [apartments count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    apartments = [Queries getAllApartments:managedObjectContext()];
    
    
    
    //  static NSString *SimpleTableIdentifier = @"SimpleTableIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: @"DomizileCell"];
    
    if (cell == nil) { 
        NSArray *nib=[[NSBundle mainBundle] loadNibNamed:@"DomizileCell" owner:self options:nil];
        //cell = [[[UITableViewCell alloc]
        //initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"DomizilCell"] autorelease];
        cell = self.domizilCell;              
    }
    
    
    ObjInfo2 *obj = [apartments objectAtIndex:indexPath.row];
    NSArray *objpics = [obj OrderedPictures];
    ObjPicture *pic = [objpics objectAtIndex:0];
    
    UIImage *img = [pic GetScaledImage:250 withHeight:190 withMode:ScaleModeCrop];

    
    [domizilImageView setImage:img];
    firstTextLabel.text=obj.name;
    
    
    raueme.text =[NSString stringWithFormat:@"%@%@",@"Räume : ",[obj.rooms stringValue]];
    
    
    personenLabel.text=[NSString stringWithFormat:@"%@%@",@"Personen : ",[obj.persons stringValue]];    
    
    NSArray *array = table.indexPathsForSelectedRows;
    

    return cell;
}




-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (row==indexPath.row){ 
        CGRect frame;
        frame.origin.x = mapView.frame.size.width;
        
        frame.origin.y=0;
        frame.size = CGSizeMake(1024, 748);
        
        [self.scrollView scrollRectToVisible:frame animated:YES];
        
        [self fillDetailInfo:indexPath.row];
        
         
       
    }
    
    else {row=indexPath.row;
        [self fillDetailInfo:indexPath.row];
            
        
    }
    
}

/*
-(void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view{
     NSLog(@"bla");
    ObjInfo2 *apartment= [annotAppartmentDict objectForKey:view.annotation];
    if(apartment ==nil){
        
        
        NSLog(@"Fehler");
    }
    
    
    else {
        
        NSLog(@"funktioniert");
    }
    
}*/
    
- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control{
    NSLog(@"bla");
    ObjInfo2 *apartment= [annotAppartmentDict objectForKey:view.annotation];
    if(apartment ==nil){
        
        
        NSLog(@"Fehler");
    }
    
    
    else {
        
        NSLog(@"funktioniert");
    }

    
    
}
    
  
-(void)fillDetailInfo:(int)rownumber{
    
    apartments = [Queries getAllApartments:managedObjectContext()];
    currentObj =[apartments objectAtIndex:row];
    NSArray*objPics=currentObj.OrderedPictures;
    
    
    
    
    UIImage *img=[[UIImage alloc]init];
    
    
    for(int i=0; i<[objPics count];i++){
        NSString *textDescription=nil;
        for(ObjText *ot in currentObj.texts){
            
            if([ot.key compare:@"DESCRIPTION"]==NSOrderedSame){
                textDescription=ot.text;
                break;
                
            }
            
            if(textDescription==nil){
                
                textDescription=@"Ein Domizil zum Wohlfühlen"; 
                
                
            }
        }
            
        objektBeschreibung.text=textDescription;
        [webView loadHTMLString:textDescription baseURL:nil];
        ObjPicture *pic = [objPics objectAtIndex:i];
        CGRect frame;
        frame.origin.x = self.myscrollView.frame.size.width * i;
        frame.origin.y = 0;
        frame.size = self.myscrollView.frame.size;
        
        
        img = [pic GetScaledImage:666 withHeight:272 withMode:ScaleModeCrop];
        UIImageView *imgView=[[UIImageView alloc]initWithFrame:frame];
        imgView.image=img;
        
        [self.myscrollView addSubview:imgView];
        
        
        
        // Do any additional setup after loading the view from its nib.
    }
    self.myscrollView.contentSize = CGSizeMake(self.myscrollView.frame.size.width * objPics.count, self.myscrollView.frame.size.height);
    
    
   
    
}
    



    








@end

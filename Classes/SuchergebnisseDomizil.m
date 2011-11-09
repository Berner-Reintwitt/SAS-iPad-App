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
#import "Search_Result.h"

@implementation SuchergebnisseDomizil

@synthesize mapView;
@synthesize table;
@synthesize myscrollView;
@synthesize pageControl;
@synthesize domizilNameLabelueberBild;
@synthesize scrollView;
@synthesize eckdatenPersonen;
@synthesize eckdatenRaeume;
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
@synthesize eckdatenWohnfl;
@synthesize appartmentAnnotDict;


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
    CGRect tablerect=CGRectMake(670, 150, 350, 550);
    table.bounces=NO;
    table=[[UITableView alloc]initWithFrame:tablerect ];
    table.dataSource=self;
    table.delegate=self;
    table.rowHeight=92;
    table.separatorColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:1];
    alleDomizile=false;
    
    [scrollView addSubview:table];
    row= -5;
    cellcounter=0;
    
    
    scrollView.frame = CGRectMake( 0,0,1024 , 748);
    
    //---set the content size of the scroll view---
    [scrollView setContentSize:CGSizeMake(1900, 748)];
    NSArray *colors = [NSArray arrayWithObjects:[UIColor redColor], [UIColor greenColor], [UIColor blueColor], [UIColor blackColor],nil];
       //MapView mit den in der Tabelle enthaltenen Domizilen initialisieren
    ObjInfo2 *obj ;
    CLLocationCoordinate2D a;
    apartments= [Queries getAllApartments:managedObjectContext()];
    [apartments retain];
    annotAppartmentDict = [NSMutableDictionary dictionaryWithCapacity:300];
    appartmentAnnotDict=[NSMutableDictionary dictionaryWithCapacity:300];
    [annotAppartmentDict retain];
    [appartmentAnnotDict retain];
    
   
    
     
    
    
    
        
        for(int i=0;i<[[Search_Result mySearchresults]count];i++){
            Search_Result *res=[[Search_Result mySearchresults] objectAtIndex:i];
            obj=[Queries getApartment:managedObjectContext() withExID:res.exid];
            
            
            a.latitude=obj.googlemaps_latitude.doubleValue;
            a.longitude= obj.googlemaps_longitude.doubleValue;
            
            annot = [[MKPointAnnotation alloc]init] ;
            annot.coordinate=a;
            annot.title=obj.name;
            annot.subtitle=@"frei";
            NSString *title=[ annot title];
            
            [annotAppartmentDict setObject:obj forKey:annot.title]; 
            [appartmentAnnotDict setObject:annot forKey:obj.exid]; 
            
            
            
            [mapView selectAnnotation:annot animated:YES];
            [self.mapView addAnnotation : annot];
            
            
            
        }
        
        
        
        
        
        
    
    
    
    CLLocationCoordinate2D zoomLocation;
    zoomLocation.latitude =54.9333333;
    zoomLocation.longitude=8.3166667;
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(a, 5000, 5000);
    MKCoordinateRegion adjustedRegion = [mapView regionThatFits:viewRegion];                
    [mapView setRegion:adjustedRegion animated:YES];  
    NSIndexPath *indpath=[NSIndexPath indexPathForRow:0 inSection:0];
    [table selectRowAtIndexPath:indpath animated:YES scrollPosition:UITableViewScrollPositionTop];
    
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
    [self setEckdatenRaeume:nil];
    [self setEckdatenPersonen:nil];
    [eckdatenWohnfl release];
    eckdatenWohnfl = nil;
    [self setDomizilNameLabelueberBild:nil];
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

- (IBAction)alleDomizileWasPressed:(id)sender {
    
    
    alleDomizile=true;
    ObjInfo2 *obj ;
    CLLocationCoordinate2D a;
    
    for(obj in apartments){
        
        // [apartments objectAtIndex:obj];
        
        a.latitude=obj.googlemaps_latitude.doubleValue;
        a.longitude= obj.googlemaps_longitude.doubleValue;
        
        annot = [[MKPointAnnotation alloc]init] ;
        annot.coordinate=a;
        annot.title=obj.name;
        annot.subtitle=@"frei";
        NSString *title=[ annot title];
        
        [annotAppartmentDict setObject:obj forKey:annot.title]; 
        [appartmentAnnotDict setObject:annot forKey:obj.exid]; 
        
        
        
        [mapView selectAnnotation:annot animated:YES];
        [self.mapView addAnnotation : annot];
        
        
        
    }
    [table reloadData];
    
    
}

- (IBAction)suchButtonWasPressed:(id)sender {
    
    
    alleDomizile=false;
    [table reloadData];
    NSArray *annotAr=[[NSArray alloc]init];
    for(int i=0;i<[apartmentAnnotDict count];i++){
        
       annotAr= [apartmentAnnotDict mutableArrayValueForKey:[apartments objectAtIndex:i]];
        
        
        
    }
    
    
    [mapView removeAnnotations:annotAr];
     [table reloadData];
}

- (IBAction)searchResultsButtonWasPressed:(id)sender {
    
    [self srollBack:sender];
    
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
    
    [eckdatenRaeume release];
    [eckdatenPersonen release];
    [eckdatenWohnfl release];
    [domizilNameLabelueberBild release];
   
   
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
       
    if(alleDomizile==true){ 
        NSInteger count=[apartments count];
        return [apartments count];
    }
    
    else {return[[Search_Result mySearchresults]count]; }
    
    
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
   
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: @"DomizileCell"];
    
    if (cell == nil) { 
        NSArray *nib=[[NSBundle mainBundle] loadNibNamed:@"DomizileCell" owner:self options:nil];
        
        cell = self.domizilCell;              
    }
    
   
    if(alleDomizile==true){
   
    
    
    ObjInfo2 *obj = [apartments objectAtIndex:indexPath.row];
    NSArray *objpics = [obj OrderedPictures];
    ObjPicture *pic = [objpics objectAtIndex:0];
    
    UIImage *img = [pic GetScaledImage:250 withHeight:190 withMode:ScaleModeCrop];

    
    [domizilImageView setImage:img];
    firstTextLabel.text=obj.name;
    
    
    raueme.text =[NSString stringWithFormat:@"%@%@",@"Räume : ",[obj.rooms stringValue]];
    
    
    personenLabel.text=[NSString stringWithFormat:@"%@%@",@"Personen : ",[obj.persons stringValue]];    
    
    NSArray *array = table.indexPathsForSelectedRows;
    

    return cell;}
    
    else{    
    Search_Result *res=[[Search_Result mySearchresults] objectAtIndex:indexPath.row];
    
    ObjInfo2 *obj = [Queries getApartment:managedObjectContext() withExID:res.exid];
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
    
    
    
    
}




-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (row!=indexPath.row)
        {row=indexPath.row;
         [self fillDetailInfo:indexPath.row];
            ObjInfo2 *obj;
            if(alleDomizile==true) {
                obj=[apartments objectAtIndex:row];
            }
            
            else{
                Search_Result *res=[[Search_Result mySearchresults] objectAtIndex:row];
                obj=[Queries getApartment:managedObjectContext() withExID:res.exid];
            }
        
        MKPointAnnotation *pointann=[appartmentAnnotDict objectForKey:obj.exid];
        [mapView selectAnnotation:pointann animated:NO];
        
        
        
    }

    else { 
        CGRect frame;
        frame.origin.x = mapView.frame.size.width+10;
        
        frame.origin.y=0;
        frame.size = CGSizeMake(1024, 748);
        [self fillDetailInfo:indexPath.row];
        [self.scrollView scrollRectToVisible:frame animated:YES];
        
        
        
         
       
    }
    
        
}





-(void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view{
    ObjInfo2 *apartment= [annotAppartmentDict objectForKey:[view.annotation title]];
   
    
    
    
        
        int rownumber;
        
        if(alleDomizile==true){
            for(rownumber=0;rownumber<[apartments count];++rownumber){
                if(apartment==[apartments objectAtIndex:rownumber]){
                    
                    break;
                    
                }
                
                
            }
            
            if(rownumber>=[apartments count]){
                
                NSLog(@"apartment is not listed");
                return;
            }
            
        }
        
        else{ 
            
            for(rownumber=0;rownumber<[[Search_Result mySearchresults]count];++rownumber){
            
            Search_Result *res=[[Search_Result mySearchresults] objectAtIndex:rownumber];
            
            if(apartment== [Queries getApartment:managedObjectContext() withExID:res.exid]){
                ;
                break;
                
            }
            
            
        }
            
            if(rownumber>=[[Search_Result mySearchresults]count]){
                
                NSLog(@"apartment is not listed");
                return;
            }
            
            
            
            
            
            
            
            
            
        }
    
    NSIndexPath *path= [NSIndexPath indexPathForRow:rownumber inSection:0];
    
    
    [table selectRowAtIndexPath:path animated:YES scrollPosition:UITableViewScrollPositionTop];
    
    
}
    
- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control{
    NSLog(@"bla");
    NSString *title=[[view annotation ]title];
    ObjInfo2 *apartment= [annotAppartmentDict objectForKey:[[view annotation ]title] ];
    if(apartment ==nil){
        
        
        NSLog(@"calloutaccessory tapped nil");
    }
    
    
    else {
        
        NSLog(@"did select annot not nil");
        int rownumber;
      
        
        if(alleDomizile==true){
        
        
        for(rownumber=0;rownumber<[apartments count];++rownumber){
            if(apartment==[apartments objectAtIndex:rownumber]){
                
                break;
                
            }
            
            
        }
        
        if(rownumber>=[apartments count]){
            
            NSLog(@"apartment is not listed");
            return;
        }
        }
        
        else {
            for(rownumber=0;rownumber<[[Search_Result mySearchresults]count];++rownumber){
            Search_Result *res=[[Search_Result mySearchresults] objectAtIndex:rownumber];
            if( apartment== [Queries getApartment:managedObjectContext() withExID:res.exid]){
                
                
                break;
                
                
            }
            
        }
            
            if(rownumber>=[[Search_Result mySearchresults]count]){
                
                NSLog(@"apartment is not listed");
                return;
            }
        }
        
        NSIndexPath *path= [NSIndexPath indexPathForRow:rownumber inSection:0];
        [self tableView:table didSelectRowAtIndexPath:path];
        [self tableView:table didSelectRowAtIndexPath:path];
            
        
        
        
    }


    
    
}



- (MKAnnotationView *) mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>) annotation{
    MKPinAnnotationView *annView=[[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"currentloc"];
    annView.pinColor = MKPinAnnotationColorRed;
    
    UIButton *advertButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    advertButton.frame = CGRectMake(0, 0, 25, 25);
    advertButton.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    advertButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    
   // [advertButton setImage:[UIImage imageNamed:@"pig.png"] forState:UIControlStateNormal];
    //[advertButton addTarget:self action:@selector(showLinks:) forControlEvents:UIControlEventTouchUpInside];
    
    annView.rightCalloutAccessoryView = advertButton;
    
    //annView.animatesDrop=TRUE;
    annView.canShowCallout = YES;
    annView.calloutOffset = CGPointMake(-5, 5);
    return annView;
}
    
  
-(void)fillDetailInfo:(int)rownumber{
    int i=0;
    
    if (alleDomizile==true) currentObj =[apartments objectAtIndex:row];
    
    
    else{
        Search_Result *result=[[Search_Result mySearchresults]objectAtIndex:row];
        currentObj =[Queries getApartment:managedObjectContext() withExID:result.exid];
    }
    NSArray*objPics=currentObj.OrderedPictures;
    
    
    
    
    UIImage *img=[[UIImage alloc]init];
    
     NSString *textDescription=nil;
    for(i=0; i<[objPics count];i++){
       
        for(ObjText *ot in currentObj.texts){
            
            if([ot.key compare:@"DESCRIPTION"]==NSOrderedSame){
                textDescription=ot.text;
                break;
                
            }
            
            if(textDescription==nil){
                
                textDescription=@"Ein Domizil zum Wohlfühlen"; 
                
                
            }
        }
            
       
        
        
        
        
        
        ObjPicture *pic = [objPics objectAtIndex:i];
        CGRect frame;
        frame.origin.x = self.myscrollView.frame.size.width * i;
        frame.origin.y = 0;
        frame.size = self.myscrollView.frame.size;
        
        
        img = [pic GetScaledImage:351 withHeight:301 withMode:ScaleModeCrop];
        UIImageView *imgView=[[UIImageView alloc]initWithFrame:frame];
        imgView.image=img;
        
        [self.myscrollView addSubview:imgView];
        [myscrollView scrollRectToVisible:CGRectMake(0, 0, myscrollView.frame.size.width, myscrollView.frame.size.height)animated:YES];
        
        
        
        // Do any additional setup after loading the view from its nib.
    }
    self.myscrollView.contentSize = CGSizeMake(self.myscrollView.frame.size.width * objPics.count, self.myscrollView.frame.size.height);
    domizilNameLabelueberBild.text=currentObj.name;
    objektBeschreibung.text=textDescription;
    [webView loadHTMLString:textDescription baseURL:nil];
    eckdatenWohnfl.text=currentObj.living_area.stringValue;
    eckdatenRaeume.text=[NSString stringWithFormat:@"%@%@", currentObj.rooms.stringValue,@" m²"]  ;
    eckdatenPersonen.text=currentObj.persons.stringValue;
    
   
    
}
    



    








@end

//
//  CalendarPopUpViewController.m
//  TabBarWithSplitView
//
//  Created by Johannes Böhler on 06.10.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "CalendarPopUpViewController.h"
#import "Home.h"


@implementation CalendarPopUpViewController

@synthesize date;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        calendar = 	[[TKCalendarMonthView alloc] init];
		calendar.delegate = self;
		calendar.dataSource = self;
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

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
}
*/
-(void)viewDidLoad{
    
    calendar.frame = CGRectMake(0, 0, calendar.frame.size.width, calendar.frame.size.height);
    
	// Ensure this is the last "addSubview" because the calendar must be the top most view layer	
	[self.view addSubview:calendar];
	[calendar reload];
    /*CGRect myFrame = CGRectMake(0, 0, 320, 50);
    UIView *myView = [[UIView alloc] initWithFrame:myFrame];
    myView.backgroundColor = [UIColor blueColor];
    [self.view addSubview:myView];
    [myView release];*/

}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}

#pragma mark -
#pragma mark TKCalendarMonthViewDelegate methods

- (void)calendarMonthView:(TKCalendarMonthView *)monthView didSelectDate:(NSDate *)d {
	
    TabBarWithSplitViewAppDelegate *appDelegate = (TabBarWithSplitViewAppDelegate *)[[UIApplication sharedApplication] delegate];
   
    Home *h=(Home *)[appDelegate.tabBarController.viewControllers objectAtIndex:0] ;
                                           
    // Verhalten für den NSDateFormatter festlegen
    [NSDateFormatter setDefaultFormatterBehavior:NSDateFormatterBehavior10_4]; 
    
    // NSDateFormatter Objekt erzeugen
    NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init]  autorelease]; 
    
    // Style für das Datum festlegen    
    [dateFormatter setDateStyle:NSDateFormatterFullStyle];
    
    // Style für die Zeit festlegen
    [dateFormatter setTimeStyle:NSDateFormatterNoStyle]; // keine Zeitangabe 
    
    // konvertiert das NSDate vom DatePicker in einen String 
    
   
   NSString *st= [dateFormatter stringFromDate:d];
    date1=[[ NSString alloc]initWithFormat:@"%@",st]; 
    
   
        
    
    
    if(appDelegate.domizileRootViewController.firstDetailViewController.frueheAnreiseIsSelected==YES&&appDelegate.tabBarController.selectedIndex==1){
        [appDelegate.domizileRootViewController.firstDetailViewController.fruehesteAnreiseButton setTitle:date1 forState:UIControlStateNormal];}
    
    else if(appDelegate.domizileRootViewController.firstDetailViewController.frueheAnreiseIsSelected==NO&&appDelegate.tabBarController.selectedIndex==1){ 
        
        [appDelegate.domizileRootViewController.firstDetailViewController.spaetesteAnreiseButton setTitle:date1 forState:UIControlStateNormal];
        
    }
    
    
    else if(h.homePop.anreiseButtonIsSelected&&appDelegate.tabBarController.selectedIndex==0){ 
        
        
        [h.homePop.anreiseButton setTitle:date1 forState:UIControlStateNormal];
        SearchParameters *param=[SearchParameters globalSearchParameters];
        param.dateFrom=d;
        
        
    }
    
    else if(!h.homePop.anreiseButtonIsSelected&&appDelegate.tabBarController.selectedIndex==0){ 
        
        
        
        SearchParameters *param=[SearchParameters globalSearchParameters];
        param.dateTo=d;
        if(param.dateTo.timeIntervalSince1970>param.dateFrom.timeIntervalSince1970){
           
           [h.homePop.abreiseButton setTitle:date1 forState:UIControlStateNormal];
        }
        NSLog(@"%@",param.dateTo);
        
        
    }
    

   
        
}

- (void)calendarMonthView:(TKCalendarMonthView *)monthView monthDidChange:(NSDate *)d {
	NSLog(@"calendarMonthView monthDidChange");	
}

#pragma mark -
#pragma mark TKCalendarMonthViewDataSource methods

- (NSArray*)calendarMonthView:(TKCalendarMonthView *)monthView marksFromDate:(NSDate *)startDate toDate:(NSDate *)lastDate {	
	NSLog(@"calendarMonthView marksFromDate toDate");	
	NSLog(@"Make sure to update 'data' variable to pull from CoreData, website, User Defaults, or some other source.");
	// When testing initially you will have to update the dates in this array so they are visible at the
	// time frame you are testing the code.
	NSArray *data = [NSArray arrayWithObjects:
					 nil]; 
	
	
	// Initialise empty marks array, this will be populated with TRUE/FALSE in order for each day a marker should be placed on.
	NSMutableArray *marks = [NSMutableArray array];
	
	// Initialise calendar to current type and set the timezone to never have daylight saving
	NSCalendar *cal = [NSCalendar currentCalendar];
	[cal setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
	
	// Construct DateComponents based on startDate so the iterating date can be created.
	// Its massively important to do this assigning via the NSCalendar and NSDateComponents because of daylight saving has been removed 
	// with the timezone that was set above. If you just used "startDate" directly (ie, NSDate *date = startDate;) as the first 
	// iterating date then times would go up and down based on daylight savings.
	NSDateComponents *comp = [cal components:(NSMonthCalendarUnit | NSMinuteCalendarUnit | NSYearCalendarUnit | 
											  NSDayCalendarUnit | NSWeekdayCalendarUnit | NSHourCalendarUnit | NSSecondCalendarUnit) 
									fromDate:startDate];
	NSDate *d = [cal dateFromComponents:comp];
	
	// Init offset components to increment days in the loop by one each time
	NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
	[offsetComponents setDay:1];	
	
	
	// for each date between start date and end date check if they exist in the data array
	while (YES) {
		// Is the date beyond the last date? If so, exit the loop.
		// NSOrderedDescending = the left value is greater than the right
		if ([d compare:lastDate] == NSOrderedDescending) {
			break;
		}
		
		// If the date is in the data array, add it to the marks array, else don't
		if ([data containsObject:[d description]]) {
			[marks addObject:[NSNumber numberWithBool:YES]];
		} else {
			[marks addObject:[NSNumber numberWithBool:NO]];
		}
		
		// Increment day using offset components (ie, 1 day in this instance)
		d = [cal dateByAddingComponents:offsetComponents toDate:d options:0];
	}
	
	[offsetComponents release];
	
	return [NSArray arrayWithArray:marks];
}

-(CGSize)contentSizeForViewInPopover{
    
    CGSize cgsize ={ calendar.frame.size.width ,calendar.frame.size.height};
    
    return cgsize;
    
}





@end

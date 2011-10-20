//
//  SecondDetailViewController.m
//  TabBarWithSplitView
//
//  Created by Johannes Böhler on 21.09.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "DomizileSecondDetailViewController.h"
#import "SortierenNachPopOver.h"
#import "TabBarWithSplitViewAppDelegate.h"
#import "SuchergebnisseKarte.h"
#import "CoreData/ObjInfo2.h"
#import "CoreData/Queries.h"
#import "CoreData/Utils.h"
#import "CoreData/ObjPicture.h"
#import "CoreData/ScaledImage.h"

@implementation DomizileSecondDetailViewController
@synthesize firstTextLabel;
@synthesize listData;
@synthesize domizilCell;
@synthesize domizilImageView;


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
{
    
    NSArray *array = [[NSArray alloc] initWithObjects:@"Sleepy", @"Sneezy",@"Bashful", @"Happy", @"Doc", @"Grumpy",@"Dopey", @"Thorin", @"Dorin", @"Nori", @"Ori", @"Balin", @"Dwalin", @"Fili", @"Kili", @"Oin", @"Gloin", @"Bifur", @"Bofur", @"Bombur", nil];
    self.listData = array; 
    [array release];
    
    [super viewDidLoad];
    
   
}

- (void)viewDidUnload
{   self.listData = nil;
    [self setFirstTextLabel:nil];
    [self setDomizilImageView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}

#pragma mark - #pragma mark Table View Data Source Methods 
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section { 
    return [self.listData count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
      //  static NSString *SimpleTableIdentifier = @"SimpleTableIdentifier";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: @"DomizilCell"];
           
        if (cell == nil) { 
            NSArray *nib=[[NSBundle mainBundle] loadNibNamed:@"DomizilCell" owner:self options:nil];
            //cell = [[[UITableViewCell alloc]
                            //initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"DomizilCell"] autorelease];
            cell=self.domizilCell;              
                    }
        NSUInteger row = [indexPath row];
    NSArray * apartments= [Queries getAllApartments:managedObjectContext()];
    ObjInfo2 *obj=[apartments objectAtIndex:row];
    NSArray *objpics=obj.pictures.allObjects;
    ObjPicture *pic = [objpics objectAtIndex:0];
    ScaledImage *scalepic=pic.images.anyObject;
  //  UIImage * img=getCFImageRef(scalepic);
    UIImage *img2=[UIImage imageNamed:@"pig.png"];  
    
 
    
    [domizilImageView setImage:img2];
    
    
    
    
        firstTextLabel.text=obj.name;
    
      //  cell.imageView.image = image;
     //   cell.detailTextLabel.text=@"Hallo";
       // NSUInteger row = [indexPath row]; cell.textLabel.text = [listData objectAtIndex:row]; 
        return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    NSString *sectionHeader = nil;
    sectionHeader=@"Domizile";
    return  sectionHeader;
    
}
- (void)dealloc {
    [firstTextLabel release];
    [domizilImageView release];
    [super dealloc];
}
- (IBAction)sortierenButtonWasPressed:(id)sender {
    
   SortierenNachPopOver *sortierenNachPopOver =[[SortierenNachPopOver alloc] initWithNibName:@"SortierenNachPopOver" bundle:nil];
    
    UIPopoverController *popoverControllerDomiz=[[UIPopoverController alloc] initWithContentViewController:sortierenNachPopOver];
    [popoverControllerDomiz presentPopoverFromRect:[sender frame] inView:self.view permittedArrowDirections:UIPopoverArrowDirectionLeft animated:YES];

}

- (IBAction)karteButtonWasPressed:(id)sender {
     TabBarWithSplitViewAppDelegate *appDelegate = (TabBarWithSplitViewAppDelegate *)[[UIApplication sharedApplication] delegate];  
    SuchergebnisseKarte *suchergebnisseKarte=[[SuchergebnisseKarte alloc]initWithNibName:@"SuchergebnisseKarte" bundle:nil];
   
    suchergebnisseKarte.modalPresentationStyle=UIModalPresentationFullScreen;
    [self presentModalViewController:suchergebnisseKarte animated:YES];
   // [self.view addSubview:suchergebnisseKarte.view];
    
}
@end

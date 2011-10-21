//
//  AuswahlPopUpViewController.m
//  TabBarWithSplitView
//
//  Created by Johannes Böhler on 12.10.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ButtonsPopUpViewController.h"
#import "Home.h"

@implementation ButtonsPopUpViewController

@synthesize array0;
@synthesize array1;
@synthesize array2;
@synthesize array3;
@synthesize table;

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
    array0=[[NSArray alloc]initWithObjects:@"Alle",@"1-Raum-Appartment",@"2-Raum-Appartment",@"3-Raum-Appartment",@"4-Raum-Appartment",@"Haus",@"Hausteil",nil];
    array1=[[NSArray alloc]initWithObjects:@"Alle",@"Erdgeschoss",@"Obergeschoss", nil];
    array2=[[NSArray alloc]initWithObjects:@"Alle",@"< 50 m^2",@"50 m^2- 80 m^2", @"> 80 m^2", nil];
    array3=[[NSArray alloc]initWithObjects:@"Alle",@"Braderup",@"Hörnum",@"Kampen",@"Keitum",@"List",@"Munkmarsch",@"Wenningstedt",@"Westerland", nil];
   
    self.contentSizeForViewInPopover = CGSizeMake(300.0, 400.0);
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
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

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    TabBarWithSplitViewAppDelegate *appDelegate = (TabBarWithSplitViewAppDelegate *)[[UIApplication sharedApplication] delegate];
    if( appDelegate.whichTablePopUpView==0){
        return  [self.array0 count];
    }
    else if( appDelegate.whichTablePopUpView==1){
        return  [self.array1 count];
    }
    else if( appDelegate.whichTablePopUpView==2){
        return  [self.array2 count];
    }
    else if( appDelegate.whichTablePopUpView==3){
        return  [self.array3 count];
    }
    else if( appDelegate.whichTablePopUpView==4){
        return  [self.array3 count];
    }
    else if( appDelegate.whichTablePopUpView==5){
        return  [self.array0 count];
    }
    
    
}

-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TabBarWithSplitViewAppDelegate *appDelegate = (TabBarWithSplitViewAppDelegate *)[[UIApplication sharedApplication] delegate];
    
        static NSString *CellIdentifier = @"Cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if (cell == nil) {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        }
    
    
    
        if(appDelegate.whichTablePopUpView==0){
            cell.textLabel.text = [array0 objectAtIndex:indexPath.row];
        }
        else if(appDelegate.whichTablePopUpView==1){
            cell.textLabel.text = [array1 objectAtIndex:indexPath.row];
        }
        else if(appDelegate.whichTablePopUpView==2){
            cell.textLabel.text = [array2 objectAtIndex:indexPath.row];
        }
        
         else if(appDelegate.whichTablePopUpView==3){
        cell.textLabel.text = [array3 objectAtIndex:indexPath.row];
         }
         else if(appDelegate.whichTablePopUpView==4){
             cell.textLabel.text = [array3 objectAtIndex:indexPath.row];
         }
         else if(appDelegate.whichTablePopUpView==5){
             cell.textLabel.text = [array0 objectAtIndex:indexPath.row];
         }
        return cell;
    }

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
     TabBarWithSplitViewAppDelegate *appDelegate = (TabBarWithSplitViewAppDelegate *)[[UIApplication sharedApplication] delegate];
   SearchParameters * param=[SearchParameters globalSearchParameters ];
    if(appDelegate.whichTablePopUpView==4){
        
        param.city=[array3 objectAtIndex:indexPath.row];
        NSString *s=[array3 objectAtIndex:indexPath.row];
        NSLog(param.city);
    }
    
    else if (appDelegate.whichTablePopUpView==5){
        if(indexPath.row==1){
            param.groupID=12010;
            }
    }
        
    else if (appDelegate.whichTablePopUpView==5){
        if(indexPath.row==2){
            param.groupID=12005;
            }
    }
    
    else if (appDelegate.whichTablePopUpView==5){
            if(indexPath.row==3){
                param.groupID=12001;
                }
    }
    
     else if (appDelegate.whichTablePopUpView==5){
            if(indexPath.row==4){
                param.groupID=12014;
                    
            }
     }
     else if (appDelegate.whichTablePopUpView==5){
            if(indexPath.row==5){
                param.groupID=10016;
            }   
     }
    
     else if (appDelegate.whichTablePopUpView==5){
         if(indexPath.row==6){
             param.groupID=12011;
         }   
     }
    


}

    
    
    



@end

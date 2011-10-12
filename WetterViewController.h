//
//  Wetter.h
//  TabBarWithSplitView
//
//  Created by Johannes Böhler on 04.10.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchPopUpViewController.h"

@interface WetterViewController : UIViewController <UIPopoverControllerDelegate>{
    
    SearchPopUpViewController *popUpViewController;
    SearchPopUpViewController *popUpViewController1;
    UIPopoverController *popover;

    
    
}
- (IBAction)orteButtonWasPressed:(id)sender;
- (IBAction)searchButtonWasPressed:(id)sender;

@end

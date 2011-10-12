//
//  SuchergebnisseKarte.h
//  TabBarWithSplitView
//
//  Created by Johannes Böhler on 12.10.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SuchergebnisseKarte : UIViewController<UITableViewDelegate, UITableViewDataSource>{
    UIBarButtonItem *zurueckNavigationButtonItem;

    
    
}
- (IBAction)zurueckWasPressed:(id)sender;
@property (retain, nonatomic) IBOutlet UIBarButtonItem *zurueckNavigationButtonItem;
- (IBAction)suchergebnisseButtonWasPressed:(id)sender;

@end

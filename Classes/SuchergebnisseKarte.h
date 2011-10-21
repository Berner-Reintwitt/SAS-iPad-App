//
//  SuchergebnisseKarte.h
//  TabBarWithSplitView
//
//  Created by Johannes Böhler on 12.10.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SuchergebnisseKarte : UIViewController<UITableViewDelegate, UITableViewDataSource, UINavigationBarDelegate>{
    
    UIBarButtonItem *button;

    
    
}
- (IBAction)zurueckWasPressed:(id)sender;
@property (retain, nonatomic) IBOutlet UIBarButtonItem *button;
- (IBAction)suchergebnisseButtonWasPressed:(id)sender;
- (IBAction)detailAnsichtWasPressed:(id)sender;


@end

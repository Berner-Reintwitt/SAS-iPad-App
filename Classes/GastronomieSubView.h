//
//  GastronomieSubView.h
//  TabBarWithSplitView
//
//  Created by Johannes Böhler on 10.11.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GastronomieSubView : UIViewController<UITableViewDataSource, UITableViewDelegate>{
    
    IBOutlet UITableViewCell *tableViewCell;
    
    
    
}

@property (retain, nonatomic) IBOutlet UITableViewCell *tableViewCell;
@end

//
//  SuchergebnisseDomizil.h
//  TabBarWithSplitView
//
//  Created by Johannes Böhler on 25.10.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SuchergebnisseDomizil : UIViewController<UIScrollViewDelegate>{
    
    UIScrollView *scrollView;
    
}
- (IBAction)scroll:(id)sender;
@property (retain, nonatomic) IBOutlet UIScrollView *scrollView;

@end

//
//  ShuttleServiceDetailViewControllerMaserati.h
//  TabBarWithSplitView
//
//  Created by Johannes Böhler on 27.09.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShuttleServiceDetailViewControllerMaserati : UIViewController <UISplitViewControllerDelegate>{
    
    UIImageView *bigImg;
    UIImageView *secondSmallImg;
    UIImageView *firstSmallImg;

    
}
@property (retain, nonatomic) IBOutlet UIImageView *bigImg;
@property (retain, nonatomic) IBOutlet UIImageView *secondSmallImg;
@property (retain, nonatomic) IBOutlet UIImageView *firstSmallImg;



@end

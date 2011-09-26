//
//  EnhancedSplitViewController.h
//  Enhanced SplitViewController
//
//  Created by Bart Bruijnesteijn on 3/23/11.
//  Copyright 2011 PiecesOfMyMind Software. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface EnhancedSplitViewController : UISplitViewController {
    UIBarButtonItem *barButton;
    UIPopoverController *pc;
}

@property (nonatomic, retain) UIBarButtonItem *barButton;
@property (nonatomic, retain) UIPopoverController *pc;

@end

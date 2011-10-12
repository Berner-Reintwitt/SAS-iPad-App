//
//  NewsDetailView.h
//  TabBarWithSplitView
//
//  Created by Johannes Böhler on 04.10.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewsDetailView : UIViewController <UISplitViewControllerDelegate>{
    
    UITextView *textView;
    NSArray *array;
    
}
@property (retain, nonatomic) IBOutlet UITextView *textView;

@end

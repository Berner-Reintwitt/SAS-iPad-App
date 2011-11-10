//
//  BilderGallerieSubView.h
//  TabBarWithSplitView
//
//  Created by Johannes Böhler on 10.11.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BilderGallerieSubView : UIViewController<UIScrollViewDelegate>{
    
    
    
   IBOutlet UIScrollView *scrollView;
}


@property (nonatomic,retain) IBOutlet UIScrollView *scrollView;
@end

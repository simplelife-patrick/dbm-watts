//
//  CaculatorHelpViewController.h
//  dbm-watt
//
//  Created by Patrick Deng on 13-2-24.
//  Copyright (c) 2013年 Code Animal. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CaculatorButton.h"

@interface CaculatorHelpViewController : UIViewController <UIScrollViewDelegate>
{
    NSMutableArray *imageArray;
    NSTimer *displayTimer;
}

@property (weak, nonatomic) IBOutlet UIView *helpView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property (weak, nonatomic) IBOutlet CaculatorButton *exitHelpButton;
@property (weak, nonatomic) IBOutlet CaculatorButton *nextHelpPageButton;
@property (weak, nonatomic) IBOutlet CaculatorButton *prevHelpPageButton;

- (IBAction)pageTurn:(UIPageControl *)sender;
- (IBAction)onExitHelpButtonClicked:(id)sender;
- (IBAction)onNextHelpPageButtonClicked:(id)sender;
- (IBAction)onPrevHelpPageButtonClicked:(id)sender;

@end

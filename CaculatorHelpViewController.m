//
//  CaculatorHelpViewController.m
//  dbm-watt
//
//  Created by Patrick Deng on 13-2-24.
//  Copyright (c) 2013年 Code Animal. All rights reserved.
//

#import "CaculatorHelpViewController.h"

@interface CaculatorHelpViewController ()

@end

@implementation CaculatorHelpViewController

@synthesize helpView = _helpView;
@synthesize scrollView = _scrollView;
@synthesize pageControl = _pageControl;

@synthesize exitHelpButton = _exitHelpButton;
@synthesize nextHelpPageButton = _nextHelpPageButton;
@synthesize prevHelpPageButton = _prevHelpPageButton;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        // Custom initialization
    }
    return self;
}

-(void)initArray
{
    UIImage* helpImage1 = [UIImage imageNamed:@"help1.png"];
    UIImage* helpImage2 = [UIImage imageNamed:@"help2.png"];
    UIImage* helpImage3 = [UIImage imageNamed:@"help3.png"];
    UIImage* helpImage4 = [UIImage imageNamed:@"help4.png"];
    
    imageArray=[NSArray arrayWithObjects: helpImage1, helpImage2, helpImage3, helpImage4, nil];
}

-(void)configHelpViewUI
{
    _scrollView.delegate = self;

    CGFloat width = _scrollView.frame.size.width;
    CGFloat height = _scrollView.frame.size.height;

    // fill images
    for (int i = 0; i < imageArray.count; i++)
    {
        UIImageView *subImageView = [[UIImageView alloc] initWithImage:[imageArray objectAtIndex:i]];
        subImageView.frame = CGRectMake(width * i, 0, width, height);
        [_scrollView addSubview: subImageView];
    }
 
    // set the whole scrollView's size
    [_scrollView setContentSize:CGSizeMake(width * imageArray.count, height)];
    [_helpView addSubview:_scrollView];
    [_scrollView scrollRectToVisible:CGRectMake(0, 0, width, height) animated:NO];
    // set page control UI attributes
    [_pageControl setBounds:CGRectMake(0, 0, 18 * (_pageControl.numberOfPages + 1), 18)];
    [_pageControl.layer setCornerRadius:8];
    _pageControl.numberOfPages = imageArray.count;
    _pageControl.backgroundColor=[UIColor grayColor];
    _pageControl.currentPage = 0;
    _pageControl.enabled = YES;
    [_helpView addSubview:_pageControl];
    [_pageControl addTarget:self action:@selector(pageTurn:)forControlEvents:UIControlEventValueChanged];
    // set auto display timer
    displayTimer = [NSTimer scheduledTimerWithTimeInterval:UI_HELP_PAGE_DISPLAY_INTERVAL target:self selector:@selector(scrollToNextPageByTimer:) userInfo:nil repeats:YES];
    
//    _exitHelpButton.layer.borderColor = [UIColor lightGrayColor].CGColor;
//    _exitHelpButton.layer.borderWidth = UI_CACULATOR_BUTTON_BORDERWIDTH;
//    _exitHelpButton.layer.cornerRadius = UI_CACULATOR_BUTTON_CORNERRADIUS;
    _exitHelpButton.layer.backgroundColor = [CaculatorUIStyle caculatorButtonNormalBackgroundColor].CGColor;
    [_exitHelpButton setExclusiveTouch:TRUE];
    [_helpView addSubview:_exitHelpButton];
    
//    _nextHelpPageButton.layer.borderColor = [UIColor lightGrayColor].CGColor;
//    _nextHelpPageButton.layer.borderWidth = UI_CACULATOR_BUTTON_BORDERWIDTH;
//    _nextHelpPageButton.layer.cornerRadius = UI_CACULATOR_BUTTON_CORNERRADIUS;
    _nextHelpPageButton.layer.backgroundColor = [CaculatorUIStyle caculatorButtonNormalBackgroundColor].CGColor;
    [_exitHelpButton setExclusiveTouch:TRUE];
    [_helpView addSubview:_nextHelpPageButton];

    _prevHelpPageButton.layer.backgroundColor = [CaculatorUIStyle caculatorButtonNormalBackgroundColor].CGColor;
    [_helpView addSubview:_prevHelpPageButton];
}

-(void)scrollToNextPage:(id)sender
{
    // repeat scrolling
//    int pageNum = _pageControl.currentPage;
//    CGSize viewSize = _scrollView.frame.size;
//
//    if (pageNum == imageArray.count - 1)
//    {
//        CGRect newRect = CGRectMake(0, 0, viewSize.width, viewSize.height);
//        [_scrollView scrollRectToVisible:newRect animated:NO];
//    }
//    else
//    {
//        pageNum++;
//        CGRect rect = CGRectMake(pageNum * viewSize.width, 0, viewSize.width, viewSize.height);
//        [_scrollView scrollRectToVisible:rect animated:NO];
//    }

    // single round scrolling
    CGSize pageSize = _scrollView.frame.size;
    int pageNum = _pageControl.currentPage;
    if (pageNum == imageArray.count - 1)
    {
        [displayTimer invalidate];
    }
    else
    {
        pageNum++;
        CGRect rect = CGRectMake(pageNum * pageSize.width, 0, pageSize.width, pageSize.height);
        [_scrollView scrollRectToVisible:rect animated:NO];
    }
}

-(void)scrollToPrevPage:(id)sender
{
    // single round scrolling
    CGSize pageSize = _scrollView.frame.size;
    int pageNum = _pageControl.currentPage;
    if (pageNum == 0)
    {
        [displayTimer invalidate];
    }
    else
    {
        pageNum--;
        CGRect rect = CGRectMake(pageNum * pageSize.width, 0, pageSize.width, pageSize.height);
        [_scrollView scrollRectToVisible:rect animated:NO];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initArray];
    [self configHelpViewUI];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload
{
    [self setScrollView:nil];
    [self setPageControl:nil];
    [self setHelpView:nil];
    [self setExitHelpButton:nil];
    [self setNextHelpPageButton:nil];
    [self setPrevHelpPageButton:nil];
    [super viewDidUnload];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat pageWidth = _scrollView.frame.size.width;
    int currentPage = floor((_scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    // repeat scrolling
    // 
    // single round scrolling
    if (currentPage < imageArray.count)
    {
        _pageControl.currentPage = currentPage;
    }
    else
    {
        _pageControl.currentPage = imageArray.count;
    }
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    // disable auto display timer when user drags scrollView manually.
    [displayTimer invalidate];
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    // restart auto display timer when user stops to drag scrollView manually.
//    displayTimer = [NSTimer scheduledTimerWithTimeInterval:UI_HELP_PAGE_DISPLAY_INTERVAL target:self selector:@selector(scrollToNextPage:) userInfo:nil repeats:YES];
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{

}

-(IBAction)pageTurn:(UIPageControl *)sender
{
    [displayTimer invalidate];
    
    int pageNum = _pageControl.currentPage;
    CGSize pageSize = _scrollView.frame.size;
    CGRect rect = CGRectMake((pageNum) * pageSize.width, 0, pageSize.width, pageSize.height);
    [_scrollView scrollRectToVisible:rect animated:TRUE];
}

- (IBAction)onExitHelpButtonClicked:(id)sender
{
    [self performSegueWithIdentifier:SEGUE_ID_HELPVIEW_CONTROLLER_TO_NAVIGATION_CONTROLLER sender:self];
}

- (IBAction)onNextHelpPageButtonClicked:(id)sender
{
    [displayTimer invalidate];
    if (_pageControl.currentPage == imageArray.count - 1)
    {
        [_nextHelpPageButton setUserInteractionEnabled:FALSE];
        [_nextHelpPageButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    }
    else
    {
        [_nextHelpPageButton setUserInteractionEnabled:TRUE];
        [_nextHelpPageButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self scrollToNextPage:nil];
    }
}

- (IBAction)onPrevHelpPageButtonClicked:(id)sender
{
    [displayTimer invalidate];
    if (_pageControl.currentPage == 0)
    {
        [_prevHelpPageButton setUserInteractionEnabled:FALSE];
        [_prevHelpPageButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    }
    else
    {
        [_prevHelpPageButton setUserInteractionEnabled:TRUE];
        [_prevHelpPageButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self scrollToPrevPage:nil];
    }
}

@end

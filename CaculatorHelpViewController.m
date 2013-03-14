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
    [self activateDisplayTimer:TRUE];
    
    [_helpView addSubview:_exitHelpButton];
    [_helpView addSubview:_prevHelpPageButton];
    [_helpView addSubview:_nextHelpPageButton];
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
//        [_scrollView scrollRectToVisible:rect animated:TRUE];
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
        [_scrollView scrollRectToVisible:rect animated:TRUE];
    }
    
    [self refreshPageControlButtonsStatus];
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
        [_scrollView scrollRectToVisible:rect animated:TRUE];
    }
    
    [self refreshPageControlButtonsStatus];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initArray];
    [self configHelpViewUI];
    [self refreshPageControlButtonsStatus];
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
    // N/A
    
    // single round scrolling
    if (currentPage < imageArray.count)
    {
        _pageControl.currentPage = currentPage;
    }
    else
    {
        _pageControl.currentPage = imageArray.count;
    }
    
    [self refreshPageControlButtonsStatus];
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    // disable auto display timer when user drags scrollView manually.
    [self activateDisplayTimer:FALSE];
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    // restart auto display timer when user stops to drag scrollView manually.
    [self activateDisplayTimer:TRUE];
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{

}

-(IBAction)pageTurn:(UIPageControl *)sender
{
    [self activateDisplayTimer:FALSE];
    
    int pageNum = _pageControl.currentPage;
    CGSize pageSize = _scrollView.frame.size;
    CGRect rect = CGRectMake((pageNum) * pageSize.width, 0, pageSize.width, pageSize.height);
    [_scrollView scrollRectToVisible:rect animated:TRUE];
    
    [self refreshPageControlButtonsStatus];
}

- (IBAction)onExitHelpButtonClicked:(id)sender
{
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    BOOL isAppLaunchedBefore = [defaults boolForKey:APP_CONFIG_ISLAUNCHED_BEFORE];
    if (!isAppLaunchedBefore)
    {
        [defaults setBool:TRUE forKey:APP_CONFIG_ISLAUNCHED_BEFORE];
        [self performSegueWithIdentifier:SEGUE_ID_HELP_TO_CACULATOR sender:self];
    }
    else
    {
        [self dismissViewControllerAnimated:TRUE completion:^{}];
    }
}

- (IBAction)onNextHelpPageButtonClicked:(id)sender
{
    [self activateDisplayTimer:FALSE];
    if (_pageControl.currentPage < imageArray.count - 1)
    {
        [self scrollToNextPage:nil];
    }
    [self refreshPageControlButtonsStatus];
}

- (IBAction)onPrevHelpPageButtonClicked:(id)sender
{
    [self activateDisplayTimer:FALSE];
    if (0 < _pageControl.currentPage)
    {
        [self scrollToPrevPage:nil];
    }
    [self refreshPageControlButtonsStatus];
}

-(void) refreshPageControlButtonsStatus
{
    NSInteger pageNum = _pageControl.currentPage;
    if (0 == pageNum)
    {
        [_exitHelpButton setHidden:TRUE];
        [_prevHelpPageButton setHidden:TRUE];
    }
    else if(pageNum == imageArray.count - 1)
    {
        [_exitHelpButton setHidden:FALSE];
        [_nextHelpPageButton setHidden:TRUE];
    }
    else
    {
        [_exitHelpButton setHidden:TRUE];
        [_prevHelpPageButton setHidden:FALSE];
        [_nextHelpPageButton setHidden:FALSE];
    }
}

-(void) activateDisplayTimer:(BOOL) activate
{
    if (activate)
    {
        displayTimer = [NSTimer scheduledTimerWithTimeInterval:UI_HELP_PAGE_DISPLAY_INTERVAL target:self selector:@selector(scrollToNextPage:) userInfo:nil repeats:YES];
    }
    else
    {
        if (displayTimer.isValid)
        {
            [displayTimer invalidate];
        }
    }
}

@end

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

@synthesize scrollView = _scrollView;
@synthesize pageControl = _pageControl;

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

-(void)configScrollView
{
    _scrollView.delegate = self;
    
    // set the last image in the first page
    UIImageView *firstView = [[UIImageView alloc] initWithImage:[imageArray lastObject]];
    CGFloat width = _scrollView.frame.size.width;
    CGFloat height = _scrollView.frame.size.height;
    firstView.frame = CGRectMake(0, 0, width, height);
    [_scrollView addSubview:firstView];
    // fill images
    for (int i = 0; i < imageArray.count; i++)
    {
        UIImageView *subViews = [[UIImageView alloc] initWithImage:[imageArray objectAtIndex:i]];
        subViews.frame = CGRectMake(width * (i + 1), 0, width, height);
        [_scrollView addSubview: subViews];
    }
    // set the first image in the last page
    UIImageView *lastView = [[UIImageView alloc] initWithImage:[imageArray objectAtIndex:0]];
    lastView.frame = CGRectMake(width * (imageArray.count + 1), 0, width, height);
    [_scrollView addSubview:lastView];
    // set the whole scrollView's size
    [_scrollView setContentSize:CGSizeMake(width * (imageArray.count + 2), height)];
    [self.view addSubview:_scrollView];
    // show the visible first image(the second page), not the first page in the scrollView
    [_scrollView scrollRectToVisible:CGRectMake(width, 0, width, height) animated:NO];
    // set page control UI attributes
    [_pageControl setBounds:CGRectMake(0, 0, 18 * (_pageControl.numberOfPages + 1), 18)];
    [_pageControl.layer setCornerRadius:8];
    _pageControl.numberOfPages = imageArray.count;
    _pageControl.backgroundColor=[UIColor grayColor];
    _pageControl.currentPage = 0;
    _pageControl.enabled = YES;
    [self.view addSubview:_pageControl];
    [_pageControl addTarget:self action:@selector(pageTurn:)forControlEvents:UIControlEventValueChanged];
    // set auto display timer
    displayTimer = [NSTimer scheduledTimerWithTimeInterval:UI_HELP_PAGE_DISPLAY_INTERVAL target:self selector:@selector(scrollToNextPage:) userInfo:nil repeats:YES];
}

-(void)scrollToNextPage:(id)sender
{
    // repeat scrolling
//    int pageNum = _pageControl.currentPage;
//    CGSize viewSize = _scrollView.frame.size;
//    CGRect rect = CGRectMake((pageNum + 2) * viewSize.width, 0, viewSize.width, viewSize.height);
//    [_scrollView scrollRectToVisible:rect animated:NO];
//    pageNum++;
//    if (pageNum == imageArray.count)
//    {
//        CGRect newRect = CGRectMake(viewSize.width, 0, viewSize.width, viewSize.height);
//        [_scrollView scrollRectToVisible:newRect animated:NO];
//    }
    // single round scrolling
    CGSize viewSize = _scrollView.frame.size;
    int pageNum = _pageControl.currentPage;
    pageNum++;
    if (pageNum == imageArray.count)
    {
        [displayTimer invalidate];
    }
    else
    {
        CGRect rect = CGRectMake((pageNum + 1) * viewSize.width, 0, viewSize.width, viewSize.height);
        [_scrollView scrollRectToVisible:rect animated:NO];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initArray];
    [self configScrollView];
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
    [super viewDidUnload];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat pageWidth = _scrollView.frame.size.width;
    int currentPage = floor((_scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    if (0 == currentPage)
    {
        _pageControl.currentPage = imageArray.count - 1;
    }
    else if(currentPage == imageArray.count + 1)
    {
        _pageControl.currentPage = 0;
    }
    _pageControl.currentPage = currentPage - 1;
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
    CGFloat pageWidth = _scrollView.frame.size.width;
    CGFloat pageHeigth = _scrollView.frame.size.height;
    int currentPage = floor((_scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    NSLog(@"the current offset==%f", _scrollView.contentOffset.x);
    NSLog(@"the current page==%d", currentPage);
    
    if (0 == currentPage)
    {
        [_scrollView scrollRectToVisible:CGRectMake(pageWidth * imageArray.count, 0, pageWidth, pageHeigth) animated:NO];
        _pageControl.currentPage = imageArray.count - 1;
        NSLog(@"pageControl currentPage==%d", self.pageControl.currentPage);
        NSLog(@"the last image");
        return;
    }
    else if(currentPage == imageArray.count + 1)
    {
        [_scrollView scrollRectToVisible:CGRectMake(pageWidth, 0, pageWidth, pageHeigth) animated:NO];
        _pageControl.currentPage = 0;
        NSLog(@"pageControl currentPage==%d", _pageControl.currentPage);
        NSLog(@"the first image");
        return;
    }
    
    _pageControl.currentPage = currentPage - 1;
    NSLog(@"pageControl currentPage==%d", _pageControl.currentPage);
}

-(IBAction)pageTurn:(UIPageControl *)sender
{
    int pageNum = _pageControl.currentPage;
    CGSize viewSize = _scrollView.frame.size;
    [_scrollView setContentOffset:CGPointMake((pageNum + 1) * viewSize.width, 0)];
    NSLog(@"myscrollView.contentOffSet.x==%f", _scrollView.contentOffset.x);
    NSLog(@"pageControl currentPage==%d", _pageControl.currentPage);
    [displayTimer invalidate];
}

@end

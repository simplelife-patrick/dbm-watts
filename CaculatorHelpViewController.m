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
    [self.view addSubview:_scrollView];
    [_scrollView scrollRectToVisible:CGRectMake(0, 0, width, height) animated:NO];
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
    displayTimer = [NSTimer scheduledTimerWithTimeInterval:UI_HELP_PAGE_DISPLAY_INTERVAL target:self selector:@selector(scrollToNextPageByTimer:) userInfo:nil repeats:YES];
}

-(void)scrollToNextPageByTimer:(id)sender
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

@end

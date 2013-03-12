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
    /*
     @//初始化UIScrollView，设置相关属性，均可在storyBoard中设置
     CGRect frame=CGRectMake(0, 0, 320, 480);
     self.myScrollView = [[UIScrollView alloc]initWithFrame:frame];    //scrollView的大小
     self.myScrollView.backgroundColor=[UIColor blueColor];
     self.myScrollView.pagingEnabled=YES;//以页为单位滑动，即自动到下一页的开始边界
     self.myScrollView.showsVerticalScrollIndicator=NO;
     self.myScrollView.showsHorizontalScrollIndicator=NO;//隐藏垂直和水平显示条
     */
    _scrollView.delegate = self;
    
    UIImageView *firstView = [[UIImageView alloc] initWithImage:[imageArray lastObject]];
    CGFloat width = _scrollView.frame.size.width;
    CGFloat height = _scrollView.frame.size.height;
    firstView.frame = CGRectMake(0, 0, width, height);
    [_scrollView addSubview:firstView];
    //set the last as the first
    
    for (int i = 0; i < imageArray.count; i++)
    {
        UIImageView *subViews = [[UIImageView alloc] initWithImage:[imageArray objectAtIndex:i]];
        subViews.frame = CGRectMake(width * (i+1), 0, width, height);
        [_scrollView addSubview: subViews];
    }
    
    UIImageView *lastView = [[UIImageView alloc] initWithImage:[imageArray objectAtIndex:0]];
    lastView.frame = CGRectMake(width * (imageArray.count + 1), 0, width, height);
    [_scrollView addSubview:lastView];
    //set the first as the last
    
    [_scrollView setContentSize:CGSizeMake(width * (imageArray.count + 2), height)];
    [self.view addSubview:_scrollView];
    [_scrollView scrollRectToVisible:CGRectMake(width, 0, width, height) animated:NO];
    //show the real first image,not the first in the scrollView
    
    /*
     @//设置pageControl的位置，及相关属性，可选
     CGRect pageControlFrame=CGRectMake(100, 160, 78, 36);
     self.pageControl=[[UIPageControl alloc]initWithFrame:pageControlFrame];
     
     [self.pageControl setBounds:CGRectMake(0, 0, 16*(self.pageControl.numberOfPages-1), 16)];//设置pageControl中点的间距为16
     [self.pageControl.layer setCornerRadius:8];//设置圆角
     */
    _pageControl.numberOfPages = imageArray.count;
    //    self.pageControl.backgroundColor=[UIColor blueColor];//背景
    _pageControl.currentPage = 0;
    _pageControl.enabled = YES;
    [self.view addSubview:_pageControl];
    [_pageControl addTarget:self action:@selector(pageTurn:)forControlEvents:UIControlEventValueChanged];
    
    displayTimer = [NSTimer scheduledTimerWithTimeInterval:2.0f target:self selector:@selector(scrollToNextPage:) userInfo:nil repeats:YES];
}

-(void)scrollToNextPage:(id)sender
{
    int pageNum = _pageControl.currentPage;
    CGSize viewSize = _scrollView.frame.size;
    CGRect rect = CGRectMake((pageNum + 2) * viewSize.width, 0, viewSize.width, viewSize.height);
    [_scrollView scrollRectToVisible:rect animated:NO];
    pageNum++;
    if (pageNum == imageArray.count)
    {
        CGRect newRect = CGRectMake(viewSize.width, 0, viewSize.width, viewSize.height);
        [_scrollView scrollRectToVisible:newRect animated:NO];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
//    [self.navigationController setNavigationBarHidden:FALSE];
//    NSString *webpage = [NSBundle pathForResource:@"help" ofType:@"html" inDirectory:[[NSBundle mainBundle] bundlePath]];
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
        self.pageControl.currentPage = imageArray.count - 1;
    }
    else if(currentPage == imageArray.count + 1)
    {
        self.pageControl.currentPage = 0;
    }
    self.pageControl.currentPage = currentPage - 1;
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [displayTimer invalidate];
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    displayTimer = [NSTimer scheduledTimerWithTimeInterval:2.0f target:self selector:@selector(scrollToNextPage:) userInfo:nil repeats:YES];
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

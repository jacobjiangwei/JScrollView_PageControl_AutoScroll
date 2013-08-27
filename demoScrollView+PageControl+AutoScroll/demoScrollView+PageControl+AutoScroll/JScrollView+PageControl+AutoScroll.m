//
//  JScrollView+PageControl+AutoScroll.m
//  demoScrollView+PageControl+AutoScroll
//
//  Created by jacob on 29/7/13.
//  Copyright (c) 2013年 jacob QQ:110773265. All rights reserved.
//

#import "JScrollView+PageControl+AutoScroll.h"

@implementation JScrollView_PageControl_AutoScroll

@synthesize scrollView=_scrollView;
@synthesize pageControl=_pageControl;
@synthesize currentPage=_currentPage;
@synthesize viewsArray=_viewsArray;
@synthesize autoScrollDelayTime=_autoScrollDelayTime;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleTap:)];

        _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        _scrollView.delegate = self;
        _scrollView.contentSize = CGSizeMake(self.bounds.size.width * 3, self.bounds.size.height);
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.pagingEnabled = YES;
        [_scrollView addGestureRecognizer:tap];
        [self addSubview:_scrollView];
        
        CGRect rect = self.bounds;
        rect.origin.y = rect.size.height - 30;
        rect.size.height = 30;
        _pageControl = [[UIPageControl alloc] initWithFrame:rect];
        _pageControl.userInteractionEnabled = NO;

        [self addSubview:_pageControl];

    }
    return self;
}

-(void)shouldAutoShow:(BOOL)shouldStart
{
    if (shouldStart) {
        if ([autoScrollTimer isValid]) {
            
        }
        else
            autoScrollTimer=[NSTimer scheduledTimerWithTimeInterval:_autoScrollDelayTime target:self selector:@selector(autoShowNext) userInfo:nil repeats:YES];
    }
    else
    {
        if ([autoScrollTimer isValid]) {
            [autoScrollTimer invalidate];
            autoScrollTimer = nil;
        }
    }
}

-(void)autoShowNext
{
    if (_currentPage+1>=[_viewsArray count]) {
        _currentPage=0;
    }
    else
        _currentPage++;
    
    [_scrollView setContentOffset:CGPointMake(self.bounds.size.width*2, 0) animated:YES];
}

-(void)reloadData
{
    [firstView removeFromSuperview];
    [middleView removeFromSuperview];
    [lastView removeFromSuperview];
    
    if (_currentPage==0)
    {
        firstView=[_viewsArray lastObject];
        middleView=[_viewsArray objectAtIndex:_currentPage];
        if ([_viewsArray count] >1) {
            lastView=[_viewsArray objectAtIndex:_currentPage+1];
        }
    }
    else if (_currentPage==[_viewsArray count]-1)
    {
        firstView=[_viewsArray objectAtIndex:_currentPage-1];
        middleView=[_viewsArray objectAtIndex:_currentPage];
        lastView=[_viewsArray objectAtIndex:0];
    }
    else
    {
        firstView=[_viewsArray objectAtIndex:_currentPage-1];
        middleView=[_viewsArray objectAtIndex:_currentPage];
        lastView=[_viewsArray objectAtIndex:_currentPage+1];
    }
    [_pageControl setCurrentPage:_currentPage];
    CGSize scrollSize=_scrollView.bounds.size;
    [firstView setFrame:CGRectMake(0, 0, scrollSize.width, scrollSize.height)];
    [middleView setFrame:CGRectMake(scrollSize.width, 0, scrollSize.width, scrollSize.height)];
    [lastView setFrame:CGRectMake(scrollSize.width*2, 0, scrollSize.width, scrollSize.height)];
    [_scrollView addSubview:firstView];
    [_scrollView addSubview:middleView];
    [_scrollView addSubview:lastView];
    //自动timer滑行后自动替换，不再动画
    [_scrollView setContentOffset:CGPointMake(self.bounds.size.width, 0) animated:NO];
}


#pragma mark Setter

-(void)setViewsArray:(NSMutableArray *)viewsArray
{
    if (viewsArray) {
        _pageControl.numberOfPages=[viewsArray count];
        _viewsArray=viewsArray;
        _currentPage=0;
        [_pageControl setCurrentPage:_currentPage];
    }
    [self reloadData];
}

#pragma mark ScrollView Delegate
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    //自动timer滑行后自动替换，不再动画
    [self reloadData];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    //手动滑动自动替换，悬停timer
    [autoScrollTimer invalidate];
    autoScrollTimer=nil;
    autoScrollTimer=[NSTimer scheduledTimerWithTimeInterval:_autoScrollDelayTime target:self selector:@selector(autoShowNext) userInfo:nil repeats:YES];
    int x = scrollView.contentOffset.x;
    NSLog(@"x is %d",x);
    //往下翻一张
    if(x >= (2*self.frame.size.width)) {
        if (_currentPage+1==[_viewsArray count]) {
            _currentPage=0;
        }
        else
            _currentPage++;
    }
    
    //往上翻
    if(x <= 0) {
        if (_currentPage-1<0) {
            _currentPage=[_viewsArray count]-1;
        }
        else
            _currentPage--;
    }
    
    [self reloadData];

}


#pragma protocol

- (void)handleTap:(UITapGestureRecognizer *)tap {
    
    if ([_delegate respondsToSelector:@selector(didClickPage:atIndex:)]) {
        [_delegate didClickPage:self atIndex:_currentPage];
    }
    
}

@end

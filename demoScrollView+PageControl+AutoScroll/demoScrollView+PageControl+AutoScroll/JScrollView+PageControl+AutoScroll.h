//
//  JScrollView+PageControl+AutoScroll.h
//  demoScrollView+PageControl+AutoScroll
//
//  Created by jacob on 29/7/13.
//  Copyright (c) 2013年 jacob QQ:110773265. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol JScrollViewViewDelegate;

@interface JScrollView_PageControl_AutoScroll : UIView<UIScrollViewDelegate>
{
    UIView *firstView;
    UIView *middleView;
    UIView *lastView;
    
    UIGestureRecognizer     *tap;
    __unsafe_unretained id <JScrollViewViewDelegate>  _delegate;
    NSTimer         *autoScrollTimer;
}
@property (nonatomic,readonly)    UIScrollView *scrollView;
@property (nonatomic,readonly)  UIPageControl *pageControl;
@property (nonatomic,assign)    NSInteger currentPage;
@property (nonatomic,strong)    NSMutableArray *viewsArray;
@property (nonatomic,assign)    NSTimeInterval    autoScrollDelayTime;

@property (nonatomic,assign) id<JScrollViewViewDelegate> delegate;


-(void)shouldAutoShow:(BOOL)shouldStart;//自动滚动，界面不在的时候请调用这个停止timer

@end


@protocol JScrollViewViewDelegate <NSObject>

@optional
- (void)didClickPage:(JScrollView_PageControl_AutoScroll *)view atIndex:(NSInteger)index;

@end
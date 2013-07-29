//
//  ViewController.m
//  demoScrollView+PageControl+AutoScroll
//
//  Created by jacob on 29/7/13.
//  Copyright (c) 2013年 jacob QQ:110773265. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    JScrollView_PageControl_AutoScroll *view=[[JScrollView_PageControl_AutoScroll alloc]initWithFrame:self.view.bounds];
    UIImageView *imageView1=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"1.png"]];
    UIImageView *imageView2=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"2.png"]];
    UIImageView *imageView3=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"3.png"]];
    UIImageView *imageView4=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"4.png"]];
    view.autoScrollDelayTime=3.0;
    view.delegate=self;
    NSMutableArray *viewsArray=[[NSMutableArray alloc]initWithObjects:imageView1,imageView2,imageView3,imageView4,nil];
    [view setViewsArray:viewsArray];
    [self.view addSubview:view];
    [view shouldAutoShow:YES];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didClickPage:(JScrollView_PageControl_AutoScroll *)view atIndex:(NSInteger)index
{
    NSLog(@"click at %d",index  );
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

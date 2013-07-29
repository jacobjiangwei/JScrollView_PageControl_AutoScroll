JScrollView_PageControl_AutoScroll
==================================

JScrollView+PageControl+AutoScroll for iOS , support ARC


Function :

ScrollView with page support
infinite loop around
auto timer move on to next picture

自动滑动、无限循环自翻转，低内存消耗

Easy to use:

    JScrollView_PageControl_AutoScroll *view=[[JScrollView_PageControl_AutoScroll alloc]initWithFrame:self.view.bounds];
    view.autoScrollDelayTime=3.0;
    view.delegate=self;
    UIImageView *imageView1=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"1.png"]];
    UIImageView *imageView2=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"2.png"]];
    UIImageView *imageView3=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"3.png"]];
    UIImageView *imageView4=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"4.png"]];
    NSMutableArray *viewsArray=[[NSMutableArray alloc]initWithObjects:imageView1,imageView2,imageView3,imageView4,nil];
    [view setViewsArray:viewsArray];  // at least 3 views
    
    [self.view addSubview:view];
    [view shouldAutoShow:YES];
    


// feel free to ask and contribute to this code . Thank you .
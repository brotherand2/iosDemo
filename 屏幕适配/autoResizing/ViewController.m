//
//  ViewController.m
//  autoResizing
//
//  Created by Apple on 15/12/18.
//  Copyright © 2015年 Apple. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property(nonatomic,weak)UIView *blueView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UIView *blueView=[[UIView alloc]init];
    self.blueView=blueView;
    [blueView setBackgroundColor:[UIColor blueColor]];
    blueView.frame=CGRectMake(0, 0, 100, 100);
    UIView * redView=[[UIView alloc]init];
    [redView setBackgroundColor:[UIColor redColor]];
    redView.frame=CGRectMake(0, 70, 100, 30);
    [blueView addSubview:redView];
    [self.view addSubview:blueView];
//    UIViewAutoresizingNone                 = 0,
//    UIViewAutoresizingFlexibleLeftMargin   = 1 << 0,
//    UIViewAutoresizingFlexibleWidth        = 1 << 1,
//    UIViewAutoresizingFlexibleRightMargin  = 1 << 2,
//    UIViewAutoresizingFlexibleTopMargin    = 1 << 3,
//    UIViewAutoresizingFlexibleHeight       = 1 << 4,
//    UIViewAutoresizingFlexibleBottomMargin = 1 << 5
//让红色视图宽度高度跟蓝色视图变化而变化，红色视图顶部就行拉伸
    redView.autoresizingMask=UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleTopMargin;
}

//当屏幕点击进会调用这个方法
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    CGRect frame=self.blueView.frame;
    frame.size.height+=10;
    frame.size.width+=10;
    self.blueView.frame=frame;
}
@end

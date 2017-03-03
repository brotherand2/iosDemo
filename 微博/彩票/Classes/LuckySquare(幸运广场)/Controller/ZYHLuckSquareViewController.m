//
//  ZYHLuckSquareViewController.m
//  微博
//
//  Created by Apple on 16/2/4.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "ZYHLuckSquareViewController.h"
#import "ZYHWheelView.h"
#import "ZYHThreeBtn.h"
@interface ZYHLuckSquareViewController ()
{
    CGFloat screenW,screenH;
}
@property (weak, nonatomic) ZYHWheelView *wheelView;
@property (weak, nonatomic)ZYHThreeBtn *threeBtn;
@end

@implementation ZYHLuckSquareViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    CGSize size=[UIScreen mainScreen].bounds.size;
    screenH=size.height;
    screenW=size.width;
    //添加背景
    BOOL is4Rich=screenH==568;
    UIImage* image=[UIImage imageNamed:is4Rich?@"LuckyBackgroundBig": @"LuckyBackground"];
    UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 64, image.size.width, image.size.height)];
    imageView.image=image;
    [self.view addSubview:imageView];
    // Do any additional setup after loading the view.
    //添加三个按钮
    ZYHThreeBtn *threeBtn=[ZYHThreeBtn threeBtn];
    threeBtn.center=CGPointMake(screenW*0.5, 64+10+threeBtn.bounds.size.height*0.5);
    _threeBtn=threeBtn;
    [self.view addSubview:threeBtn];
    
    //添加轮子
    ZYHWheelView *wheelView=[ZYHWheelView wheel];
    wheelView.center=CGPointMake(screenW*0.5, CGRectGetMaxY(threeBtn.frame)-5+wheelView.bounds.size.height*0.5);
    _wheelView=wheelView;
    [self.view addSubview:wheelView];
}
- (void)viewWillAppear:(BOOL)animated
{
    [_wheelView startRotate];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [_wheelView stopRotate];
}
@end

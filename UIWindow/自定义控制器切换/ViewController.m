//
//  ViewController.m
//  自定义控制器切换
//
//  Created by Apple on 16/2/10.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "ViewController.h"
#import "ZYHOneViewController.h"
#import "ZYHThreeViewController.h"
#import "ZYHTwoViewController.h"
@interface ViewController ()
{
    CGSize size;
}
@property (weak, nonatomic)UIViewController *showVC;
@property (weak, nonatomic)UIView *contentView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     size=[UIScreen mainScreen].bounds.size;
    // Do any additional setup after loading the view, typically from a nib.
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64)];
    [self.view addSubview:view];
    self.contentView=view;
    _contentView=view;
    [self addChildViewController:[[ZYHOneViewController alloc]init]];
    [self addChildViewController:[[ZYHTwoViewController alloc]init]];
    [self addChildViewController:[[ZYHThreeViewController alloc]init]];
    [self clickBtn:[[UIButton alloc]init]];
}

- (IBAction)clickBtn:(UIButton*)btn
{
    [_showVC.view removeFromSuperview];
    NSInteger oldIndex=[self.childViewControllers indexOfObject:_showVC];
    _showVC=self.childViewControllers[btn.tag];
    _showVC.view.frame=_contentView.bounds;
    [_contentView addSubview:_showVC.view];
    CATransition *animation=[CATransition animation];
    animation.type=@"cube";
    animation.subtype=btn.tag>oldIndex?kCATransitionFromRight:kCATransitionFromLeft;
    
    [_contentView.layer addAnimation:animation forKey:nil];
    
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    
    if(toInterfaceOrientation==UIInterfaceOrientationLandscapeLeft||toInterfaceOrientation==UIInterfaceOrientationLandscapeRight)
    _contentView.frame=CGRectMake(0, 64,size.height , size.width-64);
    else
        _contentView.frame=CGRectMake(0, 64, size.width, size.height-64);
}
@end

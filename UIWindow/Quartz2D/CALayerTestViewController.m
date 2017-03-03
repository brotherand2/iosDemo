//
//  CALayerTestViewController.m
//  UIWindow
//
//  Created by Apple on 16/1/30.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "CALayerTestViewController.h"

@interface CALayerTestViewController ()
@property (weak, nonatomic) IBOutlet UIView *redView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation CALayerTestViewController
- (void)viewWillAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.navigationController.navigationBarHidden=YES;
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    self.navigationController.navigationBarHidden=NO;
}
- (BOOL)prefersStatusBarHidden
{
    return YES;
}

- (IBAction)translation:(id)sender
{
    if (self.tag==12)
    {
        [self translateWithTimes:10];
    }
    else
    {
        CABasicAnimation *animation=[CABasicAnimation animation];
        animation.keyPath=@"transform.translation";
        animation.byValue=[NSValue valueWithCGPoint:CGPointMake(50, 50)];
        // 设置动画的时间
        animation.duration = 1;
        animation.repeatCount=10;
        animation.removedOnCompletion = NO;//动画对象不要移除
        animation.fillMode = kCAFillModeForwards;//保存当前的状态
        [self.imageView.layer addAnimation:animation forKey:nil];
        [self.redView.layer addAnimation:animation forKey:nil];
        
    }
}
   //缩放
//transform.scale.x 代表x方向上绽放
//transform.scale.y 代表y方向上绽放

- (IBAction)scale:(id)sender
{
    if(12==self.tag)
    [self scaleWithTimes:10];
    else
    {
        CABasicAnimation *animation=[CABasicAnimation animation];
        animation.keyPath=@"transform.scale.x";
        animation.byValue=@(1.5);
        // 设置动画的时间
        animation.duration = 1;
        animation.repeatCount=10;
        [self.imageView.layer addAnimation:animation forKey:nil];
        [self.redView.layer addAnimation:animation forKey:nil];
    }

}
- (IBAction)rotate:(id)sender
{
    //旋转
    //1, 0, 0 x轴旋转
    //0, 1, 0 y轴旋转
    //0, 0, 1 z轴旋转
    if(12==self.tag)
        [self rotateWithTimes:20];
    else
    {
        CABasicAnimation *animation=[CABasicAnimation animation];
        animation.keyPath=@"transform.rotation.x";
        animation.byValue=@(M_PI_4);
        // 设置动画的时间
        animation.duration = 1;
        animation.repeatCount=10;
        animation.removedOnCompletion = NO;//动画对象不要移除
        animation.fillMode = kCAFillModeForwards;//保存当前的状态
        [self.imageView.layer addAnimation:animation forKey:nil];
        [self.redView.layer addAnimation:animation forKey:nil];
    }

}

- (void)scaleWithTimes:(NSInteger)times
{
    if(times<1)
        return;
    [UIView animateWithDuration:0.5 animations:^
     {
         [self.imageView.layer setValue:@0.7 forKeyPath:@"transform.scale.x"];
         self.redView.layer.transform = CATransform3DMakeScale(1.5, 1.5, 1);
         
     } completion:^(BOOL finished) {
         [self.imageView.layer setValue:@1 forKeyPath:@"transform.scale.x"];
         self.redView.layer.transform = CATransform3DMakeScale(1, 1, 1);
         [self scaleWithTimes:times-1];
         //学习形变属性
         //缩放
         //第三个参数sz 看不到效果
     }];
    //[self.redView.layer setValue:@1.5 forKeyPath:@"transform.scale.y"];
}
- (void)rotateWithTimes:(NSInteger)times
{
    if(times<1)
        return;
    NSInteger direct=arc4random()%3;
    [UIView animateWithDuration:1 animations:^
     {
         switch (direct)
         {
             case 0:
                 self.redView.layer.transform=CATransform3DMakeRotation(M_PI, 1, 0, 0);
                 self.imageView.layer.transform=CATransform3DMakeRotation(-M_2_PI, 1, 0, 0);
                 break;
             case 1:
                 [self.redView.layer setValue:@(M_PI) forKeyPath:@"transform.rotation.z"];
                 //self.redView.layer.transform=CATransform3DMakeRotation(M_PI, 0, 0, 1);
                 self.imageView.layer.transform=CATransform3DMakeRotation(-M_2_PI, 0, 0, 1);
                 break;
             case 2:
                 self.redView.layer.transform=CATransform3DMakeRotation(M_PI, 0, 1, 0);
                 self.imageView.layer.transform=CATransform3DMakeRotation(-M_PI, 0, 1, 0);
                 break;
         }
         
     } completion:^(BOOL finished)
     {
         [self rotateWithTimes:times-1];
    }];
    
}
- (void)translateWithTimes:(NSInteger)times
{
    if(times<1)
        return;
    [UIView animateWithDuration:0.5 animations:^
     {
         [self.imageView.layer setValue:@100 forKeyPath:@"transform.translation.x"];
          [self.imageView.layer setValue:@60 forKeyPath:@"transform.translation.y"];
         self.redView.layer.transform = CATransform3DMakeTranslation(60, -60, 60);
         
     } completion:^(BOOL finished) {
         self.imageView.layer.transform=CATransform3DMakeTranslation(0, 0, 0);
         //不具体指定x还是y方向的移动
         [self.redView.layer setValue:[NSValue valueWithCGPoint:CGPointMake(0, 0)] forKeyPath:@"transform.translation"];
         [self translateWithTimes:times-1];
     }];
    
}
- (IBAction)back:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}


@end

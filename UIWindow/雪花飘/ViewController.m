//
//  ViewController.m
//  雪花飘
//
//  Created by Apple on 16/2/3.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    CGFloat screenW,screenH;
}
@property(nonatomic,strong) CADisplayLink *timer;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    CGSize rect=[UIScreen mainScreen].bounds.size;
    screenW=rect.width;
    screenH=rect.height;
    UIImageView *imageView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"snowbg"]];
    imageView.frame=[UIScreen mainScreen].bounds;
    imageView.contentMode=UIViewContentModeScaleAspectFill;//裁剪边缘,使图片居中，上下进行拉伸
    [self.view addSubview:imageView];
    _timer=[CADisplayLink displayLinkWithTarget:self selector:@selector(update)];
    [_timer addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    
    
    // Do any additional setup after loading the view, typically from a nib.
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (_timer) {
        [_timer invalidate];
        _timer=nil;

    }
    else
    {
        _timer=[CADisplayLink displayLinkWithTarget:self selector:@selector(update)];
        [_timer addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    }
        
   }
#define degreeToAngle(degree)  ((degree)*M_PI/180.0)
- (void)update
{
   // NSLog(@"UPDATE");
    UIImageView *snow=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"雪花"]];
    CGFloat imageX=arc4random_uniform(screenW);
    CGFloat imageY=-snow.bounds.size.height*0.5;
    snow.center=CGPointMake(imageX, imageY);
    CGFloat imageToX=arc4random_uniform(screenW);
    CGFloat imageToY=screenH+snow.bounds.size.height*0.5;
    CGFloat scale=(arc4random_uniform(40)+1)/100.0;
    snow.transform=CGAffineTransformMakeScale(scale, scale);
    [self.view addSubview:snow];
    [UIView animateWithDuration:10.25 animations:^{
        snow.center=CGPointMake(imageToX, imageToY);
        snow.alpha=0.3;
        snow.transform=CGAffineTransformRotate(snow.transform, degreeToAngle(arc4random_uniform(360)+1));
    } completion:^(BOOL finished) {
        [snow removeFromSuperview];
    }];
}
- (BOOL)prefersStatusBarHidden
{
    return YES;
}
@end

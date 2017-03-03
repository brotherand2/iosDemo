//
//  ViewController.m
//  手势识别
//
//  Created by Apple on 16/1/25.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIGestureRecognizerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _imageView.userInteractionEnabled=YES;
    // Do any additional setup after loading the view, typically from a nib.
    [self addTap];
    //[self addLongPress];
    //[self addSwipe];
    //[self addRotate];
    //[self addPinch];
    //[self addPan];
}
//添加触摸手势
- (void)addTap
{
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
    tap.delegate=self;
    //tap.numberOfTapsRequired=2;//点击多少次才触发手势
    //tap.numberOfTouchesRequired=2;//多少根手指才触发手势
    [_imageView addGestureRecognizer:tap];
}
//这个触摸点能否触发手势
//- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
//{
//    CGPoint current=[touch locationInView:_imageView];
//    //NSLog(@"%@",NSStringFromCGPoint(current));
//    if (current.x<_imageView.bounds.size.width*0.5) {
//        return YES;
//    }
//    return NO;
//}
//支持多个手势
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}
//添加长按手势
- (void)addLongPress
{
    UILongPressGestureRecognizer *longPress=[[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPress:)];
    [_imageView addGestureRecognizer:longPress];
}

//添加轻扫手势
- (void)addSwipe
{
    UISwipeGestureRecognizer *swipe=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipe:)];
    [_imageView addGestureRecognizer:swipe];
    swipe.direction=UISwipeGestureRecognizerDirectionRight;//轻扫方向
}
//添加旋转手势
- (void)addRotate
{
    UIRotationGestureRecognizer *rotate=[[UIRotationGestureRecognizer alloc]initWithTarget:self action:@selector(rotate:)];
    [_imageView addGestureRecognizer:rotate];
    rotate.delegate=self;
}
//添加缩放手势
- (void)addPinch
{
    UIPinchGestureRecognizer *pinch=[[UIPinchGestureRecognizer alloc]initWithTarget:self action:@selector(pinch:)];
    [_imageView addGestureRecognizer:pinch];
    
}
//添加拖拽手势
- (void)addPan
{
    UIPanGestureRecognizer *pan=[[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(pan:)];
    [_imageView addGestureRecognizer:pan];
}
- (void)pan:(UIPanGestureRecognizer*)pan
{
    CGPoint point=[pan translationInView:_imageView];
    _imageView.transform=CGAffineTransformTranslate(_imageView.transform, point.x, point.y);
    NSLog(@"拖拽%@",NSStringFromCGPoint(point));
    //复位
    [pan setTranslation:CGPointZero inView:_imageView];
}
- (void)pinch:(UIPinchGestureRecognizer*)pinch
{
    _imageView.transform=CGAffineTransformScale(_imageView.transform, pinch.scale, pinch.scale);
    NSLog(@"缩放%f",pinch.scale);
    pinch.scale=1;//比例不累加

}
- (void)rotate:(UIRotationGestureRecognizer*)rotate
{
    //每次旋转的方向都是基于第1次
    //_imageView.transform=CGAffineTransformMakeRotation(rotate.rotation);
    _imageView.transform=CGAffineTransformRotate(_imageView.transform, rotate.rotation);//继于上一次的方向旋转
     NSLog(@"旋转%f",rotate.rotation);
    rotate.rotation=0;//方向不累加
   
    
}
- (void)swipe:(UISwipeGestureRecognizer *)swipe
{
    NSLog(@"轻扫");

}
- (void)longPress:(UILongPressGestureRecognizer*)longpress
{
    if (longpress.state==UIGestureRecognizerStateBegan) {
         NSLog(@"长按");
    }
   
}
- (void)tap:(UIPanGestureRecognizer*)pan
{
    NSLog(@"触摸");
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

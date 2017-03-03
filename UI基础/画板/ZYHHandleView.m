//
//  ZYHHandleView.m
//  helloworld
//
//  Created by Apple on 16/1/28.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "ZYHHandleView.h"
#import "UIImage+Extention.h"
@implementation ZYHHandleView
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame])
    {
        UIImageView *imageView=[[UIImageView alloc]initWithFrame:self.bounds];
        [self addSubview:imageView];
        _imageView=imageView;
        imageView.userInteractionEnabled=YES;
        [self addLongPress];
        [self addRotate];
        [self addPinch];
        [self addPan];
    }
    return self;
}
//添加长按手势
- (void)addLongPress
{
    UILongPressGestureRecognizer *longPress=[[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPress:)];
    [self addGestureRecognizer:longPress];
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
    
    //复位
    [pan setTranslation:CGPointZero inView:_imageView];
}
- (void)pinch:(UIPinchGestureRecognizer*)pinch
{
    _imageView.transform=CGAffineTransformScale(_imageView.transform, pinch.scale, pinch.scale);
   
    pinch.scale=1;//比例不累加
    
}
- (void)rotate:(UIRotationGestureRecognizer*)rotate
{
    //每次旋转的方向都是基于第1次
    //_imageView.transform=CGAffineTransformMakeRotation(rotate.rotation);
    _imageView.transform=CGAffineTransformRotate(_imageView.transform, rotate.rotation);//继于上一次的方向旋转
   
    rotate.rotation=0;//方向不累加
    
    
}
//支持多个手势
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}
- (void)longPress:(UILongPressGestureRecognizer*)longPress
{
    if (longPress.state==UIGestureRecognizerStateBegan)
    {
        [UIView animateWithDuration:0.5 animations:^{
            self.alpha=0.3;
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.5 animations:^{
                self.alpha=1;
            } completion:^(BOOL finished) {
                [self removeFromSuperview];
                UIImage *image=[UIImage clipScreenImageWithView:self];
                if (_handleBlock) {
                    _handleBlock(image);
                }
            }];
        }];
    }
}
- (void)setImage:(UIImage *)image
{
    _image=image;
    _imageView.image=image;
}

@end

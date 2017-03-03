//
//  ZYHWheelView.m
//  微博
//
//  Created by Apple on 16/2/4.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "ZYHWheelView.h"
#import "ZYHWheelButton.h"
@interface ZYHWheelView()
@property (weak, nonatomic) IBOutlet UIImageView *wheelImage;
@property(nonatomic,strong) CADisplayLink *timer;
@property (weak, nonatomic)UIButton *selectedBtn;
@end

@implementation ZYHWheelView

+ (instancetype)wheel
{
    return [[NSBundle mainBundle]loadNibNamed:@"ZYHWheelView" owner:self options:nil][0];
}
- (void)awakeFromNib
{
    _wheelImage.userInteractionEnabled=YES;
    UIImage *bigImage=[UIImage imageNamed:@"LuckyAstrology"];
    UIImage *bigImageHightlight=[UIImage imageNamed:@"LuckyAstrologyPressed"];
    CGFloat scale=[UIScreen mainScreen].scale;
    //需要乘上点与分辨率的比率，因为CGImageCreateWithImageInRect是用分辨率，不是点
    CGFloat imageW=bigImage.size.width/12*scale;
    CGFloat imageH=bigImage.size.height*scale;
    for(NSInteger i=0;i<12;i++)
    {
        UIButton *btn=[ZYHWheelButton buttonWithType:UIButtonTypeCustom];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.center=_wheelImage.center;
        btn.bounds=CGRectMake(0, 0, 68, 143);
        [btn setBackgroundImage:[UIImage imageNamed:@"LuckyRototeSelected"] forState:UIControlStateSelected];
        CGRect imageRect=CGRectMake(imageW*i, 0, imageW, imageH);
        CGImageRef imageRef=CGImageCreateWithImageInRect(bigImage.CGImage, imageRect);
        [btn setImage:[UIImage imageWithCGImage:imageRef] forState:UIControlStateNormal];
        CGImageRef imageSmallRef=CGImageCreateWithImageInRect(bigImageHightlight.CGImage, imageRect);
        [btn setImage:[UIImage imageWithCGImage:imageSmallRef] forState:UIControlStateSelected];
        btn.layer.anchorPoint=CGPointMake(0.5, 1);
        btn.transform=CGAffineTransformMakeRotation(30*i*M_PI/180.0);
        [_wheelImage addSubview:btn];
        if(i==0)
            [self btnClick:btn];
        }

}
- (void)btnClick:(UIButton*)btn
{
    _selectedBtn.selected=NO;
    btn.selected=YES;
    _selectedBtn=btn;
}
- (IBAction)start:(id)sender
{
    if (_timer) {
        [self stopRotate];
    }
    _wheelImage.userInteractionEnabled=NO;
    CABasicAnimation *animation=[CABasicAnimation animation];
    animation.keyPath=@"transform.rotation";
    animation.duration=1.2;
    animation.toValue=@(2*M_PI*15);
    animation.delegate=self;
    animation.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [_wheelImage.layer addAnimation:animation forKey:nil];
}

- (void)startRotate
{
    if(_timer==nil)
    {
        _timer=[CADisplayLink displayLinkWithTarget:self selector:@selector(update)];
        [_timer addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    }
}
- (void)stopRotate
{
    [_timer invalidate];
    _timer=nil;
}
- (void)update
{
    _wheelImage.transform=CGAffineTransformRotate(_wheelImage.transform,45*M_PI/(60*180.0));
}
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    
    _wheelImage.userInteractionEnabled=YES;
    CGFloat angle=atan2(_selectedBtn.transform.b,_selectedBtn.transform.a ) ;
   // _wheelImage.transform=CGAffineTransformRotate(_wheelImage.transform, -angle);
    _wheelImage.transform=CGAffineTransformMakeRotation(-angle);
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self startRotate];
    });
     
}
@end

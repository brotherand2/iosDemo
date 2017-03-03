//
// 文件名： ZYHProcessCircle.m
// 项目名： UIWindow
// 创建者：Apple
// 日期时间 :16/1/26 11:50
// 版权：  Copyright © 2016年 Apple. All rights reserved.
//

#import "ZYHProcessCircle.h"

@implementation ZYHProcessCircle
- (void)drawRect:(CGRect)rect
{
    CGFloat width=rect.size.width;
    CGFloat height=rect.size.height;
    CGFloat textW=30;
    CGFloat textH=20;
    CGFloat textX=(width-textW)*0.5;
    CGFloat textY=(height-textH)*0.5;
    NSString *value=[NSString stringWithFormat:@"%.2f",_progress];
    [value drawInRect:CGRectMake(textX, textY, textW, textH) withAttributes:nil];
    CGFloat angle=-M_PI_4+_progress*2*M_PI;
    CGContextRef context=UIGraphicsGetCurrentContext();
    CGContextAddArc(context, width*0.5, (height)*0.5, (width-40)*0.5, -M_PI_4, angle, 0);
    CGContextStrokePath(context);
}

- (void)setProgress:(CGFloat)progress
{
    _progress=progress;
    [self setNeedsDisplay];
}
@end

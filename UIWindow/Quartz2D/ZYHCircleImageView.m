//
//  ZYHCircleImageView.m
//  UIWindow
//
//  Created by Apple on 16/1/27.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "ZYHCircleImageView.h"

@implementation ZYHCircleImageView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)drawRect:(CGRect)rect
{
    CGContextRef context=UIGraphicsGetCurrentContext();
    CGContextAddEllipseInRect(context, self.bounds);
    CGContextClip(context);
    UIImage *image=[UIImage imageNamed:self.imageName];
    [image drawInRect:self.bounds];
    CGContextSetLineWidth(context, _borderWidth);
    [_borderColor set];
    CGContextAddEllipseInRect(context, self.bounds);
    CGContextStrokePath(context);
}
- (void)setImageName:(NSString *)imageName
{
    _imageName=imageName;
    [self setNeedsDisplay];
}
@end

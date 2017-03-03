//
//  ZYHView.m
//  UIWindow
//
//  Created by Apple on 16/2/3.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "ZYHView.h"

@implementation ZYHView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    [self drawBack:rect];
}
- (void)drawBack:(CGRect)rect
{
    CGContextRef context=UIGraphicsGetCurrentContext();
    CGFloat x=rect.size.width*0.5;
    CGFloat y=rect.size.height*0.5;
    CGFloat radious=x<y?x:y;
    CGContextAddArc(context, x, y, radious, 0, 2*M_PI, 0);
    CGContextClip(context);
    [[UIColor orangeColor]set];
    CGContextAddArc(context, x, y, radious, 0, 2*M_PI, 0);
    CGContextFillPath(context);
}

@end

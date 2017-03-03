//
//  ZYHLayer.m
//  UIWindow
//
//  Created by Apple on 16/1/30.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "ZYHLayer.h"

@implementation ZYHLayer

- (void)drawInContext:(CGContextRef)ctx
{
    CGContextFillEllipseInRect(ctx, CGRectMake(0, 0, 100, 100));
}
@end

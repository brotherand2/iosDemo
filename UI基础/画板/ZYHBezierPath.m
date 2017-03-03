//
//  ZYHBezierPath.m
//  helloworld
//
//  Created by Apple on 16/1/28.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "ZYHBezierPath.h"

@implementation ZYHBezierPath
+ (instancetype)paintPathWithLineWidth:(NSInteger)width andColor:(UIColor *)color
{
    ZYHBezierPath *path=[[self alloc]init];
    path.color=color;
    path.lineWidth=width;
    [path setLineCapStyle:kCGLineCapRound];
    [path setLineJoinStyle:kCGLineJoinRound];

    return path;
}
@end

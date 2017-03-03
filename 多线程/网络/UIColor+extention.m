//
//  UIColor+extention.m
//  UIWindow
//
//  Created by Apple on 16/1/27.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "UIColor+extention.h"

@implementation UIColor (extention)

+ (instancetype)randomColor
{
    NSInteger red=arc4random()%255;
    NSInteger green=arc4random()%255;
    NSInteger blue=arc4random()%255;
    return [UIColor colorWithR:red G:green B:blue];
}
+ (instancetype)colorWithR:(NSInteger)r G:(NSInteger)g B:(NSInteger)b
{
    return [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0];
}
+ (instancetype)colorWithR:(NSInteger)r G:(NSInteger)g B:(NSInteger)b A:(NSInteger)a
{
    return [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a/255.0];
}
+ (instancetype)randomColorWithAlpha
{
    NSInteger red=arc4random()%255;
    NSInteger green=arc4random()%255;
    NSInteger blue=arc4random()%255;
    NSInteger alpha=20+arc4random()%125;
    return [UIColor colorWithR:red G:green B:blue A:alpha];
}

@end

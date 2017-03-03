//
//  UIImage+Extention.m
//  helloworld
//
//  Created by Apple on 15/12/17.
//  Copyright © 2015年 Apple. All rights reserved.
//

#import "UIImage+Extention.h"
#import <UIKit/UIKit.h>
@implementation UIImage (Extention)


+(UIImage *)resizableWithName:(NSString *)name
{
    UIImage *oldImage=[UIImage imageNamed:name];
    CGFloat w=oldImage.size.width*0.5;//图片宽度高度
    CGFloat h=oldImage.size.height*0.5;
    //resizableImageWithCapInsets上左下右多少不拉伸resiziingMode拉伸模式
    return [oldImage resizableImageWithCapInsets:UIEdgeInsetsMake(h, w, h, w) resizingMode:UIImageResizingModeStretch];
    
}
+ (instancetype)waterImageNameWithBgImageName:(NSString *)bgImageName waterImageName:(NSString *)waterImageName scale:(CGFloat)scale
{
    UIImage *bgImage=[UIImage imageNamed:bgImageName];
    UIImage *waterImage=[UIImage imageNamed:waterImageName];
    // size:位图大小
    // opaque: alpha通道 YES:不透明/ NO透明 使用NO,生成的更清析,使用YES，进行裁剪会留下黑底
    // scale 比例 设置0.0为屏幕的比例,即点和相素的比例,假如原来的图片是1：2，将scale改为4，横纵坐标会扩大一倍
    // scale 是用于获取生成图片大小 比如位图大小：20X20 / 生成一张图片：（20 *scale X 20 *scale)

    UIGraphicsBeginImageContextWithOptions(bgImage.size, NO, scale);//开启图片上下文
    [bgImage drawInRect:CGRectMake(0, 0, bgImage.size.width, bgImage.size.height)];
    // 3.画水印
    // 算水印的位置和大小
    // 一般会通过一个比例来缩小水印图片
    CGFloat waterScale=0.4;
    CGFloat waterW=waterImage.size.width*waterScale;
    CGFloat waterH=waterImage.size.height*waterScale;
    CGFloat waterX=bgImage.size.width-waterW;
    CGFloat waterY=bgImage.size.height-waterH;
    [waterImage drawInRect:CGRectMake(waterX, waterY, waterW, waterH)];
    UIImage *newImage=UIGraphicsGetImageFromCurrentImageContext();//将当前图像内存写入一张图片
    UIGraphicsEndImageContext();
    return newImage;
}

+ (instancetype)circleImageWithImageName:(NSString *)imageName borderWidth:(NSInteger)width borderColor:(UIColor *)color
{
    UIImage  *image=[UIImage imageNamed:imageName];
    CGFloat imageW=image.size.width;
    CGFloat imageH=image.size.height;
    CGFloat circleW=imageW>imageH?imageH:imageW;
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(circleW, circleW), NO, 0.0);
    CGRect imageRect=CGRectMake(0, 0, circleW, circleW);
    CGContextRef context=UIGraphicsGetCurrentContext();
    CGContextAddEllipseInRect(context, imageRect);
    CGContextClip(context);
    [image drawInRect:imageRect];
    [color set];
    CGContextSetLineWidth(context, width);
    CGContextAddEllipseInRect(context, imageRect);
    CGContextStrokePath(context);
    UIImage *newImage=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}
+ (instancetype)clipScreenImageWithView:(UIView *)view
{
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, NO, 0.0);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *newImage=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}
#pragma mark 带虚线的背景图片
+ (instancetype)dashBgImageWithColor:(UIColor *)color
{
    CGFloat heigh=22;
    CGFloat width=[UIScreen mainScreen].bounds.size.width;
    UIGraphicsBeginImageContext(CGSizeMake(width, heigh));
    CGContextRef context=UIGraphicsGetCurrentContext();
    CGFloat dashH=1;
    CGFloat dashY=heigh-dashH;
    [color set];
    CGFloat dashLength[3]={20,5,10};
    CGContextSetLineDash(context, 0, dashLength, 3);
    CGPoint pt[2]={{0,dashY},{width,dashY}};
    CGContextAddLines(context, pt, 2);
    CGContextStrokePath(context);
    UIImage *newImage=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}
@end

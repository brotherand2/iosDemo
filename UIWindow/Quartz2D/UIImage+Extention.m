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
    UIGraphicsBeginImageContext(view.bounds.size);
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
#pragma mark -根据给定得图片，从其指定区域截取一张新得图片
+(instancetype)getImageFromImage:(UIImage *)image withRect:(CGRect)rect
{
    CGImageRef imageRef = image.CGImage;
    CGImageRef subImageRef = CGImageCreateWithImageInRect(imageRef, rect);
    UIImage* smallImage = [UIImage imageWithCGImage:subImageRef];
    UIGraphicsEndImageContext();
    return smallImage;
}
#pragma mark- 合并两张图片
+(instancetype)addImage:(UIImage *)image1 toImage:(UIImage *)image2 {
    UIGraphicsBeginImageContext(image1.size);
    // Draw image1
    [image1 drawInRect:CGRectMake(0, 0, image1.size.width, image1.size.height)];
    // Draw image2
    [image2 drawInRect:CGRectMake(0, 0, image2.size.width, image2.size.height)];
    UIImage *resultingImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return resultingImage;
}
#pragma mark--把一图片，裁剪成圆角的效果，圆角大小、边框、边框颜色的新图片
+ (instancetype)cornerImageWithImageName:(NSString *)imageName cornerRadius:(CGFloat)cornerRadius borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor
{
    UIImage *image=[UIImage imageNamed:imageName];
    UIGraphicsBeginImageContextWithOptions(image.size, NO, 0.0);
    CALayer *layer=[CALayer layer];
    layer.bounds=CGRectMake(0, 0, image.size.width, image.size.height);
    layer.cornerRadius=cornerRadius;
    layer.borderWidth=borderWidth;
    layer.borderColor=borderColor.CGColor;
    layer.contents=(id)image.CGImage;
    layer.masksToBounds=YES;
    [layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *newImage=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}
#pragma mark--返回图片中指定位置的颜色
- (UIColor *)colorAtPixel:(CGPoint)point
{
    // Cancel if point is outside image coordinates
    if (!CGRectContainsPoint(CGRectMake(0.0f, 0.0f, self.size.width, self.size.height), point)) {
        return nil;//当前点不在图片上
    }
    
    
    // Create a 1x1 pixel byte array and bitmap context to draw the pixel into.
    // Reference: http://stackoverflow.com/questions/1042830/retrieving-a-pixel-alpha-value-for-a-uiimage
    NSInteger pointX = trunc(point.x);
    NSInteger pointY = trunc(point.y);
    CGImageRef cgImage = self.CGImage;
    NSUInteger width = self.size.width;
    NSUInteger height = self.size.height;
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();//rgb颜色空间
    int bytesPerPixel = 4;
    int bytesPerRow = bytesPerPixel * 1;
    NSUInteger bitsPerComponent = 8;
    unsigned char pixelData[4] = { 0, 0, 0, 0 };
    CGContextRef context = CGBitmapContextCreate(pixelData,
                                                 1,
                                                 1,
                                                 bitsPerComponent,
                                                 bytesPerRow,
                                                 colorSpace,
                                                 kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
    CGColorSpaceRelease(colorSpace);
    CGContextSetBlendMode(context, kCGBlendModeCopy);//图片模式为将像素拷贝到上下文
    //首先设置坐标原点，让当前点刚好在设备原点，位图上下文的坐标系不是左上角，是左下角
    // Draw the pixel we are interested in onto the bitmap context
    CGContextTranslateCTM(context, -pointX, pointY-(CGFloat)height);
    CGContextDrawImage(context, CGRectMake(0.0f, 0.0f, (CGFloat)width, (CGFloat)height), cgImage);
    CGContextRelease(context);
    
    // Convert color values [0..255] to floats [0.0..1.0]
    CGFloat red   = (CGFloat)pixelData[0] / 255.0f;
    CGFloat green = (CGFloat)pixelData[1] / 255.0f;
    CGFloat blue  = (CGFloat)pixelData[2] / 255.0f;
    CGFloat alpha = (CGFloat)pixelData[3] / 255.0f;
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}

@end

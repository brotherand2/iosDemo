//
//  UIImage+Extention.h
//  helloworld
//
//  Created by Apple on 15/12/17.
//  Copyright © 2015年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Extention)
/**
 *  根据图片文件名，加载图片，对四边进行拉伸
 *
 *  @param name <#name description#>
 *
 *  @return <#return value description#>
 */
+ (UIImage*)resizableWithName:(NSString*)name;
/**
 *
 *  @param bgImageName    背景图片
 *  @param waterImageName 水印图片
 *  @param scale 图片生成的比例
 *  @return 添加了水印的背景图片
 */

+ (instancetype)waterImageNameWithBgImageName:(NSString*)bgImageName waterImageName:(NSString*)waterImageName scale:(CGFloat)scale;

/**
 *  创建裁剪图片
 */
+ (instancetype)circleImageWithImageName:(NSString*)imageName borderWidth:(NSInteger)width borderColor:(UIColor*)color;
//对指定的窗口进行截图
+ (instancetype)clipScreenImageWithView:(UIView*)view;
// 带虚线的背景图片
+ (instancetype)dashBgImageWithColor:(UIColor *)color;
//根据给定得图片，从其指定区域截取一张新得图片
+(instancetype)getImageFromImage:(UIImage*)image withRect:(CGRect)rect;
// 合并两张图片
+(instancetype)addImage:(UIImage *)image1 toImage:(UIImage *)image2;
//把一图片，裁剪成圆角的效果，圆角大小、边框、边框颜色的新图片
+(instancetype)cornerImageWithImageName:(NSString *)imageName cornerRadius:(CGFloat)cornerRadius borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;
//返回图片中指定位置的颜色
- (UIColor *)colorAtPixel:(CGPoint)point;
@end

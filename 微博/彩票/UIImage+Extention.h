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
@end

//
//  UIColor+extention.h
//  UIWindow
//
//  Created by Apple on 16/1/27.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (extention)
/**
 *  产生随机颜色
 *
 *  @return <#return value description#>
 */
+ (instancetype)randomColor;
/**
 *  产生指定R,G,B颜色
 *
 *  @param r 绿色，0-255
 *  @param g 縁色 0-255
 *  @param b 蓝0-255
 *
 *  @return <#return value description#>
 */
+ (instancetype)colorWithR:(NSInteger)r G:(NSInteger)g B:(NSInteger)b;
+ (instancetype)colorWithR:(NSInteger)r G:(NSInteger)g B:(NSInteger)b A:(NSInteger)a;
+ (instancetype)randomColorWithAlpha;
@end

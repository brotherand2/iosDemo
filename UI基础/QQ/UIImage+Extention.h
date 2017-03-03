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
@end

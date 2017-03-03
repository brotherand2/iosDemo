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

@end

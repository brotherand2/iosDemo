//
//  ZYHWheelButton.m
//  微博
//
//  Created by Apple on 16/2/4.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "ZYHWheelButton.h"

@implementation ZYHWheelButton

- (void)setHighlighted:(BOOL)highlighted
{
    
}
- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat imageX=10;
    CGFloat imageY=20;
    return CGRectMake(imageX,imageY, contentRect.size.width-imageX*2, contentRect.size.height*0.5-imageY);
}
@end

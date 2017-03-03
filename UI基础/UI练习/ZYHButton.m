//
//  ZYHButton.m
//  helloworld
//
//  Created by Apple on 16/2/2.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "ZYHButton.h"

@implementation ZYHButton
-(CGRect)imageRectForContentRect:(CGRect)contentRect{
    CGFloat imageW = contentRect.size.height*0.9;
    CGFloat imageH = imageW;
    CGFloat imageX = 20;
    CGFloat imageY = (contentRect.size.height-imageH)*0.5;
    
    return CGRectMake(imageX, imageY, imageW, imageH);
}
- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat imageW = contentRect.size.width;
    CGFloat imageH =contentRect.size.height*0.9;
    CGFloat imageX =95;//不能使用CGRectGetMaxX(self.imageView.frame)
    CGFloat imageY = (contentRect.size.height-imageH)*0.5;
    
    return CGRectMake(imageX, imageY, imageW, imageH);
}
@end

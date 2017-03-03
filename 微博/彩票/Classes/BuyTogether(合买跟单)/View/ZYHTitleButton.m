//
//  ZYHTitleButton.m
//  微博
//
//  Created by Apple on 16/2/4.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "ZYHTitleButton.h"
#define  imageW 30
@implementation ZYHTitleButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self=[super initWithCoder:aDecoder]) {
        //设置图片的显示样式
        self.imageView.contentMode = UIViewContentModeCenter;

    }
    return self;
}
- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat btnW=imageW;
    CGFloat btnX=contentRect.size.width-btnW;
    CGFloat btnY=0;
    CGFloat btnH=contentRect.size.height;
    return CGRectMake(btnX, btnY, btnW, btnH);
}
- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat btnW=contentRect.size.width-imageW;
    CGFloat btnX=0;
    CGFloat btnY=0;
    CGFloat btnH=contentRect.size.height;
    return CGRectMake(btnX, btnY, btnW, btnH);
}
@end

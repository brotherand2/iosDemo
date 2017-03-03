//
// 文件名： ZYHIconButton.m
// 项目名： ipad练习
// 创建者：Apple
// 日期时间 :16/3/18 15:59
// 版权：  Copyright © 2016年 Apple. All rights reserved.
//

#import "ZYHIconButton.h"
#import "UIView+Extension.h"
const CGFloat IconButtonLandscapeWidth = 90;
const CGFloat IconButtonLandscapeTitleH = 30;
const CGFloat IconButtonPortraitWH = 50;
const CGFloat IconButtonLandscapeHeight = IconButtonLandscapeWidth + IconButtonLandscapeTitleH;
@implementation ZYHIconButton
- (instancetype)initWithFrame:(CGRect)frame
{
    if(self=[super initWithFrame:frame])
    {
        [self setImage:[UIImage imageNamed:@"Easy"] forState:UIControlStateNormal];
        self.imageView.layer.cornerRadius=5;
        self.imageView.layer.masksToBounds=YES;
        [self setTitle:@"朝阳" forState:UIControlStateNormal];
        self.titleLabel.textAlignment=NSTextAlignmentCenter;
    }
    return  self;
}
- (void)willRotateToLanscade:(BOOL)isLanscade
{
    if(isLanscade)
    {
        self.width=IconButtonLandscapeWidth;
        self.height=IconButtonLandscapeHeight;
        self.y=64;
    }
    else
    {
        self.width=self.height=IconButtonPortraitWH;
        self.y=40;
    }
    self.x=(self.superview.width-self.width)*0.5;
}
- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    if(self.width==self.height)
        return CGRectZero;
    else
    {
        return CGRectMake(0, self.width, self.width, IconButtonLandscapeTitleH);
    }
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    // NSLog(@"%s",__func__);
}
- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    if(self.width==self.height)
        return self.bounds;
    else
        return CGRectMake(0, 0, self.width, self.width);
}
@end

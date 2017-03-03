//
// 文件名： ZYHDock.m
// 项目名： ipad练习
// 创建者：Apple
// 日期时间 :16/3/18 16:24
// 版权：  Copyright © 2016年 Apple. All rights reserved.
//


#import "ZYHDock.h"
#import "constant.h"
#import "UIView+Extension.h"
@interface ZYHDock()

@end
@implementation ZYHDock
- (instancetype)initWithFrame:(CGRect)frame
{
    if(self=[super initWithFrame:frame])
    {
        [self addIconButton];
        [self addTabBar];
        [self addBottomMenu];
    }
    return self;
}
- (void)addIconButton
{
    ZYHIconButton *iconBtn=[[ZYHIconButton alloc]init];
    [self addSubview:iconBtn];
    _iconBtn=iconBtn;
}
- (void)addTabBar
{
    ZYHTabBar *tabBar=[[ZYHTabBar alloc]init];
    [self addSubview:tabBar];
    tabBar.autoresizingMask= UIViewAutoresizingFlexibleTopMargin;//UIViewAutoresizingFlexibleTopMargin 自动调整与superView顶部的距离，保证与superView底部的距离不变。
    _tabBar=tabBar;
}
- (void)addBottomMenu
{
    ZYHBottomMenu *bottomMenu=[[ZYHBottomMenu alloc]init];
    [self addSubview:bottomMenu];
    bottomMenu.autoresizingMask= UIViewAutoresizingFlexibleTopMargin;//UIViewAutoresizingFlexibleTopMargin 自动调整与superView顶部的距离，保证与superView底部的距离不变。
    _bottomMenu=bottomMenu;
}
- (void)willRotateToLanscade:(BOOL)isLanscade
{
    if(isLanscade)
        self.width=LanscadeDockWidth;
    else
        self.width=PortraitDockWidth;
    
    [_iconBtn willRotateToLanscade:isLanscade];
    [_tabBar willRotateToLanscade:isLanscade];
    
    [_bottomMenu willRotateToLanscade:isLanscade];
    _tabBar.y=self.height-_bottomMenu.height-_tabBar.height;
}
@end

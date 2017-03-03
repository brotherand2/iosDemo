//
// 文件名： ZYHBottomMenu.m
// 项目名： ipad练习
// 创建者：Apple
// 日期时间 :16/3/18 16:00
// 版权：  Copyright © 2016年 Apple. All rights reserved.
//

#import "ZYHBottomMenu.h"
#import "constant.h"
#import "UIView+Extension.h"
#import "UIColor+extention.h"
@implementation ZYHBottomMenu

- (instancetype)initWithFrame:(CGRect)frame
{
    if(self=[super initWithFrame:frame])
    {
        [self addMenuButtonWithImageName:@"tabbar_mood" andbuttonType:ZYHBottomMenuMood];
        [self addMenuButtonWithImageName:@"tabbar_photo" andbuttonType:ZYHBottomMenuPhoto];
        [self addMenuButtonWithImageName:@"tabbar_blog" andbuttonType:ZYHBottomMenuBlog];
        //self.backgroundColor=[UIColor randomColor];
    }
    return  self;
}
- (void)buttonClick:(UIButton*)btn
{
    if(_didSelectMenu)
        _didSelectMenu(btn.tag);
}
- (UIButton*)addMenuButtonWithImageName:(NSString*)imageName andbuttonType:(ZYHBottomMenuType)menuType
{
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    btn.tag=menuType;
    [btn setImage:[UIImage imageNamed:imageName ]forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    btn.height=DockItemHeight;
    //self.backgroundColor=[UIColor randomColor];
    [self addSubview:btn];
    return btn;
}
- (void)willRotateToLanscade:(BOOL)isLanscade
{
    self.width=self.superview.width;
    if(isLanscade)
        self.height=DockItemHeight;
    else
        self.height=DockItemHeight*3;
    self.x=0;
    self.y=self.superview.height-self.height;
    NSInteger menuCount=self.subviews.count;
    
    for(NSInteger i=0;i<menuCount;i++)
    {
        UIButton *btn=self.subviews[i];
        btn.width=isLanscade?self.width/3:self.width;
        btn.x=isLanscade?(i*btn.width):0;
        btn.y=isLanscade?0:(i*DockItemHeight);
    }
    
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    //NSLog(@"%@",NSStringFromCGRect(self.frame));
}
@end

//
// 文件名： ZYHTabBar.m
// 项目名： ipad练习
// 创建者：Apple
// 日期时间 :16/3/18 16:00
// 版权：  Copyright © 2016年 Apple. All rights reserved.
//

#import "ZYHTabBar.h"
#import "UIColor+extention.h"
#import "UIView+Extension.h"
#import "constant.h"
#define  ImageViewScale 0.4//图片的宽度在父控件上的比例
@interface ZYHTabBar ()
@property(nonatomic,assign) NSInteger currentIndex;
@property (weak, nonatomic) ZYHTabBarItem *selectedItem;
@end
@implementation ZYHTabBar
- (instancetype)initWithFrame:(CGRect)frame
{
    if(self=[super initWithFrame:frame])
    {
        [self addTabBarItemWithImageName:@"tab_bar_feed_icon" andTitle:@"全部动态"];
        [self addTabBarItemWithImageName:@"tab_bar_passive_feed_icon" andTitle:@"与我相关"];
        [self addTabBarItemWithImageName:@"tab_bar_pic_wall_icon" andTitle:@"照片墙"];
        [self addTabBarItemWithImageName:@"tab_bar_e_album_icon" andTitle:@"电子相框"];
        [self addTabBarItemWithImageName:@"tab_bar_friend_icon" andTitle:@"好友"];
        [self addTabBarItemWithImageName:@"tab_bar_e_more_icon" andTitle:@"更多"];
        
        [self itemClick:self.subviews[0]];
       // self.backgroundColor=[UIColor randomColor];
    }
    return  self;
}

- (void)addTabBarItemWithImageName:(NSString*)imageName andTitle:(NSString*)title
{
    ZYHTabBarItem *item=[ZYHTabBarItem buttonWithType:UIButtonTypeCustom];
    //item.backgroundColor=[UIColor randomColor];
    [self addSubview:item];
    [item addTarget:self action:@selector(itemClick:) forControlEvents:UIControlEventTouchUpInside];
    [item setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [item setBackgroundImage:[UIImage imageNamed:@"tabbar_separate_selected_bg"] forState:UIControlStateSelected];
    [item setTitle:title forState:UIControlStateNormal];
    item.tag=self.subviews.count-1;
    item.height=DockItemHeight;
}
- (void)unSelect
{
    self.selectedItem.selected=NO;
}
- (void)itemClick:(ZYHTabBarItem*)item
{
    
    self.selectedItem.selected=NO;
    self.selectedItem=item;
    self.selectedItem.selected=YES;
    
    if(_didSelectTab)
        _didSelectTab(_currentIndex,item.tag);
    _currentIndex=item.tag;
}
- (void)willRotateToLanscade:(BOOL)isLanscade
{
    self.width=self.superview.width;
    self.height=self.subviews.count*DockItemHeight;
    
    for(NSInteger i=0;i<self.subviews.count;i++)
    {
        ZYHTabBarItem *item=self.subviews[i];
        item.height=DockItemHeight;
        item.y=DockItemHeight*i;
        item.width=self.width;
    }

}
@end

@implementation ZYHTabBarItem
- (void)setHighlighted:(BOOL)highlighted
{
    
}
- (instancetype)initWithFrame:(CGRect)frame
{
    if(self=[super initWithFrame:frame])
    {
        self.imageView.contentMode=UIViewContentModeCenter;//不拉伸,保护原大小居中
    }
    return  self;
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    if(self.width==self.height)
        return self.bounds;
    else
        return CGRectMake(0, 0, ImageViewScale*self.width, self.height);
}
- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    if(self.width==self.height)
        return CGRectZero;
    else
        return CGRectMake(ImageViewScale*self.width, 0, (1-ImageViewScale)*self.width, self.height);
}
@end
//
// 文件名： ZYHMainViewController.m
// 项目名： ipad练习
// 创建者：Apple
// 日期时间 :16/3/18 15:27
// 版权：  Copyright © 2016年 Apple. All rights reserved.
//

#import "ZYHMainViewController.h"
#import "ZYHAllViewController.h"
#import "ZYHDock.h"
#import "UIColor+extention.h"
#import "UIView+Extension.h"
#import "constant.h"
#import "ZYHTabBar.h"
#import "ZYHBottomMenu.h"
#import "ZYHMoodViewController.h"
@interface ZYHMainViewController()
@property (weak, nonatomic)ZYHDock *dockView;//左边停靠栏
@property (weak, nonatomic)UIView *contentView;//显示好友内容的视图
@property(nonatomic,assign) NSInteger currentIndex;
@end
#define  isLanscade  (self.view.bounds.size.width==LancadeWidth)//是否横屏
@implementation ZYHMainViewController
- (void)viewDidLoad
{
    [self addDock];
    [self addChildViewControllers];
    
    [self addContentView];
    [self switchControllerfromIndex:0 toIndex:0];
}
- (void)addDock
{
    ZYHDock *dockView=[[ZYHDock alloc]init];
    [self.view addSubview:dockView];
    _dockView=dockView;
    //dockView.backgroundColor=[UIColor randomColorWithAlpha];
    if(isLanscade)
        dockView.frame=CGRectMake(0, 0, LanscadeDockWidth, LandcadeHeight);
    else
        dockView.frame=CGRectMake(0, 0, PortraitDockWidth, LancadeWidth);
    [_dockView willRotateToLanscade:isLanscade];
    _dockView.autoresizingMask=UIViewAutoresizingFlexibleHeight;//根据父控件的拉伸比例进行拉伸
    __weak typeof(self)selfObj=self;
    _dockView.tabBar.didSelectTab=^(NSInteger fromIndex,NSInteger toIndex)
    {
        [selfObj switchControllerfromIndex:fromIndex toIndex:toIndex];
    };
    _dockView.bottomMenu.didSelectMenu=^(ZYHBottomMenuType type)
    {
        [selfObj bottomMenuClick:type];
    };
    [_dockView.iconBtn addTarget:self action:@selector(iconBtnClick) forControlEvents:UIControlEventTouchUpInside];
}
- (void)iconBtnClick
{
    [self switchControllerfromIndex:_currentIndex toIndex:self.childViewControllers.count-1];
    [self.dockView.tabBar unSelect];
}
- (void)bottomMenuClick:(ZYHBottomMenuType)type
{
    switch (type)
    {
        case ZYHBottomMenuBlog:
            NSLog(@"选中了日志");
            break;
        case ZYHBottomMenuMood:
        {
            NSLog(@"选中了心情");
            ZYHMoodViewController *VC=[[ZYHMoodViewController alloc]init];
            VC.view.backgroundColor=[UIColor randomColorWithAlpha];
            UINavigationController *nav=[[UINavigationController alloc]initWithRootViewController:VC];
            nav.modalPresentationStyle=UIModalPresentationFormSheet;
            nav.modalTransitionStyle=UIModalTransitionStyleFlipHorizontal;
            [self presentViewController:nav animated:YES completion:nil];
        }
            break;
        case ZYHBottomMenuPhoto:
        {
            [self dismissViewControllerAnimated:YES completion:nil];
        }
            break;
    }

}
- (void)switchControllerfromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex
{
    UIViewController *oldVC=self.childViewControllers[fromIndex];
    [oldVC.view removeFromSuperview];
    UIViewController *newVC=self.childViewControllers[toIndex];
    [self.contentView addSubview:newVC.view];
    _currentIndex=toIndex;
    newVC.view.frame=self.contentView.bounds;
}
- (void)addChildViewControllers
{
    NSInteger controllersCount=self.dockView.tabBar.subviews.count;
    ZYHAllViewController *allViewVc=[[ZYHAllViewController alloc]init];
    allViewVc.view.backgroundColor=[UIColor randomColorWithAlpha];
    [self packageNav:allViewVc];
    for(NSInteger i=0;i<controllersCount-1;i++)
    {
        UIButton *btn=self.dockView.tabBar.subviews[i];
        UIViewController *VC=[[UIViewController alloc]init];
        VC.title=[btn currentTitle];
        VC.view.backgroundColor=[UIColor randomColorWithAlpha];
        [self packageNav:VC];
    }
    UIViewController *VC=[[UIViewController alloc]init];
    VC.title=@"个人中心";
    VC.view.backgroundColor=[UIColor randomColorWithAlpha];
    [self packageNav:VC];
}
//将控制器包装成导航控制器
- (void)packageNav:(UIViewController*)vc
{
    UINavigationController *navVc=[[UINavigationController alloc]initWithRootViewController:vc];
    [self addChildViewController:navVc];
}
//显示好友内容的视图
- (void)addContentView
{
    UIView *contentView=[[UIView alloc]init];
    _contentView=contentView;
    [self.view addSubview:contentView];
    contentView.x=_dockView.width;
    contentView.y=20;
    contentView.height=self.view.height-contentView.y;
    contentView.width=LandcadeHeight-PortraitDockWidth;
    contentView.autoresizingMask=UIViewAutoresizingFlexibleHeight;
    //UIViewAutoresizingFlexibleHeight 自动调整自己的高度，保证与superView顶部和底部的距离不变
}
- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
     //NSLog(@"%s",__func__);
   
}
- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator
{
    BOOL isLanscadeSize=(size.width==LancadeWidth);
    [self.dockView  willRotateToLanscade:isLanscadeSize];
    _contentView.x=_dockView.width;
}
@end

//
// 文件名： ZYHDock.h
// 项目名： ipad练习
// 创建者：Apple
// 日期时间 :16/3/18 16:24
//  版权：  Copyright © 2016年 Apple. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "ZYHIconButton.h"

#import "ZYHBottomMenu.h"
#import "ZYHTabBar.h"
@interface ZYHDock : UIView
@property (weak, nonatomic)ZYHIconButton *iconBtn;
@property (weak, nonatomic)ZYHTabBar *tabBar;
@property (weak, nonatomic)ZYHBottomMenu *bottomMenu;
//根据是否横屏进行调整
- (void)willRotateToLanscade:(BOOL)isLanscade;
@end

//
// 文件名： ZYHTabBar.h
// 项目名： ipad练习
// 创建者：Apple
// 日期时间 :16/3/18 16:00
//  版权：  Copyright © 2016年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface ZYHTabBarItem :UIButton

@end
typedef void(^Action)(NSInteger fromIndex,NSInteger toIndex) ;
@interface ZYHTabBar : UIView
@property(nonatomic,copy) Action didSelectTab;//选中了tabBar
//根据是否横屏进行调整
- (void)willRotateToLanscade:(BOOL)isLanscade;
- (void)unSelect;
@end

//
// 文件名： ZYHBottomMenu.h
// 项目名： ipad练习
// 创建者：Apple
// 日期时间 :16/3/18 16:00
//  版权：  Copyright © 2016年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum
{
    ZYHBottomMenuMood,//发表说说,心情
    ZYHBottomMenuPhoto,//相片,传照片
    ZYHBottomMenuBlog,//日志,博客
}ZYHBottomMenuType;
typedef void(^BottomMenuAction)(ZYHBottomMenuType type) ;
@interface ZYHBottomMenu : UIView
//根据是否横屏进行调整
- (void)willRotateToLanscade:(BOOL)isLanscade;
@property(nonatomic,copy) BottomMenuAction didSelectMenu;
@end

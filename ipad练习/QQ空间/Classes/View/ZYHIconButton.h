//
// 文件名： ZYHIconButton.h
// 项目名： ipad练习
// 创建者：Apple
// 日期时间 :16/3/18 15:59
//  版权：  Copyright © 2016年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZYHIconButton : UIButton
//根据是否横屏进行调整
- (void)willRotateToLanscade:(BOOL)isLanscade;

@end

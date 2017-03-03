//
//  ZYHTabBar.h
//  微博
//
//  Created by Apple on 16/2/4.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef  void(^ClikBtnBlcok)(NSInteger tag);
@interface ZYHTabBar : UIView
@property(nonatomic,copy) ClikBtnBlcok btnClick;
- (void)addTabBarItemWithBkgImageName:(NSString*)bgName andSelectedName:(NSString*)selectName;
@end

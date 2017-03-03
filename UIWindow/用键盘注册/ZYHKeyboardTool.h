//
//  ZYHKeyboardTool.h
//  UIWindow
//
//  Created by Apple on 16/1/17.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum
{
    ZYHKeyboardPrevious,
    ZYHKeyboardNext,
    ZYHKeyboardFinish
}ZYHKeyboardType;
@interface ZYHKeyboardTool : UIToolbar
typedef void(^clickItemblock)(ZYHKeyboardType type);
@property(nonatomic,copy) clickItemblock clickItem;
+ (instancetype)keyboard;
@end

//
//  ZYHSettingItem.h
//  微博
//
//  Created by Apple on 16/2/5.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef enum {
    ZYHItemDefault,
    ZYHItemArrow,
    ZYHItemSwitch,
    ZYHItemLabel
}ZYHItemType;
typedef void(^ZYHSettingOption)() ;
@interface ZYHSettingItem : NSObject
@property(nonatomic,copy)NSString *labelText;
@property(nonatomic,copy)NSString *icon;
@property(nonatomic,copy)NSString *title;
@property(nonatomic,copy)NSString *subTitle;
@property(nonatomic,assign) Class vcClass;
@property(nonatomic,assign) ZYHItemType itemType;
@property(nonatomic,copy) ZYHSettingOption operation;

+ (instancetype)settingItemWithTitle:(NSString*)title icon:(NSString*)iconName subTitle:(NSString*)subTitle vcCalss:(Class)vcClass;

+ (instancetype)settingItemWithTitle:(NSString*)title icon:(NSString*)iconName  vcCalss:(Class)vcClass;
+ (instancetype)settingItemWithTitle:(NSString*)title icon:(NSString*)iconName ;
+ (instancetype)settingItemWithTitle:(NSString*)title;
@end

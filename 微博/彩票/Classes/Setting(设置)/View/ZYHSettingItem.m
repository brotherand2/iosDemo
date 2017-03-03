//
//  ZYHSettingItem.m
//  微博
//
//  Created by Apple on 16/2/5.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "ZYHSettingItem.h"

@implementation ZYHSettingItem
+ (instancetype)settingItemWithTitle:(NSString *)title icon:(NSString *)iconName subTitle:(NSString *)subTitle vcCalss:(Class)vcClass
{
    ZYHSettingItem *item=[[ZYHSettingItem alloc]init];
    item.itemType=ZYHItemArrow;
    item.title=title;
    item.subTitle=subTitle;
    item.vcClass=vcClass;
    item.icon=iconName;
    item.labelText=nil;
    return item;
}
+(instancetype)settingItemWithTitle:(NSString *)title
{
    return [self settingItemWithTitle:title icon:nil];
}
+ (instancetype)settingItemWithTitle:(NSString *)title icon:(NSString *)iconName
{
    return [self settingItemWithTitle:title icon:iconName vcCalss:nil];
}
+ (instancetype)settingItemWithTitle:(NSString *)title icon:(NSString *)iconName vcCalss:(Class)vcClass
{
    return [self settingItemWithTitle:title icon:iconName subTitle:nil vcCalss:vcClass];
}
@end

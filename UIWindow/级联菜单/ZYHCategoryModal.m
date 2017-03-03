//
//  ZYHCategoryModal.m
//  UIWindow
//
//  Created by Apple on 16/2/10.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "ZYHCategoryModal.h"

@implementation ZYHCategoryModal
//字典转模型定义
- (instancetype)initWithDict:(NSDictionary *)dict
{
    if(self=[self init])
    {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}
+ (instancetype)categoryWithDict:(NSDictionary *)dict
{
    return [[self alloc]initWithDict:dict];
}
@end

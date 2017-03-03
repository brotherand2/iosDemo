//
//  ZYHFlagModal.m
//  helloworld
//
//  Created by Apple on 16/1/16.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "ZYHFlagModal.h"

@implementation ZYHFlagModal
//字典转模型定义
- (instancetype)initWithDict:(NSDictionary *)dict
{
    if(self=[self init])
    {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}
+ (instancetype)flagWithDict:(NSDictionary *)dict
{
    return [[self alloc]initWithDict:dict];
}

@end

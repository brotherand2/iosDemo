//
//  ZYHAppModal.m
//  多线程
//
//  Created by Apple on 16/2/11.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "ZYHAppModal.h"

@implementation ZYHAppModal
//字典转模型定义
- (instancetype)initWithDict:(NSDictionary *)dict
{
    if(self=[self init])
    {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}
+ (instancetype)appWithDict:(NSDictionary *)dict
{
    return [[self alloc]initWithDict:dict];
}
@end

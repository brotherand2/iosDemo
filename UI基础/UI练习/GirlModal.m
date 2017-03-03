//
//  GirlModal.m
//  helloworld
//
//  Created by Apple on 16/2/1.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "GirlModal.h"

@implementation GirlModal
//字典转模型定义
- (instancetype)initWithDict:(NSDictionary *)dict
{
    if(self=[self init])
    {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}
+ (instancetype)girlWithDict:(NSDictionary *)dict
{
    return [[self alloc]initWithDict:dict];
}
@end

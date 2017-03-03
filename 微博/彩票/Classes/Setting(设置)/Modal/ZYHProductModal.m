//
//  ZYHProductModal.m
//  微博
//
//  Created by Apple on 16/2/8.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "ZYHProductModal.h"

@implementation ZYHProductModal
//字典转模型定义
- (instancetype)initWithDict:(NSDictionary *)dict
{
    if(self=[self init])
    {
        _title=dict[@"title"];
        _identifier=dict[@"id"];
        _url=dict[@"url"];
        _customUrl=dict[@"customUrl"];
        _icon=dict[@"icon"];
    }
    return self;
}
+ (instancetype)productWithDict:(NSDictionary *)dict
{
    return [[self alloc]initWithDict:dict];
}
@end

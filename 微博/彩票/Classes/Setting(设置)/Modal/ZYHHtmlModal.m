//
//  ZYHHtmlModal.m
//  微博
//
//  Created by Apple on 16/2/6.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "ZYHHtmlModal.h"

@implementation ZYHHtmlModal
//字典转模型定义
- (instancetype)initWithDict:(NSDictionary *)dict
{
    if(self=[self init])
    {
        _title=dict[@"title"];
        _html=dict[@"html"];
        _ID=dict[@"id"];
    }
    return self;
}
+ (instancetype)htmlWithDict:(NSDictionary *)dict
{
    return [[self alloc]initWithDict:dict];
}
@end

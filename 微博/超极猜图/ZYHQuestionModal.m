//
//  ZYHQuestionModal.m
//  微博
//
//  Created by Apple on 16/1/8.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "ZYHQuestionModal.h"

@implementation ZYHQuestionModal
//字典转模型定义
- (instancetype)initWithDict:(NSDictionary *)dict
{
    if(self=[self init])
    {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}
+ (instancetype)questionWithDict:(NSDictionary *)dict
{
    return [[self alloc]initWithDict:dict];
}
@end

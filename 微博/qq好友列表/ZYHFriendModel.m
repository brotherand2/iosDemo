//
//  ZYHFriendModel.m
//  微博
//
//  Created by Apple on 15/12/16.
//  Copyright © 2015年 Apple. All rights reserved.
//

#import "ZYHFriendModel.h"

@implementation ZYHFriendModel
//字典转模型定义
- (instancetype)initWithDict:(NSDictionary *)dict
{
    if(self=[self init])
    {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}
+ (instancetype)friendWithDict:(NSDictionary *)dict
{
    return [[self alloc]initWithDict:dict];
}
@end

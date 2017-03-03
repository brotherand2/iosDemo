//
//  ZYHGroupFriend.m
//  微博
//
//  Created by Apple on 15/12/16.
//  Copyright © 2015年 Apple. All rights reserved.
//

#import "ZYHGroupFriend.h"
#import "ZYHFriendModel.h"
@implementation ZYHGroupFriend
//字典转模型定义
- (instancetype)initWithDict:(NSDictionary *)dict
{
    if(self=[self init])
    {
        [self setValuesForKeysWithDictionary:dict];
        NSMutableArray *tempArray=[NSMutableArray array];
        for(NSDictionary *dict in self.friends)
        {
            ZYHFriendModel *model=[ZYHFriendModel friendWithDict:dict];
            [tempArray addObject:model];
        }
        self.friends=tempArray;
    }
    return self;
}
+ (instancetype)groupWithDict:(NSDictionary *)dict
{
    return [[self alloc]initWithDict:dict];
}
@end

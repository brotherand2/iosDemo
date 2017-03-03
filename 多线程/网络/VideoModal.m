//
// 文件名： VideoModal.m
// 项目名： 多线程
// 创建者：Apple
// 日期时间 :16/2/18 18:53
// 版权：  Copyright © 2016年 Apple. All rights reserved.
//

#import "VideoModal.h"
//{"id":2,"image":"resources/images/minion_02.png","length":12,"name":"小黄人 第02部","url":"resources/videos/minion_02.mp4"},
@implementation VideoModal
//字典转模型定义
- (instancetype)initWithDict:(NSDictionary *)dict
{
    if(self=[self init])
    {
        self.identifier=dict[@"id"];
        self.name=dict[@"name"];
        self.imageName=dict[@"image"];
        self.length=[dict[@"length"] integerValue];
        self.url=dict[@"url"];
    }
    return self;
}
+ (instancetype)videoWithDict:(NSDictionary *)dict
{
    return [[self alloc]initWithDict:dict];
}
@end

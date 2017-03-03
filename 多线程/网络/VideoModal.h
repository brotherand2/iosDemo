//
// 文件名： VideoModal.h
// 项目名： 多线程
// 创建者：Apple
// 日期时间 :16/2/18 18:53
//  版权：  Copyright © 2016年 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>
/*
 {"id":2,"image":"resources/images/minion_02.png","length":12,"name":"小黄人 第02部","url":"resources/videos/minion_02.mp4"},
 */
@interface VideoModal : NSObject
@property(nonatomic,copy)NSString *identifier;
@property(nonatomic,copy)NSString *imageName;
@property(nonatomic,assign) NSInteger length;
@property(nonatomic,copy)NSString *name;
@property(nonatomic,copy)NSString *url;
//字典转模型声明
- (instancetype)initWithDict:(NSDictionary*)dict;
+ (instancetype)videoWithDict:(NSDictionary*)dict;
@end

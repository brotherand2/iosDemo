////
//  ZYHFriendModel.h
//  微博
//
//  Created by Apple on 15/12/16.
//  Copyright © 2015年 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZYHFriendModel : NSObject
//图片
@property(nonatomic,copy)NSString *icon;
@property(nonatomic,copy)NSString *intro;//介绍
@property(nonatomic,copy)NSString *name;//名字
@property(nonatomic,assign,getter=isVip)BOOL vip;

//字典转模型声明
- (instancetype)initWithDict:(NSDictionary*)dict;
+ (instancetype)friendWithDict:(NSDictionary*)dict;
@end

//
//  ZYHGroupFriend.h
//  微博
//
//  Created by Apple on 15/12/16.
//  Copyright © 2015年 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZYHGroupFriend : NSObject
@property(nonatomic,strong)NSArray *friends;//好友
@property(nonatomic,copy)NSString *name;//组名
@property(nonatomic,assign)int online;//在线人数
@property(nonatomic,assign,getter=isOpenGroup)BOOL openGrup;//组是否展开或合上

//字典转模型声明
- (instancetype)initWithDict:(NSDictionary*)dict;
+ (instancetype)groupWithDict:(NSDictionary*)dict;
@end

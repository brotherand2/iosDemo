//
//  HMMicroBlog.h
//  02-黑(11)微博
//
//  Created by itheima on 15/9/21.
//  Copyright (c) 2015年 heima. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HMMicroBlog : NSObject
//图片
@property(nonatomic,copy)NSString *icon;
//名称
@property(nonatomic,copy)NSString *name;
//正文
@property(nonatomic,copy)NSString *text;
//配图
@property(nonatomic,copy)NSString *picture;
//vip
@property(nonatomic,assign,getter = isVip)BOOL vip;
- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)microBlogWithDict:(NSDictionary *)dict;

@end

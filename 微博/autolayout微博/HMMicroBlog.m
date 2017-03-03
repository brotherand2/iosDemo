//
//  HMMicroBlog.m
//  02-黑(11)微博
//
//  Created by itheima on 15/9/21.
//  Copyright (c) 2015年 heima. All rights reserved.
//

#import "HMMicroBlog.h"

@implementation HMMicroBlog

- (instancetype)initWithDict:(NSDictionary *)dict{
    
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}
+ (instancetype)microBlogWithDict:(NSDictionary *)dict{
    
    return  [[self alloc]initWithDict:dict];
}

@end

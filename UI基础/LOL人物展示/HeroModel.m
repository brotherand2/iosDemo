
//
//  HeroModel.m
//  helloworld
//
//  Created by Apple on 15/11/28.
//  Copyright © 2015年 Apple. All rights reserved.
//

#import "HeroModel.h"

@implementation HeroModel
- (instancetype)initWithDict:(NSDictionary *)dict
{
    if(self=[super init])
    {
        [self setValuesForKeysWithDictionary:dict];
    }
    return  self;
}
+ (instancetype)heroWithDict:(NSDictionary *)dict
{
    return  [[self alloc]initWithDict:dict];
}
@end

//
//  CarGroup.m
//  helloworld
//
//  Created by Apple on 15/11/28.
//  Copyright © 2015年 Apple. All rights reserved.
//

#import "CarGroup.h"

@implementation CarGroup
- (instancetype)initWithDict:(NSDictionary *)dict
{
    if(self=[super init])
    {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}
+(instancetype)carGroupWithDict:(NSDictionary *)dict
{
    return [[self alloc]initWithDict:dict];
}
@end

//
//  GroupModel.m
//  helloworld
//
//  Created by Apple on 15/11/28.
//  Copyright © 2015年 Apple. All rights reserved.
//

#import "GroupModel.h"
#import "CarModel.h"
@implementation GroupModel
- (instancetype)initWithDict:(NSDictionary *)dict
{
    if(self=[super init])
    {
        [self setValuesForKeysWithDictionary:dict];
        NSMutableArray *tempArray=[NSMutableArray array];
        for(NSDictionary *dic in self.cars)
        {
            CarModel *car=[CarModel carWithDict:dic];
            [tempArray addObject:car];
        }
        self.cars=tempArray;
    }
    return self;
}
+ (instancetype)groupWithDict:(NSDictionary *)dict
{
    return  [[self alloc]initWithDict:dict];
}
@end

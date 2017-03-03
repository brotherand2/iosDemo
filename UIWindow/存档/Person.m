//
//  Person.m
//  UIWindow
//
//  Created by Apple on 16/1/20.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "Person.h"

@implementation Person
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeInt:_age forKey:@"age"];
    [aCoder encodeFloat:_height forKey:@"height"];
    [aCoder encodeObject:_name forKey:@"name"];
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    _age=[aDecoder decodeIntForKey:@"age"];
    _height=[aDecoder decodeFloatForKey:@"height"];
    _name=[aDecoder decodeObjectForKey:@"name"];
    return self;
}
- (instancetype)initWithAge:(NSInteger)age andHeight:(float)height angName:(NSString *)name
{
    _age=age;
    _height=height;
    _name=name;
    return self;
}
- (NSString *)description
{
    return [NSString stringWithFormat:@"age=%d,height=%f,name=%@",_age,_height,_name];
}
@end

//
//  ZYHContactModal.m
//  helloworld
//
//  Created by Apple on 16/1/20.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "ZYHContactModal.h"

@implementation ZYHContactModal
+ (instancetype)contactWithName:(NSString *)name andPhone:(NSString *)phone
{
    ZYHContactModal *modal=[[ZYHContactModal alloc]init];
    modal.name=name;
    modal.phone=phone;
    return modal;
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self=[super init]) {
        _name=[aDecoder decodeObjectForKey:@"name"];
        _phone=[aDecoder decodeObjectForKey:@"phone"];
    }
    return self;
}
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_name forKey:@"name"];
    [aCoder encodeObject:_phone forKey:@"phone"];
}
@end

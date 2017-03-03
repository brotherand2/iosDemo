//
//  NSArray+extention.m
//  多线程
//
//  Created by Apple on 16/2/13.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "NSArray+extention.h"
//%@ 会首先调用 -descriptionWithLocale，如果没有返回值，再调用 -description，在调试时，打印一个对象，我们用 po这个命令（它是print object的缩写）
@implementation NSArray (extention)
- (NSString *)descriptionWithLocale:(id)locale
{
    NSMutableString *str=[NSMutableString stringWithString:@"(\n"];
    [self enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [str appendFormat:@"\t%@\n",obj];
    }];
    [str appendString:@")"];
    return str;
}
@end

@implementation NSDictionary(extention)

- (NSString *)descriptionWithLocale:(id)locale
{
    NSMutableString *str=[NSMutableString stringWithString:@"{\n"];
    [self enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        [str appendFormat:@"\t%@ :%@\n",key, obj];
    }];
    [str appendString:@"}\n"];
    return str;
}

@end
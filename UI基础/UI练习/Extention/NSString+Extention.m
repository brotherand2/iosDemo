//
//  NSString+Extention.m
//  helloworld
//
//  Created by Apple on 15/12/17.
//  Copyright © 2015年 Apple. All rights reserved.
//

#import "NSString+Extention.h"

@implementation NSString (Extention)
//返回保存字体需要的大小
- (CGSize)sizeWithMaxSize:(CGSize)maxSize andfont:(UIFont *)font
{
    NSDictionary *textDict=@{NSFontAttributeName:font};
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:textDict context:nil].size;
}
@end

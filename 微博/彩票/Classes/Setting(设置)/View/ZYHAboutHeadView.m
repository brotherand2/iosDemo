//
//  ZYHAboutHeadView.m
//  微博
//
//  Created by Apple on 16/2/5.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "ZYHAboutHeadView.h"

@implementation ZYHAboutHeadView
+ (instancetype)headView
{
    return [[NSBundle mainBundle]loadNibNamed:@"ZYHAboutHeadView" owner:nil options:nil][0];
}
@end

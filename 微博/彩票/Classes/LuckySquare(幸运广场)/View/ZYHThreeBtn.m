//
//  ZYHThreeBtn.m
//  微博
//
//  Created by Apple on 16/2/4.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "ZYHThreeBtn.h"

@implementation ZYHThreeBtn

+ (instancetype)threeBtn
{
    return [[NSBundle mainBundle]loadNibNamed:@"ZYHThreeBtn" owner:self options:nil][0];
}
@end

//
//  ZYHBaseView.m
//  UIWindow
//
//  Created by Apple on 16/1/24.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "ZYHBaseView.h"

@implementation ZYHBaseView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@"%@--- touchesbegin",[self class]);
}
@end

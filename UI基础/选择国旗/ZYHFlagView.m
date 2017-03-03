//
//  ZYHFlagView.m
//  helloworld
//
//  Created by Apple on 16/1/16.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "ZYHFlagView.h"
#import "ZYHFlagModal.h"
@implementation ZYHFlagView
+ (instancetype)flagView:(UIView *)reuseView
{
    if (nil==reuseView) {
        return [[[NSBundle mainBundle]loadNibNamed:@"ZYHFlagView" owner:self options:nil]lastObject];
   
    }
     else
        return (ZYHFlagView*)reuseView;
}
+ (CGFloat)viewHeigh
{
    return 73;
}
- (void)setFlagModal:(ZYHFlagModal *)flagModal
{
    _flagModal=flagModal;
    self.nameView.text=flagModal.name;
    
    self.iconView.image=[UIImage imageNamed:flagModal.icon];
}
@end

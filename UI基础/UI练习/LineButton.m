//
//  LineButton.m
//  helloworld
//
//  Created by Apple on 16/2/2.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "LineButton.h"

@implementation LineButton
- (UIView *)line
{
    if(_line==nil)
    {
        _line=[[UIView alloc]init];
        [_line setBackgroundColor:[UIColor redColor]];
        [self addSubview:_line];
        _line.hidden=YES;
    }
    return _line;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    self.line.frame=CGRectMake(self.titleLabel.frame.origin.x-2, self.bounds.size.height-7, self.titleLabel.bounds.size.width+4, 2);
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

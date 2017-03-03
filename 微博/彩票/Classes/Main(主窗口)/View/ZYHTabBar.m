//
//  ZYHTabBar.m
//  微博
//
//  Created by Apple on 16/2/4.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "ZYHTabBar.h"
#import "ZYHButton.h"
#define itemCount 5

@interface ZYHTabBar()
@property (weak, nonatomic)UIButton *selectedBtn;

@end

@implementation ZYHTabBar

- (void)addTabBarItemWithBkgImageName:(NSString *)bgName andSelectedName:(NSString *)selectName
{
    UIButton *btn=[ZYHButton buttonWithType:UIButtonTypeCustom];
    
    [btn setBackgroundImage:[UIImage imageNamed:bgName] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:selectName] forState:UIControlStateSelected];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    btn.tag=self.subviews.count;
    if(btn.tag==0)
    {
        [self btnClick:btn];
    }
    [self addSubview:btn];
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat btnH=self.bounds.size.height;
    CGFloat btnW=self.bounds.size.width/self.subviews.count;
    for(NSInteger i=0;i<self.subviews.count;i++)
    {
        UIButton *btn=self.subviews[i];
        btn.frame=CGRectMake(btnW*i, 0, btnW, btnH);
    }

}
- (void)btnClick:(UIButton*)btn
{
    _selectedBtn.selected=NO;
    btn.selected=YES;
    _selectedBtn=btn;
    if(_btnClick)
        _btnClick(btn.tag);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

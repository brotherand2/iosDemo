//
//  UIBarButtonItem+extention.m
//  兔小贝儿歌
//
//  Created by Apple on 16/3/28.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "UIBarButtonItem+extention.h"
#import "UIView+Extension.h"

@implementation UIBarButtonItem (extention)
+ (instancetype)itemWithImageName:(NSString *)imageName highlightImageName:(NSString *)highlightName target:(id)target action:(SEL)action
{
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *image=[UIImage imageNamed:imageName];
    [btn setBackgroundImage:image forState:UIControlStateNormal];
    if(highlightName)
    [btn setBackgroundImage:[UIImage imageNamed:highlightName] forState:UIControlStateHighlighted];
    btn.size=btn.currentBackgroundImage.size;
    
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return [[UIBarButtonItem alloc]initWithCustomView:btn];
}
+ (instancetype)itemWithImageName:(NSString *)imageName highlightImageName:(NSString *)highlightName dotImage:(NSString *)dotImageName target:(id)target action:(SEL)action
{
    DotButton *btn=[[DotButton alloc]init];
    UIImage *image=[UIImage imageNamed:imageName];
    [btn setBackgroundImage:image forState:UIControlStateNormal];
    if(highlightName)
        [btn setBackgroundImage:[UIImage imageNamed:highlightName] forState:UIControlStateHighlighted];
    btn.size=btn.currentBackgroundImage.size;
    btn.dotView.image=[UIImage imageNamed:@"common_reddot"];
    btn.dotView.size=btn.dotView.image.size;
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return [[UIBarButtonItem alloc]initWithCustomView:btn];

}
@end
@implementation DotButton

- (instancetype)initWithFrame:(CGRect)frame
{
    if(self=[super initWithFrame:frame])
    {
        UIImageView *imageView=[[UIImageView alloc]init];
        [self addSubview:imageView];
        _dotView=imageView;
    }
    return  self;
}
NSInteger padding=7;
- (void)layoutSubviews
{
    [super layoutSubviews];
    _dotView.x=self.width-_dotView.width-padding;
    _dotView.y=padding;

}
@end

//
//  ZYHMicroBlogData.m
//  helloworld
//
//  Created by Apple on 15/12/1.
//  Copyright © 2015年 Apple. All rights reserved.
//

#import "ZYHMicroBlogData.h"
#import "NSString+Extention.h"
@implementation ZYHMicroBlogData
- (instancetype)initWithDict:(NSDictionary *)dict
{
    if(self=[self init])
    {
        [self setValuesForKeysWithDictionary:dict];
        [self setMicroBlogFrame];
    }
    return self;
}
+ (instancetype)microWithDict:(NSDictionary *)dict
{
    return [[self alloc]initWithDict:dict];
}
/**
 *  设置计算微博窗口大小
 */

- (void)setMicroBlogFrame
{
    CGFloat padding=10;//控件间隔
    CGFloat headViewX=padding;
    CGFloat headViewY=headViewX;
    CGFloat headViewW=60;
    CGFloat headViewH=headViewW;
    _headViewFrame=CGRectMake(headViewX, headViewY, headViewW, headViewH);
    
    CGFloat nameViewX=CGRectGetMaxX(_headViewFrame)+padding;
    CGSize nameMaxSize=CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX);
    CGSize nameSize=[self.name sizeWithMaxSize:nameMaxSize andfont:[UIFont systemFontOfSize:17]];
    
    CGFloat nameViewY=headViewY+(headViewH- nameSize.height)*0.5;
    _nameViewFrame=CGRectMake(nameViewX, nameViewY, nameSize.width, nameSize.height);
    
    
    
    CGFloat vipViewX=CGRectGetMaxX(_nameViewFrame)+padding;
    CGFloat vipViewY=nameViewY;
    CGFloat vipViewW=20;
    CGFloat vipViewH=20;
    _vipViewFrame=CGRectMake(vipViewX, vipViewY, vipViewW, vipViewH);
    
    
    CGFloat textViewX=headViewX;
    CGFloat textViewY=CGRectGetMaxY(_headViewFrame)+padding;
    CGSize textMaxSize=CGSizeMake(355, MAXFLOAT);
    CGSize textSize=[self.text sizeWithMaxSize:textMaxSize andfont:[UIFont systemFontOfSize:17]];
    _textViewFrame=CGRectMake(textViewX, textViewY, textSize.width, textSize.height);
    
    if(self.picture)
    {
        CGFloat pictureViewX=textViewX;
        CGFloat pictureViewY=CGRectGetMaxY(_textViewFrame)+padding;
        CGFloat pictureViewW=100;
        CGFloat pictureViewH=60;
        _pictureViewFrame=CGRectMake(pictureViewX, pictureViewY, pictureViewW, pictureViewH);
        _cellHeight=CGRectGetMaxY(_pictureViewFrame)+padding;
    }
    else
        _cellHeight=CGRectGetMaxY(_textViewFrame)+padding;
    
}
@end

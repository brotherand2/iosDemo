//
//  ZYHMessage.m
//  helloworld
//
//  Created by Apple on 15/12/15.
//  Copyright © 2015年 Apple. All rights reserved.
//

#import "ZYHMessage.h"
#include "NSString+Extention.h"
@implementation ZYHMessage
//字典转模型定义
- (instancetype)initWithDict:(NSDictionary *)dict
{
    if(self=[self init])
    {
        [self setValuesForKeysWithDictionary:dict];
        //[self setFrame];
    }
    return self;
}
+ (instancetype)messageWithDict:(NSDictionary *)dict
{
    return [[self alloc]initWithDict:dict];
}
/**
 *  设置格子的各个控件的高度
 */
- (void)calculateFrame
{
    CGFloat screenW=[UIScreen mainScreen].bounds.size.width;//获取屏幕宽度
    //计算时间
    if(self.isHiddenTime==NO)
    {
        CGFloat timeViewX=0;
        CGFloat timeViewY=0;
        CGFloat timeViewW=screenW;
        CGFloat timeViewH=30;
        _timeF=CGRectMake(timeViewX, timeViewY, timeViewW, timeViewH);
    }
    
    //计算头像
    CGFloat padding=10;//控件间间隔
    CGFloat headViewX=0;
    CGFloat headViewY=CGRectGetMaxY(_timeF);
    CGFloat headViewW=40;
    CGFloat headViewH=headViewW;
    if(self.type==ZYHMessageTypeOther)
        headViewX=padding;
    else
        headViewX=screenW-padding-headViewW;
    _headF=CGRectMake(headViewX, headViewY, headViewW, headViewH);
    
    //计算文本大小
    CGFloat textViewY=headViewY;
    CGSize textMaxSize=CGSizeMake(screenW-textPadding*2-3*(headViewW+padding), MAXFLOAT);
    
    
    CGSize  textSize=[self.text sizeWithMaxSize:textMaxSize andfont:ZYHFONT];//返回保存字体需要的大小
    CGFloat textViewX=0;
    if(self.type==ZYHMessageTypeOther)
        textViewX=CGRectGetMaxX(_headF)+padding;
    else
        textViewX=headViewX-padding-textPadding*2-textSize.width;
    _textF=CGRectMake(textViewX, textViewY, textPadding*2+textSize.width, textPadding*2+textSize.height);
    
    
    //计算格子的高度
    CGFloat maxHeadY=CGRectGetMaxY(_headF);
    CGFloat maxTextY=CGRectGetMaxY(_textF);
    if(maxHeadY>maxTextY)
        _cellHeight=maxHeadY+padding;
    else
        _cellHeight=maxTextY+padding;
}
@end

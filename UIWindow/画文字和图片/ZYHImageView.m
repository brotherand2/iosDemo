//
// 文件名： ZYHImageView.m
// 项目名： UIWindow
// 创建者：Apple
// 日期时间 :16/1/26 10:43
// 版权：  Copyright © 2016年 Apple. All rights reserved.
//

#import "ZYHImageView.h"

@implementation ZYHImageView


- (void)drawRect:(CGRect)rect
{
    CGFloat w=rect.size.width;
    CGFloat h=rect.size.height;
    UIImage *image=[UIImage imageNamed:@"papa"];
    //[image drawAtPoint:CGPointMake(0, 0)];
    //[image drawInRect:CGRectMake(10, 40, 40, 40)];
    [image drawAsPatternInRect:CGRectMake(20, 20, w-40, h-40)];//平铺绘制
    //画文字
    NSString *text = @"B04.画文字和图片sdfasdfsdab这个方法不会换行adasdfasdfsdabadasdfa这个方法不会换行B04.画文字和图片sdfasdfsdab这个方法不会换行adasdfasdfsdabadasdfa这个方法Putranto表示，发现这些残骸的位置距离飞机最后被雷达捕获的位置大约10公里。报道称，这名官员展示了10张照片，照片中的物体类似飞机舱门、紧急滑道以及一个方形的箱子。";
    //这个方法不会换行
    //[text drawAtPoint:CGPointMake(0, 0) withAttributes:nil];
    //[text drawInRect:CGRectMake(50, 50, w-100,100) withAttributes:nil];
    NSMutableDictionary *dict=[NSMutableDictionary dictionary];
    dict[NSFontAttributeName]=[UIFont systemFontOfSize:13];
    dict[NSForegroundColorAttributeName]=[UIColor yellowColor];
    [text drawInRect:CGRectMake(10, 10, w-20, h*0.5) withAttributes:dict];
    
}
@end

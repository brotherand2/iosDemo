//
// 文件名： ZYHPieView.m
// 项目名： UIWindow
// 创建者：Apple
// 日期时间 :16/1/26 17:21
// 版权：  Copyright © 2016年 Apple. All rights reserved.
//

#import "ZYHPieView.h"

@implementation ZYHPieView


- (void)drawRect:(CGRect)rect
{
    NSInteger count=_sections.count;
    if (count<=0) {
        return;
    }
    CGFloat width=rect.size.width;
    CGFloat height=rect.size.height;
    CGFloat radius=width>height?height/2:width/2;
    CGFloat beginAngle=0;
    CGFloat sum=0;
    for (NSInteger i=0; i<count; i++) {
        sum+=[_sections[i] integerValue];
    }
    CGContextRef context=UIGraphicsGetCurrentContext();
    for (NSInteger i=0; i<count; i++) {
        UIColor *color=self.sectionColor[i];
        [color set];
        CGFloat scale=[_sections[i] integerValue]/sum;
        CGFloat endAngle=beginAngle+scale*M_PI*2;
        CGContextMoveToPoint(context, width*0.5, height*0.5);
        CGContextAddArc(context, width*0.5, height*0.5, radius, beginAngle, endAngle,0);
        NSLog(@"scale:%f startAngle:%f endAngle:%f",scale, beginAngle,endAngle);

        CGContextFillPath(context);
        beginAngle=endAngle;
    }
}
@end

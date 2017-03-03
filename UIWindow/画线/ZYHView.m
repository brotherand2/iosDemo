//
//  ZYHView.m
//  UIWindow
//
//  Created by Apple on 16/1/25.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "ZYHView.h"

@implementation ZYHView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)drawRect:(CGRect)rect
{
    [self bezierPath];
    [self drawLine];
    [self drawTriangle];
     [self drawRectangle];
    [self drawSector];
    [self drawArc];
    [self drawCircle];
    [self drawCurve];
}
- (void)drawCurve
{
    //绘制曲线
    CGContextRef context=UIGraphicsGetCurrentContext();
    UIBezierPath *path=[[UIBezierPath alloc]init];
    CGPoint  start=CGPointMake(100, 460);
    CGPoint  end=CGPointMake(300, 460);
    CGPoint  control=CGPointMake(150,350);
    [path moveToPoint:start];
    [path addQuadCurveToPoint:end controlPoint:control];
    CGContextAddPath(context, path.CGPath);
    
    CGContextStrokePath(context);
}
- (void)bezierPath
{
    CGContextRef context=UIGraphicsGetCurrentContext();
    UIBezierPath *path=[[UIBezierPath alloc]init];
    [path moveToPoint:CGPointMake(100, 10)];
    [path addLineToPoint:CGPointMake(400, 10)];
    [path addLineToPoint:CGPointMake(300, 40)];
    [path closePath];
    
    CGContextAddPath(context, path.CGPath);
    [[UIColor blueColor] setFill];
    //CGContextStrokePath(context);
    CGContextFillPath(context);
    path=[UIBezierPath bezierPathWithRoundedRect:CGRectMake(200, 500, 100, 100) cornerRadius:10];
    CGContextAddPath(context, path.CGPath);
    path=[UIBezierPath bezierPathWithOvalInRect:CGRectMake(200, 500, 100, 100)];
     CGContextAddPath(context, path.CGPath);
    CGContextStrokePath(context);
}
- (void)drawLine
{
    
    CGContextRef context=UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    CGContextMoveToPoint(context, 10, 10);
    CGContextSetRGBStrokeColor(context, 1, 0, 0, 1);
    CGContextSetLineWidth(context, 11);
    //设置头尾样式
    CGContextSetLineCap(context, kCGLineCapRound);
    //设置连接点样式
    CGContextSetLineJoin(context, kCGLineJoinMiter);
    CGContextAddLineToPoint(context, 30, 100);
    CGContextAddLineToPoint(context, 100, 160);
    CGContextStrokePath(context);

    
}
- (void)drawTriangle
{
    CGContextRef context=UIGraphicsGetCurrentContext();
    CGContextMoveToPoint(context, 70, 50);
    CGContextAddLineToPoint(context, 170, 50);
    CGContextAddLineToPoint(context, 170, 150);
    CGContextSetRGBStrokeColor(context, 0.53, 0.25, 0.25, 1);
    CGContextClosePath(context);
    
    CGContextStrokePath(context);
}
- (void)drawRectangle
{
    CGContextRef context=UIGraphicsGetCurrentContext();
    CGContextSetRGBStrokeColor(context, 0, 0, 1, 1);
    CGContextSetLineWidth(context, 5);
    CGContextMoveToPoint(context, 50, 200);
    CGContextAddLineToPoint(context, 200, 200);
    CGContextAddLineToPoint(context, 200, 400);
    CGContextAddLineToPoint(context, 50, 400);
    CGContextClosePath(context);
    CGContextStrokePath(context);
    CGContextAddRect(context, CGRectMake(20, 190, 200, 200));
    CGContextRestoreGState(context);
    CGContextStrokePath(context);
    CGContextSaveGState(context);
    CGContextAddRect(context, CGRectMake(70, 220, 100, 100));
    [[UIColor purpleColor]setFill];
    [[UIColor redColor]setStroke];
    CGContextSetLineWidth(context, 15);
   // CGContextFillPath(context);
    CGContextDrawPath(context, kCGPathFillStroke);//即填充又描边
    CGContextRestoreGState(context);
    
}
//画扇形
- (void)drawSector
{
    CGContextRef context=UIGraphicsGetCurrentContext();
    CGContextSetRGBStrokeColor(context, 0.24, 0.77, 0.77, 1);
    CGContextMoveToPoint(context, 300, 150);
    /**
     *x,y 圆心
     *radius 半径
     *startAngle 画弧的起始位置
     *endAngel 画弧的结束位置
     * clockwise 0 顺针 1 逆时针
     */

    CGContextAddArc(context, 300, 150, 60, -M_PI_4, -3*M_PI_4, 1);
    CGContextClosePath(context);
    CGContextStrokePath(context);
    
}
//画弧
- (void)drawArc
{
    CGContextRef context=UIGraphicsGetCurrentContext();
    CGContextSetRGBStrokeColor(context, 0.11, 0.22, 0.33, 1);
    CGContextAddArc(context, 300, 400, 60, 0, -M_PI, 1);
    CGContextStrokePath(context);
}
//画圆
- (void)drawCircle
{
    CGContextRef context=UIGraphicsGetCurrentContext();
    CGContextSetRGBStrokeColor(context, 0.22, 0.33, 0.44, 1);
    CGContextAddEllipseInRect(context, CGRectMake(50, 450, 100, 100));
   
    CGContextStrokePath(context);
}
@end

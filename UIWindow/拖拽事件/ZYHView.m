//
//  ZYHView.m
//  UIWindow
//
//  Created by Apple on 16/1/24.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "ZYHView.h"

@implementation ZYHView

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@"redView开始拖拽");
    UITouch *touch=touches.anyObject;
    NSLog(@"redView手势个数%ld  被按次数%ld 状态%ld",touches.count,touch.tapCount,(long)touch.phase);
    //[super touchesBegan:touches withEvent:event];
}
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
   
    UITouch *touch=touches.anyObject;
    CGPoint current=[touch locationInView:self];
    CGPoint previousPoint=[touch previousLocationInView:self];
     NSLog(@"redView拖拽移动 point=%@",NSStringFromCGPoint(current));
    CGFloat offsetX=current.x-previousPoint.x;
    CGFloat offsetY=current.y-previousPoint.y;
    CGPoint center=self.center;
    center.x+=offsetX;
    center.y+=offsetY;
    self.center=center;
}
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@"redView拖拽结束");
}
@end

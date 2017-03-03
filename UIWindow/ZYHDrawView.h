//
//  ZYHDrawView.h
//  UIWindow
//
//  Created by Apple on 16/1/27.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZYHDrawView : UIView
{
    @public
    CGContextRef context;
}
@property(nonatomic,strong) NSMutableArray *locations;//气球位置
@property(nonatomic,strong) UIImage *image;//气球
@property(nonatomic,strong) CADisplayLink *timer;//定时器

@end

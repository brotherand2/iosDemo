//
//  ZYHBezierPath.h
//  helloworld
//
//  Created by Apple on 16/1/28.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZYHBezierPath : UIBezierPath
@property(nonatomic,strong) UIColor *color;
+ (instancetype)paintPathWithLineWidth:(NSInteger)width andColor:(UIColor*)color;
@end

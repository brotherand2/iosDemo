//
//  Person.h
//  UIWindow
//
//  Created by Apple on 16/1/20.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject<NSCoding>
@property(nonatomic,assign) NSInteger age;
@property(nonatomic,assign) float height;
@property(nonatomic,copy)NSString *name;
- (instancetype)initWithAge:(NSInteger)age andHeight:(float)height angName:(NSString*)name;
@end

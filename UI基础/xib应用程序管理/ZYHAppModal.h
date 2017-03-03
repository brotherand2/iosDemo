//
//  ZYHAppModal.h
//  helloworld
//
//  Created by Apple on 16/1/7.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZYHAppModal : NSObject
@property(nonatomic,copy)NSString *name;
@property(nonatomic,copy)NSString *icon;
//字典转模型声明
- (instancetype)initWithDict:(NSDictionary*)dict;
+ (instancetype)appWithDict:(NSDictionary*)dict;
@end

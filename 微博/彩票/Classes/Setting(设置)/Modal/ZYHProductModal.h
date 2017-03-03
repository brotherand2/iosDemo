//
//  ZYHProductModal.h
//  微博
//
//  Created by Apple on 16/2/8.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZYHProductModal : NSObject
@property(nonatomic,copy)NSString *title;
@property(nonatomic,copy)NSString *identifier;
@property(nonatomic,copy)NSString *url;
@property(nonatomic,copy)NSString *icon;
@property(nonatomic,copy)NSString *customUrl;
//字典转模型声明
- (instancetype)initWithDict:(NSDictionary*)dict;
+ (instancetype)productWithDict:(NSDictionary*)dict;
@end

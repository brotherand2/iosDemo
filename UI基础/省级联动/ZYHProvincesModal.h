//
//  ZYHProvincesModal.h
//  helloworld
//
//  Created by Apple on 16/1/16.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZYHProvincesModal : NSObject
@property(nonatomic,copy)NSString *name;
@property(nonatomic,strong) NSArray *cities;
//字典转模型声明
- (instancetype)initWithDict:(NSDictionary*)dict;
+ (instancetype)provincesWithDict:(NSDictionary*)dict;
@end

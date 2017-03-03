//
//  GirlModal.h
//  helloworld
//
//  Created by Apple on 16/2/1.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GirlModal : NSObject
@property(nonatomic,copy)NSString *titileName;
@property(nonatomic,copy)NSString *imageName;
@property(nonatomic,assign) BOOL isOpen;
//字典转模型声明
- (instancetype)initWithDict:(NSDictionary*)dict;
+ (instancetype)girlWithDict:(NSDictionary*)dict;
@end

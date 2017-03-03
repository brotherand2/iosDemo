//
//  ZYHCategoryModal.h
//  UIWindow
//
//  Created by Apple on 16/2/10.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZYHCategoryModal : NSObject
@property(nonatomic,copy)NSString *highlighted_icon;
@property(nonatomic,strong)NSArray *subcategories;
@property(nonatomic,copy)NSString *icon;
@property(nonatomic,copy)NSString *name;
//字典转模型声明
- (instancetype)initWithDict:(NSDictionary*)dict;
+ (instancetype)categoryWithDict:(NSDictionary*)dict;
@end

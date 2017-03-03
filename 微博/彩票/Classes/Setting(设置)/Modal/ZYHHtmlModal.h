//
//  ZYHHtmlModal.h
//  微博
//
//  Created by Apple on 16/2/6.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZYHHtmlModal : NSObject
@property(nonatomic,copy)NSString *title;
@property(nonatomic,copy)NSString *html;
@property(nonatomic,copy)NSString *ID;
//字典转模型声明
- (instancetype)initWithDict:(NSDictionary*)dict;
+ (instancetype)htmlWithDict:(NSDictionary*)dict;
@end

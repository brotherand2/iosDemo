//
//  ZYHQuestionModal.h
//  微博
//
//  Created by Apple on 16/1/8.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZYHQuestionModal :NSObject
@property(nonatomic,copy)NSString *title;
@property(nonatomic,copy)NSString *answer;
@property(nonatomic,copy)NSString *icon;
@property(nonatomic,strong) NSArray*options;

//字典转模型声明
- (instancetype)initWithDict:(NSDictionary*)dict;
+ (instancetype)questionWithDict:(NSDictionary*)dict;
@end

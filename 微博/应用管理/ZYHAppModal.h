//
//  ZYHAppModal.h
//  微博
//
//  Created by Apple on 15/12/17.
//  Copyright © 2015年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZYHAppModal : NSObject
@property(nonatomic,copy)NSString *name;
@property(nonatomic,copy)NSString *icon;
@property(nonatomic,copy)NSString *size;
@property(nonatomic,copy)NSString *download;


//是否已下载
@property(nonatomic,assign,getter=isDownLoaded)BOOL downloaded;

//字典转模型声明
- (instancetype)initWithDict:(NSDictionary*)dict;
+ (instancetype)appWithDict:(NSDictionary*)dict;
@end

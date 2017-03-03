//
//  ZYHMicroBlogData.h
//  helloworld
//
//  Created by Apple on 15/12/1.
//  Copyright © 2015年 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface ZYHMicroBlogData : NSObject
@property(nonatomic,copy)NSString *name;
@property(nonatomic,copy)NSString *icon;
@property(nonatomic,copy)NSString *text;
@property(nonatomic,copy)NSString *picture;
@property(nonatomic,assign,getter=isVip)BOOL vip;

@property(nonatomic,assign,readonly)CGRect headViewFrame;
@property(nonatomic,assign,readonly)CGRect nameViewFrame;
@property(nonatomic,assign,readonly)CGRect vipViewFrame;
@property(nonatomic,assign,readonly)CGRect textViewFrame;
@property(nonatomic,assign,readonly)CGRect pictureViewFrame;

@property(nonatomic,assign,readonly)CGFloat cellHeight;
- (instancetype)initWithDict:(NSDictionary*)dict;
+ (instancetype)microWithDict:(NSDictionary*)dict;

@end

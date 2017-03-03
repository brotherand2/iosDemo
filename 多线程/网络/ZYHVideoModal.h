//
//  ZYHVideoModal.h
//  多线程
//
//  Created by Apple on 16/2/14.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZYHVideoModal : NSObject
@property(nonatomic,copy)NSNumber *videoId;
@property(nonatomic,copy)NSString *videoURL;
@property(nonatomic,copy) NSNumber *length;
@property(nonatomic,copy)NSString *imageURL;
@property(nonatomic,copy)NSString *desc;
@property(nonatomic,copy)NSString *teacher;
@property(nonatomic,copy)NSString *time;
@property(nonatomic,copy)NSString *name;
//字典转模型声明
- (instancetype)initWithDict:(NSDictionary*)dict;
+ (instancetype)videoWithDict:(NSDictionary*)dict;
@end
@interface ZYHMessageModal : NSObject
@property(nonatomic,copy)NSString *messageId;
//@property(nonatomic,copy) NSNumber *messageId;
@property(nonatomic,copy)NSString *message;
//字典转模型声明
- (instancetype)initWithDict:(NSDictionary*)dict;
+ (instancetype)messageWithDict:(NSDictionary*)dict;
@end

//
//  ZYHMessage.h
//  helloworld
//
//  Created by Apple on 15/12/15.
//  Copyright © 2015年 Apple. All rights reserved.
//

#ifndef ZYHMessage_h
#define ZYHMessage_h
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#define ZYHFONT [UIFont systemFontOfSize:16]
#define textPadding 30//字体与图片的间距
typedef enum
{
    ZYHMessageTypeMe,
    ZYHMessageTypeOther
}ZYHMessageType;
@interface ZYHMessage : NSObject
@property(nonatomic,copy)NSString *time;//时间
@property(nonatomic,copy)NSString *text;//消息内容
@property(nonatomic,assign)ZYHMessageType type;//头像类型
@property(nonatomic,assign,getter=isHiddenTime)BOOL hiddenTime;//是否隐藏时间


//格子各个控件
@property(nonatomic,assign,readonly)CGRect timeF;//时间控件大小
@property(nonatomic,assign,readonly)CGRect headF;//头像大小
@property(nonatomic,assign,readonly)CGRect textF;//文本内容大小

@property(nonatomic,assign,readonly)CGFloat cellHeight;//格子高度
- (instancetype)initWithDict:(NSDictionary*)dict;
+ (instancetype)messageWithDict:(NSDictionary*)dict;
- (void)calculateFrame;
@end


#endif /* ZYHMessage_h */

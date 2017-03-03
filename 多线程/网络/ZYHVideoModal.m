//
//  ZYHVideoModal.m
//  多线程
//
//  Created by Apple on 16/2/14.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "ZYHVideoModal.h"

@implementation ZYHVideoModal


//字典转模型定义
- (instancetype)initWithDict:(NSDictionary *)dict
{
    if(self=[self init])
    {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}
+ (instancetype)videoWithDict:(NSDictionary *)dict
{
    return [[self alloc]initWithDict:dict];
}
- (NSString *)time
{
    int len=self.length.intValue;
    return [NSString stringWithFormat:@"%2d:%2d:%2d",len/3600,(len%3600)/60,len%60];
}
- (NSString *)description
{
    return [NSString stringWithFormat:@"<%@,%p>\n{\nvideoId=%@,videoURL=%@,name=%@,length=%@,imageURL=%@,desc=%@,teacher=%@,time=%@\n}",[self class],self, self.videoId,self.videoURL,self.name,self.length,self.imageURL,self.desc,self.teacher,self.time];
}
@end
@implementation ZYHMessageModal

//字典转模型定义
- (instancetype)initWithDict:(NSDictionary *)dict
{
    if(self=[self init])
    {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}
+ (instancetype)messageWithDict:(NSDictionary *)dict
{
    return [[self alloc]initWithDict:dict];
}
- (NSString *)description
{
    return [NSString stringWithFormat:@"<%@,%p>\n{\nid=%@,message=%@\n}", [self class],self, self.messageId,self.message];
}
@end

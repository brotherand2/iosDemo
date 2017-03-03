//
//  ZYHVideoTool.h
//  多线程
//
//  Created by Apple on 16/2/19.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZYHVideoTool : NSObject
+ (NSArray*)parseXMLData:(NSData*)data;
+ (NSArray*)parseJSONData:(NSData*)data;
@end

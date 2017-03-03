//
//  NSMutableURLRequest+extention.h
//  多线程
//
//  Created by Apple on 16/2/17.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableURLRequest (extention)
+ (void)upload:(NSString*)name fileName:(NSString*)fileName urlStr:(NSString*)urlStr data:(NSData*)data params:(NSDictionary*)params;
@end

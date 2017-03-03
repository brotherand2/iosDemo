//
//  NSString+extention.h
//  兔小贝儿歌
//
//  Created by Apple on 16/4/29.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (file)
/**
 * 获取的文件路径
 *
 *
 *  @param directory 要保存的目录
 *
 *  @return 文件路径
 */
- (NSString*)filePathWithDirectory:(NSString*)directory;

/**
 *  获取指定路径的文件大小
 *
 *  @return 文件大小
 */
- (unsigned long long)fileSize;
/**
 *  获取指定路径的格式化文件大小,如3Mb 4Kb
 *
 *  @return 文件大小
 */
- (NSString*)formatFileSize;
/**
 *  获取指定路径的格式化文件大小,如3Mb 4Kb
 *@fileSize 文件大小字节
 *  @return 文件大小
 */
+ (NSString*)formatFileSizeWithSize:(long long)fileSize;
/**
 *  判断当前文件是否存在
 *
 *  @return BOOL
 */
- (BOOL)fileExist;
@end

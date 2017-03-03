//
//  NSString+extention.m
//  兔小贝儿歌
//
//  Created by Apple on 16/4/29.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "NSString+file.h"

@implementation NSString (file)
- (NSString*)filePathWithDirectory:(NSString*)directory
{
    BOOL isDirectory;
    if(![[NSFileManager defaultManager] fileExistsAtPath:directory isDirectory:&isDirectory]) {
        isDirectory = NO;
    }
    // If targetPath is a directory, use the file name we got from the urlRequest.
    if (isDirectory)
    {
        NSString *fileName = [self lastPathComponent];
        return [NSString pathWithComponents:@[directory, fileName]];
    }else {
        return nil;
    }
    
}
- (unsigned long long)fileSize
{
    signed long long fileSize = 0;
    NSFileManager *fileManager = [NSFileManager new]; // default is not thread safe
    if ([fileManager fileExistsAtPath:self]) {
        NSError *error = nil;
        NSDictionary *fileDict = [fileManager attributesOfItemAtPath:self error:&error];
        if (!error && fileDict) {
            fileSize = [fileDict fileSize];
        }
    }
    return fileSize;
}
- (NSString *)formatFileSize
{
    signed long long fileSize=[self fileSize];
    return [NSString formatFileSizeWithSize:fileSize];
}
+ (NSString *)formatFileSizeWithSize:(long long)fileSize
{
    int GSize=(int)fileSize/(1024*1024*1024);//多少 G
    
    fileSize=fileSize%(1024*1024*1024);
    float MBSize=fileSize/(1024*1024*1.0);//多少 MB

    NSString *formatSize=[NSString string];
    if(GSize)
        formatSize=[formatSize stringByAppendingFormat:@"%dG",GSize];
    if(MBSize)
        formatSize=[formatSize stringByAppendingFormat:@"%.2fMb",MBSize];
    
    return formatSize;

}
 - (BOOL)fileExist
{
   return [[NSFileManager defaultManager] fileExistsAtPath:self];
}
@end

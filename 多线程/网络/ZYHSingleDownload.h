//
//  ZYHSingleDownload.h
//  多线程
//
//  Created by Apple on 16/2/19.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface ZYHDownload:NSObject
@property(nonatomic,copy)NSString *urlString;
@property(nonatomic,copy)NSString *savePath;

@property(nonatomic,copy) void(^progressHandler)(CGFloat progress) ;
@property(nonatomic,copy) void(^completeHandler)();
@property(nonatomic,copy) void(^failtureHandler)();
@end

@interface ZYHSingleDownload : ZYHDownload
@property(nonatomic,assign) long long begin;
@property(nonatomic,assign) long long end;
@property(nonatomic,assign) BOOL isFinished;
@property(nonatomic,assign) long long currentLength;
@property(nonatomic,assign) long long fileSize;

@property(nonatomic,strong) NSFileHandle *writeHandle;
@property(nonatomic,strong) NSURLConnection *connect;
@property(nonatomic,assign) CGFloat scale;

- (void)start;
- (void)pause;
@end

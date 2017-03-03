//
//  ZYHDownloadTool.h
//  多线程
//
//  Created by Apple on 16/2/19.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface ZYHDownloadTool : NSObject
@property(nonatomic,assign) long long currentLength;
@property(nonatomic,assign) long long expectLength;
@property(nonatomic,assign) BOOL isFinish;
@property(nonatomic,strong) NSFileHandle *writeHandle;
@property(nonatomic,strong) NSURLConnection *connect;
@property(nonatomic,copy)NSString *urlString;
@property(nonatomic,copy) void(^progressHandler)(CGFloat progress) ;
@property(nonatomic,copy) void(^completeHandler)();
@property(nonatomic,copy) void(^failtureHandler)();
@property(nonatomic,copy)NSString *savePath;
- (void)start;
- (void)pause;
@end

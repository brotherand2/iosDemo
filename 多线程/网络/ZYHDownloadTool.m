//
//  ZYHDownloadTool.m
//  多线程
//
//  Created by Apple on 16/2/19.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "ZYHDownloadTool.h"

@implementation ZYHDownloadTool

- (void)start
{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        self.isFinish=NO;
        NSURL *url=[NSURL URLWithString:_urlString];
        NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url];
        NSString *value=[NSString stringWithFormat:@"bytes=%lld-",_currentLength];
        [request setValue:value forHTTPHeaderField:@"Range"];
        _connect=[NSURLConnection connectionWithRequest:request delegate:self];
        [_connect start];
        // 设置代理工作的队列（把代理的工作放到子线程）
        [_connect setDelegateQueue:[[NSOperationQueue alloc] init]];

        do {
            [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.1]];
        } while (!self.isFinish);
        NSLog(@"come here");
    });
    
    // 设置运行循环
//    [_connect scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
//
//    [_connect setDelegateQueue:[[NSOperationQueue alloc]init]];
}
- (void)pause
{
    [_connect cancel];
    _connect=nil;
}
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    if(_failtureHandler)
        _failtureHandler();
}
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    //[self.data appendData:data];
    _currentLength+=data.length;
    CGFloat scale=1.0*_currentLength/_expectLength;
    if(_progressHandler)
        _progressHandler(scale);
    [_writeHandle seekToEndOfFile];
    [_writeHandle writeData:data];
    //NSLog(@"%f-%@",scale,[NSThread currentThread]);
}
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    if(_expectLength)
        return;//说明正在下载
    _expectLength=response.expectedContentLength;
//    NSFileManager *fileManager=[NSFileManager defaultManager];
//    [fileManager createFileAtPath:_savePath contents:nil attributes:nil];
    self.writeHandle=[NSFileHandle fileHandleForWritingAtPath:_savePath];
}
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    //    NSString *cachesPath=NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
    //    NSString *savePath=[cachesPath stringByAppendingPathComponent:@"a.mp4"];
    //    [self.data writeToFile:savePath atomically:YES];
    [self.writeHandle closeFile];
    self.writeHandle=nil;
    _currentLength=0;
    _connect=nil;
    _expectLength=0;
    self.isFinish=YES;
    if(_completeHandler)
        _completeHandler();
}

@end

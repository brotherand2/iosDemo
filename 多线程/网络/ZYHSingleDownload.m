//
//  ZYHSingleDownload.m
//  多线程
//
//  Created by Apple on 16/2/19.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "ZYHSingleDownload.h"

@implementation ZYHSingleDownload
- (void)start
{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        self.isFinished=NO;
         NSURL *url=[NSURL URLWithString:self.urlString];
        NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url];
        NSString *value=[NSString stringWithFormat:@"bytes=%lld-%lld",_begin+_currentLength,_end];
        [request setValue:value forHTTPHeaderField:@"Range"];
        _connect=[NSURLConnection connectionWithRequest:request delegate:self];
        [_connect setDelegateQueue:[[NSOperationQueue alloc]init]];
        [_connect start];
        do {
            [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.1]];
        } while (!self.isFinished);
    });
   
    
}
- (void)pause
{
    [_connect cancel];
    _connect=nil;
}
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    if(self.failtureHandler)
      self.failtureHandler();

}
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    //[self.data appendData:data];
    //[_writeHandle seekToEndOfFile];
    [_writeHandle seekToFileOffset:_begin+_currentLength];
      _currentLength+=data.length;
    self.scale=1.0*_currentLength/_fileSize;
    if(self.progressHandler)
        self.progressHandler(self.scale);
    [_writeHandle writeData:data];
    
    NSLog(@"%f-%@",self.scale,[NSThread currentThread]);
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    self.writeHandle=[NSFileHandle fileHandleForWritingAtPath:self.savePath];
}
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
   
    [self.writeHandle closeFile];
    self.writeHandle=nil;
    _currentLength=0;
    _connect=nil;
    self.isFinished=YES;
    NSLog(@"begin=%lld end=%lld scale=%f",self.begin,self.end,self.scale);
    if(self.completeHandler)
        self.completeHandler();
}

@end
@implementation ZYHDownload



@end

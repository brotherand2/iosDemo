//
//  ZYHMultiDownload.m
//  多线程
//
//  Created by Apple on 16/2/19.
//  Copyright © 2016年 Apple. All rights reserved.
//
/*
 使用NSURLConnect代理来下载文件，下载过程在主线程，会使进度条绘制不正常，因为重绘的优先级最度，同时开几个NSURLConnect会使进度条卡住*/
#import "ZYHMultiDownload.h"

@interface ZYHMultiDownload()

@property(nonatomic,assign) long long totalLength;
@end

@implementation ZYHMultiDownload
- (NSMutableArray *)singleDownloads
{
    if(_singleDownloads==nil)
    {
        [self getFileSize];
        _singleDownloads=[NSMutableArray array];
        for(NSInteger i=0;i<ZYHMaxDownloadCount;i++)
        {
            ZYHSingleDownload *download=[[ZYHSingleDownload alloc]init];
            download.fileSize=(_totalLength%ZYHMaxDownloadCount)?(_totalLength/ZYHMaxDownloadCount):(_totalLength/ZYHMaxDownloadCount+1);
            download.begin=download.fileSize*i;
            download.end=download.fileSize*(i+1)-1;
            download.urlString=self.urlString;
            download.savePath=self.savePath;
            __weak typeof(self)selfObj=self;
            download.progressHandler=^(CGFloat scale)
            {
                if(selfObj.progressHandler)
                    selfObj.progressHandler(scale);
            };
            download.completeHandler=^()
            {
                selfObj.completeCount++;
                if(selfObj.completeCount==ZYHMaxDownloadCount)
                {
                    selfObj.completeCount=0;
                    if(selfObj.completeHandler)
                        selfObj.completeHandler();
                }
            };
            [_singleDownloads addObject:download];
        }

    }
    return _singleDownloads;
}
- (void)getFileSize
{
    NSURL *url=[NSURL URLWithString:self.urlString];
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod=@"HEAD";
    NSURLResponse *resonse;
    [NSURLConnection sendSynchronousRequest:request returningResponse:&resonse error:NULL];
    _totalLength=resonse.expectedContentLength;
}
- (void)start
{
    [self.singleDownloads makeObjectsPerformSelector:@selector(start)];
}
- (void)pause
{
    [self.singleDownloads makeObjectsPerformSelector:@selector(pause)];
}
@end

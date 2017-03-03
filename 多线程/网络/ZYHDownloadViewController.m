//
//  ZYHDownloadViewController.m
//  多线程
//
//  Created by Apple on 16/2/19.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "ZYHDownloadViewController.h"
#import "ZYHMultiDownload.h"
#import "ZYHSingleDownload.h"
#import "ZYHDownloadTool.h"
#import "SSZipArchive.h"
@interface ZYHDownloadViewController ()<NSURLConnectionDataDelegate,NSURLSessionDownloadDelegate>
@property (weak, nonatomic) IBOutlet UISlider *sliderView;
@property (weak, nonatomic) IBOutlet UIButton *btn;
@property(nonatomic,strong) ZYHDownloadTool *downloadTool;
@property(nonatomic,strong) ZYHDownloadTool *downloadZip;
@property(nonatomic,strong) ZYHMultiDownload *multiDown;
@property(nonatomic,strong) NSURLSession *session;
@property(nonatomic,strong) NSURLSessionDownloadTask *downladTask;
@property(nonatomic,strong) NSData *resumeData;
@property(nonatomic,copy)NSString *savePath;
@end

@implementation ZYHDownloadViewController
- (NSURLSession *)session
{
    if(_session==nil)
    {
        NSURLSessionConfiguration *configure=[NSURLSessionConfiguration defaultSessionConfiguration];
        _session=[NSURLSession sessionWithConfiguration:configure delegate:self delegateQueue:nil];
    }
    return _session;
}
- (ZYHDownloadTool *)downloadTool
{
    if(_downloadTool==nil)
    {
        _downloadTool=[[ZYHDownloadTool alloc]init];
        _downloadTool.savePath=_savePath;
        NSString *urlString=[NSString stringWithFormat:@"http://%@/剩者为王2015.TC720P.国语中英双字.mkv",IPAdd];
        urlString=[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        _downloadTool.urlString=urlString;
        __weak typeof(self)selfObj=self;
        _downloadTool.completeHandler=^{
             NSLog(@"%s",__func__);
            [selfObj.btn setTitle:@"开始" forState:UIControlStateNormal];
            selfObj.isBegin=NO;
        };
        _downloadTool.failtureHandler=^{
             NSLog(@"%s",__func__);
        };
        _downloadTool.progressHandler=^(CGFloat progress)
        {
            dispatch_sync(dispatch_get_main_queue(), ^{
                selfObj.sliderView.value=progress;
            });
            
            NSLog(@"%f %@",progress,[NSThread currentThread]);
        };
    }
    return _downloadTool;
}
- (ZYHDownloadTool *)downloadZip
{
    if(_downloadZip==nil)
    {
        _downloadZip=[[ZYHDownloadTool alloc]init];
        NSString *cachesPath=NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
        
        _downloadZip.savePath=_savePath;
        NSString *urlString=[NSString stringWithFormat:@"http://%@/videos.zip",IPAdd];
        _downloadZip.urlString=urlString;
        __weak typeof(self)selfObj=self;
        _downloadZip.completeHandler=^{
            NSLog(@"%s",__func__);
            [selfObj.btn setTitle:@"开始" forState:UIControlStateNormal];
            selfObj.isBegin=NO;
            dispatch_async(dispatch_get_global_queue(0, 0), ^{
                [SSZipArchive unzipFileAtPath:selfObj.savePath toDestination:cachesPath];
                NSLog(@"%@",[NSThread currentThread]);
            });
        };
        _downloadZip.failtureHandler=^{
            NSLog(@"%s",__func__);
        };
        _downloadZip.progressHandler=^(CGFloat progress)
        {
           // NSLog(@"进度%f",progress);
            
            dispatch_sync(dispatch_get_main_queue(), ^{
                selfObj.sliderView.value=progress;
            });
            
            NSLog(@"%f %@",progress,[NSThread currentThread]);
        };
    }
    return _downloadZip;
}
- (ZYHMultiDownload *)multiDown
{
    if(nil==_multiDown)
    {
        _multiDown=[[ZYHMultiDownload alloc]init];
        
        _multiDown.savePath=_savePath;
       
        //NSString *urlString=[NSString stringWithFormat:@"http://%@/videos.zip",IPAdd];
        NSString *urlString=[NSString stringWithFormat:@"http://%@/剩者为王2015.TC720P.国语中英双字.mkv",IPAdd];
        urlString=[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        _multiDown.urlString=urlString;
        __weak typeof(self)selfObj=self;
        _multiDown.completeHandler=^{
            NSLog(@"%s",__func__);
            [selfObj.btn setTitle:@"开始" forState:UIControlStateNormal];
            selfObj.isBegin=NO;
        };
        _multiDown.failtureHandler=^{
            NSLog(@"%s",__func__);
        };
        _multiDown.progressHandler=^(CGFloat progress)
        {
            // NSLog(@"进度%f",progress);
            CGFloat totalScale=0;
            for(ZYHSingleDownload *download in selfObj.multiDown.singleDownloads)
                totalScale+=download.scale;
            
            dispatch_sync(dispatch_get_main_queue(), ^{
                selfObj.sliderView.value=totalScale/ZYHMaxDownloadCount;
            });
            
            NSLog(@"%f %@",selfObj.sliderView.value,[NSThread currentThread]);
        };

    }
    return _multiDown;
}
- (IBAction)StartOrPause:(UIButton*)sender
{
    if(!_isBegin)
    {
        NSFileManager *fileManager=[NSFileManager defaultManager];
        [fileManager createFileAtPath:self.savePath contents:nil attributes:nil];
        _isBegin=YES;
    }
    if([sender.currentTitle isEqualToString:@"开始"])
    {
        [sender setTitle:@"暂停" forState:UIControlStateNormal];
        switch (_action)
        {
            case ZYHDownloadMultiThread:
                [self.multiDown start];
                break;
            case ZYHDownloadVideo:
                [self.downloadTool start];
                break;
            case ZYHDownloadZip:
                [self.downloadZip start];
                break;
            case ZYHDownloadURLSeccion:
            {
                NSString *urlString=[NSString stringWithFormat:@"http://%@/剩者为王2015.TC720P.国语中英双字.mkv",IPAdd];
                urlString=[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                if(self.resumeData==nil)
                    self.downladTask=[self.session downloadTaskWithURL:[NSURL URLWithString:urlString]];
                else
                {
                    self.downladTask=[self.session downloadTaskWithResumeData:self.resumeData];
                }
                [self.downladTask resume];
            }
                break;
        }
    }
    
    else
    {
        [sender setTitle:@"开始" forState:UIControlStateNormal];
        switch (_action)
        {
            case ZYHDownloadMultiThread:
                [self.multiDown pause];
                break;
            case ZYHDownloadVideo:
                [self.downloadTool pause];
                break;
            case ZYHDownloadZip:
                [self.downloadZip pause];
                break;
            case ZYHDownloadURLSeccion:
            {
                [self.downladTask cancelByProducingResumeData:^(NSData * _Nullable resumeData) {
                    NSLog(@"length=%ld",resumeData.length);
                    self.resumeData=resumeData;
                }];
            }
                break;
        }

    }

}
- (IBAction)createZip:(id)sender
{
    NSArray *array=[[NSBundle mainBundle]pathsForResourcesOfType:@"png" inDirectory:nil];
    NSString *cachesPath=[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    NSString *savePath=[cachesPath stringByAppendingPathComponent:@"video.zip"];
    [SSZipArchive createZipFileAtPath:savePath withFilesAtPaths:array];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *cachesPath=NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
    
    switch (_action)
    {
        case ZYHDownloadMultiThread:
           //_savePath=[cachesPath stringByAppendingPathComponent:@"b.zip"];
            _savePath=[cachesPath stringByAppendingPathComponent:@"a.mkv"];
            break;
        case ZYHDownloadVideo:
            _savePath=[cachesPath stringByAppendingPathComponent:@"a.mkv"];
            break;
        case ZYHDownloadZip:
            _savePath=[cachesPath stringByAppendingPathComponent:@"a.zip"];
            break;
        case ZYHDownloadURLSeccion:
             _savePath=[cachesPath stringByAppendingPathComponent:@"a.mkv"];
            break;
    }

    // Do any additional setup after loading the view.
}
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didWriteData:(int64_t)bytesWritten totalBytesWritten:(int64_t)totalBytesWritten totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite
{
    
    CGFloat scale=(float)totalBytesWritten/totalBytesExpectedToWrite;
     NSLog(@"%f %@",scale, [NSThread currentThread]);
    dispatch_sync(dispatch_get_main_queue(), ^{
        _sliderView.value=scale;
    });
}

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didResumeAtOffset:(int64_t)fileOffset expectedTotalBytes:(int64_t)expectedTotalBytes
{
    NSLog(@"%s",__func__);
}
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location
{
     NSLog(@"%s",__func__);
    dispatch_sync(dispatch_get_main_queue(), ^{
        [self.btn setTitle:@"开始" forState:UIControlStateNormal];
    });
    
    self.resumeData=nil;
    NSFileManager *manager=[NSFileManager defaultManager];
     NSString *cachesPath=[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    NSString *destinationPath=[cachesPath stringByAppendingPathComponent:@"a.mkv"];
    [manager removeItemAtPath:destinationPath error:NULL];
    NSError *error;
    [manager copyItemAtPath:location.path toPath:destinationPath error:&error];
    NSLog(@"error=%@",error);
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.session invalidateAndCancel];
    self.session=nil;
}
@end

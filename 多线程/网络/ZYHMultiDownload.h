//
//  ZYHMultiDownload.h
//  多线程
//
//  Created by Apple on 16/2/19.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZYHSingleDownload.h"
#define ZYHMaxDownloadCount 4
@interface ZYHMultiDownload : ZYHDownload
@property(nonatomic,strong) NSMutableArray *singleDownloads;
@property(nonatomic,assign) NSInteger completeCount;
- (void)start;
- (void)pause;

@end

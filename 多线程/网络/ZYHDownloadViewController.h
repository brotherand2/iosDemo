//
//  ZYHDownloadViewController.h
//  多线程
//
//  Created by Apple on 16/2/19.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum
{
    ZYHDownloadVideo,
    ZYHDownloadZip,
    ZYHDownloadMultiThread,
    ZYHDownloadURLSeccion
}ZYHDownloadAction;
@interface ZYHDownloadViewController : UIViewController
@property(nonatomic,assign) ZYHDownloadAction action;
@property(nonatomic,assign) BOOL isBegin;
@end

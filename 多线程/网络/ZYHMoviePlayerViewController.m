//
// 文件名： ZYHMoviePlayerViewController.m
// 项目名： 多线程
// 创建者：Apple
// 日期时间 :16/2/18 20:14
// 版权：  Copyright © 2016年 Apple. All rights reserved.
//

#import "ZYHMoviePlayerViewController.h"
// mp4

// rmvb
// avi
// 软件解码器
/**
 解码
 1> 硬件解码 : 支持MP4
 2> 软件解码 : 解码器, VLC\ffmpeg
 */

@implementation ZYHMoviePlayerViewController
- (void)viewDidLoad
{
    // 移除程序进入后台的通知
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidEnterBackgroundNotification object:nil];
}
/**
 *  UIInterfaceOrientationMaskPortrait : 竖屏(正常)
 *  UIInterfaceOrientationMaskPortraitUpsideDown : 竖屏(上下颠倒)
 *  UIInterfaceOrientationMaskLandscapeLeft : 横屏向左
 *  UIInterfaceOrientationMaskLandscapeRight : 横屏向右
 *  UIInterfaceOrientationMaskLandscape : 横屏(横屏向左\横屏向右)
 *  UIInterfaceOrientationMaskAll : 全部方向(包括上面的所有情况)
 */

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return  UIInterfaceOrientationMaskLandscape;
}
@end

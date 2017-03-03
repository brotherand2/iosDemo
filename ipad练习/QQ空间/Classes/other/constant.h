//
//  constant.h
//  ipad练习
//
//  Created by Apple on 16/3/18.
//  Copyright © 2016年 Apple. All rights reserved.
//
#import <Foundation/Foundation.h>
#ifndef constant_h
#define constant_h
#define QQUserNameKey @"userName"
#define QQPwdKey @"pwd"
#define QQRmbPwdKey @"rmbPwd"
#define QQAutoLoginKey @"autoLogin"
#define SaveDataKey @"saveData"
#define LancadeWidth 1024  //IPAD横屏宽度
#define LandcadeHeight 768  //IPAD横屏高度

#define PortraitDockWidth 70 //IPAD竖屏左边停靠栏宽度
#define LanscadeDockWidth  PortraitDockWidth*3+60//IPAD横屏左边停靠栏宽度

#define DockItemHeight 70//一个菜单的高度
//extern BOOL isLanscade;//是否横屏
#endif /* constant_h */

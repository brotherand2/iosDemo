//
//  ZYHAppView.h
//  helloworld
//
//  Created by Apple on 16/1/7.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
@class  ZYHAppModal;

@interface ZYHAppView : UIView
typedef void (^ClickDownloadBTN)(ZYHAppView*);
+ (instancetype)appView;
+ (instancetype)appViewWithAppModal:(ZYHAppView*)modal;
@property(nonatomic,strong) ZYHAppModal*appModal;
@property(nonatomic,copy) ClickDownloadBTN click;
@end

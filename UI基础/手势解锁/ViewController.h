//
//  ViewController.h
//  手势解锁
//
//  Created by Apple on 16/1/28.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic)UILabel *messageLabel;
@property(nonatomic,copy)NSString *pwd;
@property(nonatomic,assign) ZYHStatePwd pwdState;
@end


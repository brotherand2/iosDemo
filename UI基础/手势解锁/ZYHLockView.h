//
//  ZYHLockView.h
//  helloworld
//
//  Created by Apple on 16/1/28.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef  void(^ZYHLockBlock)(NSString*message,BOOL correct);
typedef void(^ZYHFinishBlock)(NSString *pwd,ZYHStatePwd pwdState) ;
@interface ZYHLockView : UIView
@property(nonatomic,copy)NSString *pwd;

@property(nonatomic,assign) ZYHStatePwd pwdState;
@property(nonatomic,copy) ZYHLockBlock showMessage;
@property(nonatomic,copy) ZYHFinishBlock finish;
@end

//
//  ViewController.h
//  多线程
//
//  Created by Apple on 16/2/9.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum
{
    ZYHLoginGetWithDelegate,
    ZYHLoginGet,
    ZYHLoginPost
}ZYHLoginType;
@interface ViewController : UIViewController
@property(nonatomic,assign) ZYHLoginType loginType;

@end


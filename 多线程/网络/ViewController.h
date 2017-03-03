//
//  ViewController.h
//  网络
//
//  Created by Apple on 16/2/13.
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



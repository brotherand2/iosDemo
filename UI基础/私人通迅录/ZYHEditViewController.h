//
//  ZYHEditViewController.h
//  helloworld
//
//  Created by Apple on 16/1/20.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZYHContactModal.h"
@interface ZYHEditViewController : UIViewController
typedef void (^EditContactBlock) (ZYHContactModal *modal);
@property(nonatomic,copy) EditContactBlock editContact;
@property(nonatomic,strong) ZYHContactModal *modal;
@end

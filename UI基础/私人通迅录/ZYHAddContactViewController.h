//
//  ZYHAddContactViewController.h
//  helloworld
//
//  Created by Apple on 16/1/20.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZYHContactModal;
@interface ZYHAddContactViewController : UIViewController

typedef void (^AddContactBlock) (ZYHContactModal *modal);
@property(nonatomic,copy) AddContactBlock addContact;
@end

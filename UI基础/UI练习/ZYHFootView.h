//
//  ZYHFootView.h
//  helloworld
//
//  Created by Apple on 16/2/2.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GirlModal.h"
#import "ZYHButton.h"
typedef  void(^BtnClickBlock)();
@interface ZYHFootView : UITableViewHeaderFooterView
@property(nonatomic,weak)ZYHButton *nameView;
+ (instancetype)headViewWithTableView:(UITableView*)tableview;
@property(nonatomic,strong) GirlModal *modal;
@property(nonatomic,copy) BtnClickBlock btnClick;
@end

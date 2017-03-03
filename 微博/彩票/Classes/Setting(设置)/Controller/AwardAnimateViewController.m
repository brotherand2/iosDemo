//
//  AwardAnimateViewController.m
//  微博
//
//  Created by Apple on 16/2/5.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "AwardAnimateViewController.h"
#import "ZYHItemGroup.h"
#import "ZYHSettingItem.h"
@interface AwardAnimateViewController ()

@end

@implementation AwardAnimateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    ZYHSettingItem *item1=[ZYHSettingItem settingItemWithTitle:@"中奖动画"];
    item1.itemType=ZYHItemSwitch;
    ZYHItemGroup *group=[[ZYHItemGroup alloc]init];
    group.items=@[item1];
    group.headTitle=@"当您有新中奖订单，启动程序时通过动画提醒您。为避免过于频繁，高频彩不会提醒。";
    [self.data addObject:group];

}


@end

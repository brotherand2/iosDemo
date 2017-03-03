//
//  BuyTimedNoticeViewController.m
//  微博
//
//  Created by Apple on 16/2/5.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "BuyTimedNoticeViewController.h"
#import "ZYHItemGroup.h"
#import "ZYHSettingItem.h"
@interface BuyTimedNoticeViewController ()

@end

@implementation BuyTimedNoticeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    ZYHSettingItem *item1=[ZYHSettingItem settingItemWithTitle:@"打开提醒"];
    item1.itemType=ZYHItemSwitch;
    ZYHItemGroup *group=[[ZYHItemGroup alloc]init];
    group.items=@[item1];
    group.headTitle=@"您可以通过设置，提醒自己在开奖日不要忘了购买彩票";
    [self.data addObject:group];
}
@end

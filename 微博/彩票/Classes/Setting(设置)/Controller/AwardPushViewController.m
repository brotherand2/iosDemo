//
//  AwardPushViewController.m
//  微博
//
//  Created by Apple on 16/2/5.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "AwardPushViewController.h"
#import "ZYHItemGroup.h"
#import "ZYHSettingItem.h"
@interface AwardPushViewController ()

@end

@implementation AwardPushViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    ZYHSettingItem *item1=[ZYHSettingItem settingItemWithTitle:@"双色球"];
    item1.itemType=ZYHItemSwitch;
    ZYHSettingItem *item2=[ZYHSettingItem settingItemWithTitle:@"大乐透球"];
    item2.itemType=ZYHItemSwitch;
    ZYHItemGroup *group=[[ZYHItemGroup alloc]init];
    group.items=@[item1,item2];
    group.headTitle=@"打开设置即可在开奖后立即收到推送消息，获知开奖号码";
    [self.data addObject:group];
    // Do any additional setup after loading the view.
}

@end

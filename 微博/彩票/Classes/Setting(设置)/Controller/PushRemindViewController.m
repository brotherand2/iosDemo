//
//  PushRemindViewController.m
//  微博
//
//  Created by Apple on 16/2/5.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "PushRemindViewController.h"
#import "ZYHItemGroup.h"
#import "ZYHSettingItem.h"
#import "AwardAnimateViewController.h"
#import "AwardPushViewController.h"
#import "BuyTimedNoticeViewController.h"
#import "ScoreNoticeViewController.h"
@interface PushRemindViewController ()

@end

@implementation PushRemindViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    ZYHSettingItem *awardPush=[ZYHSettingItem settingItemWithTitle:@"开奖号码推送" icon:nil vcCalss:[AwardPushViewController class]];
    ZYHSettingItem *awardAnimate=[ZYHSettingItem settingItemWithTitle:@"中奖动画" icon:nil vcCalss:[AwardAnimateViewController class]];
    ZYHSettingItem *scoreNotice=[ZYHSettingItem settingItemWithTitle:@"比分直播提醒" icon:nil vcCalss:[ScoreNoticeViewController class]];
    ZYHSettingItem *buyTimedNotice=[ZYHSettingItem settingItemWithTitle:@"购彩定时提醒" icon:nil vcCalss:[BuyTimedNoticeViewController class]];
    ZYHItemGroup *group=[[ZYHItemGroup alloc]init];
    group.items=@[awardPush,awardAnimate,scoreNotice,buyTimedNotice];
    [self.data addObject:group];
}

@end

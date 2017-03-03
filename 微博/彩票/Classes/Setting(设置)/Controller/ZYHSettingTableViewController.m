//
//  ZYHSettingTableViewController.m
//  微博
//
//  Created by Apple on 16/2/4.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "ZYHSettingTableViewController.h"
#import "ZYHSettingItem.h"
#import "ZYHItemGroup.h"
#import "ZYHShareViewController.h"
#import "PushRemindViewController.h"
#import "ZYHAboutViewController.h"
#import "ZYHHelpViewController.h"
#import "ZYHProductCollectionViewController.h"
#import "MBProgressHUD+MJ.h"
@interface ZYHSettingTableViewController ()

@end

@implementation ZYHSettingTableViewController
- (void)addGroupOne
{
    ZYHSettingItem *push=[ZYHSettingItem settingItemWithTitle:@"推送和提醒" icon:@"MorePush" vcCalss:[PushRemindViewController class]];
    ZYHSettingItem *shake=[ZYHSettingItem settingItemWithTitle:@"摇一摇机选" icon:@"handShake" vcCalss:nil];
    shake.itemType=ZYHItemSwitch;
    ZYHSettingItem *sound=[ZYHSettingItem settingItemWithTitle:@"声音和效果" icon:@"MoreShare" vcCalss:nil];
    sound.itemType=ZYHItemSwitch;
    ZYHItemGroup *group=[[ZYHItemGroup alloc]init];
    group.items=@[push,shake,sound];
    [self.data addObject:group];
}
- (void)addGroupTwo
{
    ZYHSettingItem *version=[ZYHSettingItem settingItemWithTitle:@"检查版本与更新" icon:@"MoreUpdate" vcCalss:nil];
    version.operation=^{
        [MBProgressHUD showMessage:@"正在检查更新"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUD];
            [MBProgressHUD showSuccess:@"已是最新版本"];
        });
    };
    ZYHSettingItem *help=[ZYHSettingItem settingItemWithTitle:@"帮助" icon:@"MoreHelp" vcCalss:[ZYHHelpViewController class]];
    ZYHSettingItem *share=[ZYHSettingItem settingItemWithTitle:@"分享" icon:@"MoreShare" vcCalss:[ZYHShareViewController class]];
    ZYHSettingItem *viewMessage=[ZYHSettingItem settingItemWithTitle:@"查看消息" icon:@"MoreMessage" vcCalss:nil];
    ZYHSettingItem *product=[ZYHSettingItem settingItemWithTitle:@"产品推荐" icon:@"MoreNetease" vcCalss:[ZYHProductCollectionViewController class]];
    ZYHSettingItem *about=[ZYHSettingItem settingItemWithTitle:@"关于" icon:@"MoreAbout" vcCalss:[ZYHAboutViewController class]];
    ZYHItemGroup *group=[[ZYHItemGroup alloc]init];
    group.items=@[version,help,share,viewMessage,product,about];
    [self.data addObject:group];

}
- (void)viewDidLoad
{
    self.title=@"设置";
    [super viewDidLoad];
    [self addGroupOne];
    [self addGroupTwo];
}

@end

//
// 文件名： ZYHMoodViewController.m
// 项目名： ipad练习
// 创建者：Apple
// 日期时间 :16/3/18 16:03
// 版权：  Copyright © 2016年 Apple. All rights reserved.
//

#import "ZYHMoodViewController.h"

@implementation ZYHMoodViewController

- (void)viewDidLoad
{
    self.title=@"发表心情";
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"关闭" style:UIBarButtonItemStyleDone target:self action:@selector(exit)];
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"发表" style:UIBarButtonItemStyleDone target:self action:nil];
}

- (void)exit
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end

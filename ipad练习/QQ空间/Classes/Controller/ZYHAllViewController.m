//
// 文件名： ZYHAllViewController.m
// 项目名： ipad练习
// 创建者：Apple
// 日期时间 :16/3/18 16:02
// 版权：  Copyright © 2016年 Apple. All rights reserved.
//

#import "ZYHAllViewController.h"
#import "UIColor+extention.h"
@implementation ZYHAllViewController

- (void)viewDidLoad
{
    NSArray *items=@[@"全部",@"特别关心",@"好友动态",@"认证空间"];
    UISegmentedControl *segControl=[[UISegmentedControl alloc]initWithItems:items];
    [segControl addTarget:self action:@selector(segmentValueChange:) forControlEvents:UIControlEventValueChanged];
    segControl.selectedSegmentIndex=0;
    segControl.tintColor=[UIColor lightGrayColor];
    NSDictionary *attributes=@{NSForegroundColorAttributeName:[UIColor blackColor]};
    [segControl setTitleTextAttributes:attributes forState:UIControlStateNormal];
    self.navigationItem.titleView=segControl;
}
- (void)segmentValueChange:(UISegmentedControl*)seg
{
    self.view.backgroundColor=[UIColor randomColorWithAlpha];
}
@end

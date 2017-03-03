//
//  ZYHMyLotteryViewController.m
//  微博
//
//  Created by Apple on 16/2/4.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "ZYHMyLotteryViewController.h"
#import "ZYHSettingTableViewController.h"
#import "UIImage+Extention.h"
@interface ZYHMyLotteryViewController ()
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;

@end

@implementation ZYHMyLotteryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [_loginBtn setBackgroundImage:[UIImage resizableWithName:@"RedButton"] forState:UIControlStateNormal];
    [_loginBtn setBackgroundImage:[UIImage resizableWithName:@"RedButtonPressed"] forState:UIControlStateHighlighted];
    // Do any additional setup after loading the view.
}

- (IBAction)setting:(id)sender
{
    ZYHSettingTableViewController *VC=[[ZYHSettingTableViewController alloc]init];
    [self.navigationController pushViewController:VC animated:YES];
}
@end

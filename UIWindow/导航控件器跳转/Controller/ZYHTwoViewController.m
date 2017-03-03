//
//  ZYHTwoViewController.m
//  UIWindow
//
//  Created by Apple on 16/1/16.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "ZYHTwoViewController.h"
#import "ZYHThreeViewController.h"
@interface ZYHTwoViewController ()

@end

@implementation ZYHTwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title=@"第2个导航控制器";
    UIBarButtonItem *refresh=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:nil action:nil];
    UIBarButtonItem *search=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:nil action:nil];
    self.navigationItem.rightBarButtonItems=@[search,refresh];
    UIBarButtonItem *back=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemReply target:self action:@selector(previous:)];
    self.navigationItem.leftBarButtonItem=back;
}

-(IBAction)previous:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)jumpThree:(id)sender
{
    ZYHThreeViewController *three=[[ZYHThreeViewController alloc]init];
    [self.navigationController pushViewController:three animated:YES];
}
@end

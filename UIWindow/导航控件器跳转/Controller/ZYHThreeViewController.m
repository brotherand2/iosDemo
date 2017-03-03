//
//  ZYHThreeViewController.m
//  UIWindow
//
//  Created by Apple on 16/1/16.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "ZYHThreeViewController.h"

@interface ZYHThreeViewController ()

@end

@implementation ZYHThreeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title=@"第3个导航控制器";
    UIButton *btn=[[UIButton alloc]init];
    btn.bounds=CGRectMake(0, 0, 43, 25);
    [btn setBackgroundImage:[UIImage imageNamed:@"btn_back_normal"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:btn];
    UIButton *centView=[UIButton buttonWithType:UIButtonTypeContactAdd];
    self.navigationItem.titleView=centView;
}

- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)returnFirst:(id)sender
{
    //[self.navigationController popToRootViewControllerAnimated:YES];
    UIViewController *oneVc=self.navigationController.viewControllers[0];
    [self.navigationController popToViewController:oneVc animated:YES];
}
@end

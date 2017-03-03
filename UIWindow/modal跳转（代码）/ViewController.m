//
//  ViewController.m
//  modal跳转（代码）
//
//  Created by Apple on 16/1/24.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    btn.center=self.view.center;
    btn.bounds=CGRectMake(0, 0, 100, 44);
    [btn setTitle:@"跳转" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}
- (void)btnClick
{
    UINavigationController *naVC=[[UINavigationController alloc]init];
    UIViewController *vc=[[UIViewController alloc]init];
    [vc.view setBackgroundColor:[UIColor purpleColor]];
    naVC.viewControllers=@[vc];
    UIBarButtonItem *back=[[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(back)];
    vc.navigationItem.leftBarButtonItem=back;
    [self presentViewController:naVC animated:YES completion:nil];
}
- (void)back {
    [self dismissViewControllerAnimated:YES completion:nil];
    // Dispose of any resources that can be recreated.
}

@end

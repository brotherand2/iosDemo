//
//  ZYHOneViewController.m
//  UIWindow
//
//  Created by Apple on 16/1/16.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "ZYHOneViewController.h"
#import "ZYHTwoViewController.h"
@interface ZYHOneViewController ()

@end

@implementation ZYHOneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    UIBarButtonItem *leftItem=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCamera target:nil action:nil];
    self.navigationItem.title=@"第1个控制器";
    UIBarButtonItem *back=[[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem=back;
    self.navigationItem.leftBarButtonItem=leftItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)jumpTwo :(id)sender
{
    ZYHTwoViewController *two=[[ZYHTwoViewController alloc]init];
    [self.navigationController pushViewController:two animated:YES];
}
@end

//
//  ZYHThreeViewController.m
//  UIWindow
//
//  Created by Apple on 16/1/17.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "ZYHThreeViewController.h"

@interface ZYHThreeViewController ()

@end

@implementation ZYHThreeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)back:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
@end

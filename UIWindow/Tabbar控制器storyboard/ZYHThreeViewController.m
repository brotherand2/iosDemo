//
//  ZYHThreeViewController.m
//  UIWindow
//
//  Created by Apple on 16/1/23.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "ZYHThreeViewController.h"

@interface ZYHThreeViewController ()

@end

@implementation ZYHThreeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UITabBar *tabBar=self.tabBarController.tabBar;
    for(UIView *view in tabBar.subviews)
    {
        if (![view isKindOfClass:[UIImageView class]]) {
            [view removeFromSuperview];
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

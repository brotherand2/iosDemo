//
//  ZYHSecondViewController.m
//  ipad练习
//
//  Created by Apple on 16/3/16.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "ZYHSecondViewController.h"
#import "UIColor+extention.h"
@interface ZYHSecondViewController ()

@end

@implementation ZYHSecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor randomColorWithAlpha];
    // Do any additional setup after loading the view.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self dismissViewControllerAnimated:YES completion:nil];
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

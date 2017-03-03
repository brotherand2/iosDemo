//
//  ZYHBuyTogetherViewController.m
//  微博
//
//  Created by Apple on 16/2/4.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "ZYHBuyTogetherViewController.h"

@interface ZYHBuyTogetherViewController ()

@end

@implementation ZYHBuyTogetherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)btnClick:(UIButton*)sender
{
    [UIView animateWithDuration:0.25 animations:^{
        if (CGAffineTransformIsIdentity(sender.imageView.transform))
        {
        sender.imageView.transform=CGAffineTransformRotate(sender.imageView.transform, M_PI);
        }
        else
         sender.imageView.transform=CGAffineTransformIdentity;

    }];
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

//
//  ViewController.m
//  modal跳转（storyboard）
//
//  Created by Apple on 16/1/24.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "ViewController.h"
#import "ZYHViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    UINavigationController *naVc=segue.destinationViewController;
    ZYHViewController *vc=naVc.topViewController;
    [vc.view setBackgroundColor:[UIColor greenColor]];
}
@end

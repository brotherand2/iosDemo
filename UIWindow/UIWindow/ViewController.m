//
//  ViewController.m
//  UIWindow
//
//  Created by Apple on 16/1/16.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UIApplication *app= [UIApplication sharedApplication];
    //[app openURL:[NSURL URLWithString:@"http://www.baidu.com"] ];
    //[app openURL:[NSURL URLWithString:@"tel://10086"]];
    //[app openURL:[NSURL URLWithString:@"sms://10086"]];
    //[app openURL:[NSURL URLWithString:@"mailto://12345@qq.com"]];

}
- (IBAction)progressValueChange:(id)sender {
}
@end

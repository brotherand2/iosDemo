//
//  ViewController.m
//  通过代码创建按钮
//
//  Created by Apple on 15/11/24.
//  Copyright © 2015年 Apple. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

- (IBAction)nextPhoto:(UIButton *)sender;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake(100, 100, 300, 400)];
    [button setTitle:@"别摸我" forState:UIControlStateNormal];
    [button setTitle:@"就摸你" forState:UIControlStateHighlighted];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor greenColor] forState:UIControlStateHighlighted];
    UIImage *imageForeground=[UIImage imageNamed:@"218433.png" ];
    UIImage *imageBackground=[UIImage imageNamed:@"473084.png" ];
    [button setBackgroundImage:imageBackground forState:UIControlStateHighlighted];
    [button setBackgroundImage:imageForeground forState:UIControlStateNormal];
    [button addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    UIButton *addBtn=[UIButton buttonWithType:UIButtonTypeContactAdd];//系统添加样式的按钮
    [addBtn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    [self.view addSubview:addBtn];
}
- (void)click:(UIButton*)btn
{
    
    NSLog(@"YOU Click Me");
}
- (BOOL)prefersStatusBarHidden
{
    return YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)photo:(id)sender {
}
- (IBAction)erase:(id)sender {
}

- (IBAction)nextPhoto:(UIButton *)sender {
}
@end

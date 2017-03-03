//
//  ViewController.m
//  画饼图
//
//  Created by Apple on 16/1/26.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "ViewController.h"
#import "ZYHPieView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    ZYHPieView *pieView=[[ZYHPieView alloc]initWithFrame:CGRectMake(100, 100, 200, 200)];
    pieView.sections= @[@20,@30,@40,@10,@40];
    pieView.backgroundColor=[UIColor grayColor];
    pieView.sectionColor=@[[UIColor redColor],[UIColor yellowColor],[UIColor greenColor],[UIColor blueColor],[UIColor purpleColor]];
    [self.view addSubview:pieView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

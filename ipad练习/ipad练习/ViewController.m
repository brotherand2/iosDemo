//
//  ViewController.m
//  ipad练习
//
//  Created by Apple on 16/3/16.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "ViewController.h"
#import "ZYHMenuViewController.h"
@interface ViewController ()
- (IBAction)clickMenu:(id)sender;
- (IBAction)redBtnClick:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)clickMenu:(id)sender
{
    ZYHMenuViewController *menuVC=[[ZYHMenuViewController alloc]init];
    UIPopoverController *popVC=[[UIPopoverController alloc]initWithContentViewController:[[UINavigationController alloc] initWithRootViewController:menuVC]];
    
    [popVC presentPopoverFromBarButtonItem:sender permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    //popVC.popoverContentSize=CGSizeMake(320, 44*menuVC.menusNames.count);
}

- (IBAction)redBtnClick:(id)sender {
}
@end

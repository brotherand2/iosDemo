//
//  ViewController.m
//  autolayout动画
//
//  Created by Apple on 15/12/19.
//  Copyright © 2015年 Apple. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *blueViewVerticalLc;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *blueViewVertcalTc;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [UIView beginAnimations:nil context:nil];
    [UIView  setAnimationDuration:2.0];
    
    self.blueViewVertcalTc.constant+=20;
    //[UIView commitAnimations];
    //[self.view layoutIfNeeded];
}
@end

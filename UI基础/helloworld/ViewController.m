//
//  ViewController.m
//  helloworld
//
//  Created by Apple on 15/11/23.
//  Copyright © 2015年 Apple. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *userName;
- (IBAction)drink;
@property (weak, nonatomic) IBOutlet UILabel *tip;

- (IBAction)login:(id)sender;
@end

@implementation ViewController

- (IBAction)login:(id)sender
{
    
    NSString *text=[NSString stringWithFormat:@"你好 %@",self.userName.text ];
    NSLog(@"userName=%@",self.userName.text);
    self.tip.text =text;
    [self.view endEditing:YES];
}
- (IBAction)previous:(UIButton *)sender {
}

- (IBAction)drink {
}
@end

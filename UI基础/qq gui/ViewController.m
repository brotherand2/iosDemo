//
//  ViewController.m
//  qq gui
//
//  Created by Apple on 15/11/24.
//  Copyright © 2015年 Apple. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITextFieldDelegate>
- (IBAction)login:(id)sender;

@property (weak, nonatomic) IBOutlet UITextField *qq;
@property (weak, nonatomic) IBOutlet UITextField *pwd;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.qq becomeFirstResponder];//用户名编辑控件获得焦点
    // Do any additional setup after loading the view, typically from a nib.
}
- (void)login:(id)sender
{
    NSLog(@"LOGIN qq:%@,pwd:%@ ",self.qq.text,self.pwd.text);
    //[self.view endEditing:YES];
}
//在文本框中按回车键
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if(textField==self.qq)
        [self.pwd becomeFirstResponder];//让密码框获得焦点
    else
    {
        [self login:nil];
        [self.pwd resignFirstResponder];//注销第一响应者，失去焦点
    }
    return YES;
}
@end

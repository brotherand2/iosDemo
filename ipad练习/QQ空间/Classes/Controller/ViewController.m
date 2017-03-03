//
//  ViewController.m
//  QQ空间
//
//  Created by Apple on 16/3/18.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "ViewController.h"
#import "constant.h"
#import "ZYHMainViewController.h"
@interface ViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *userNameField;
@property (weak, nonatomic) IBOutlet UITextField *pwdField;
@property (weak, nonatomic) IBOutlet UIButton *rmbPwdBtn;
@property (weak, nonatomic) IBOutlet UIButton *autoLoginBtn;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property(nonatomic,strong) NSUserDefaults *userDefaults;
@property(nonatomic,assign) BOOL hasSaveData;
@property (weak, nonatomic) IBOutlet UIView *contentView;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    _userDefaults=[NSUserDefaults standardUserDefaults];
    _hasSaveData=[_userDefaults boolForKey:SaveDataKey];
    if(_hasSaveData)
    {
        self.autoLoginBtn.selected=[_userDefaults boolForKey:QQAutoLoginKey];
        self.rmbPwdBtn.selected=[_userDefaults boolForKey:QQRmbPwdKey];
        if(self.rmbPwdBtn.selected)
        {
            self.userNameField.text=[_userDefaults objectForKey:QQUserNameKey];
            self.pwdField.text=[_userDefaults objectForKey:QQPwdKey];
        }
        if(self.autoLoginBtn.selected&&_userNameField.text&&_pwdField.text)
            [self loginBtnClick:nil];
    }
    else
    {
        [_userDefaults setBool:YES forKey:SaveDataKey];
        [_userDefaults setBool:self.rmbPwdBtn.selected forKey:QQRmbPwdKey];
        [_userDefaults setBool:self.autoLoginBtn.selected forKey:QQAutoLoginKey];
    }
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)rmbPwdBtnClick:(UIButton*)sender
{
    sender.selected=!sender.selected;
    if(sender.selected==NO)
        self.autoLoginBtn.selected=NO;
    [_userDefaults setBool:self.rmbPwdBtn.selected forKey:QQRmbPwdKey];
}
- (IBAction)autoLoginBtnClick:(UIButton*)sender
{
    sender.selected=!sender.selected;
    if(sender.selected==YES)
        self.rmbPwdBtn.selected=YES;
    [_userDefaults setBool:self.autoLoginBtn.selected forKey:QQAutoLoginKey];
}
- (IBAction)loginBtnClick:(UIButton*)sender
{
    NSLog(@"%@ ---%@",_userNameField.text,_pwdField.text);
    if(!_userNameField.text.length)
    {
        [self showLoginFail:@"请输入账号"];
        return;
    }
    if(!_pwdField.text.length)
    {
        [self showLoginFail:@"请输入密码"];
        return;
    }
    if(![_userNameField.text isEqualToString:@"123"]||![_pwdField.text isEqualToString:@"123"])
        [self showLoginFail:@"用户名或密码不存在"];
    else
    {
        [self.activityIndicator startAnimating];
        [_userDefaults setObject:self.userNameField.text forKey:QQUserNameKey];
        [_userDefaults setObject:self.pwdField.text forKey:QQPwdKey];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.7 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.activityIndicator stopAnimating];
            ZYHMainViewController *mainVC=[[ZYHMainViewController alloc]init];
            mainVC.view.backgroundColor=self.view.backgroundColor;
            [self presentViewController:mainVC animated:YES completion:nil];
        });
    }
}
- (void)showLoginFail:(NSString*)str
{
    UIAlertController *alertVC=[UIAlertController alertControllerWithTitle:@"登录失败" message:str preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
    [alertVC addAction:action];
    
    [self presentViewController:alertVC animated:YES completion:nil];
    CAKeyframeAnimation *animation=[CAKeyframeAnimation animationWithKeyPath:@"transform.translation.x"];
    animation.values=@[@-10,@0,@10,@0];
    animation.repeatCount=3;
    animation.duration=0.1;
    [self.contentView.layer addAnimation:animation forKey:nil];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if(textField==_userNameField)
        [_pwdField becomeFirstResponder];
    else
        [self loginBtnClick:nil];
    return YES;
}
@end

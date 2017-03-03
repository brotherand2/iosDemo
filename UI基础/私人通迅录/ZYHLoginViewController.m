//
//  ZYHLoginViewController.m
//  helloworld
//
//  Created by Apple on 16/1/20.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "ZYHLoginViewController.h"
#import "MBProgressHUD+MJ.h"
#import "ZYHContactTableViewController.h"
@interface ZYHLoginViewController ()
{
    @public
    NSUserDefaults *defaults;
}
@property (weak, nonatomic) IBOutlet UITextField *userNameField;
@property (weak, nonatomic) IBOutlet UITextField *pwdField;
@property (weak, nonatomic) IBOutlet UISwitch *rmbPwdS;
@property (weak, nonatomic) IBOutlet UISwitch *autoLoginS;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;

@end
//static BOOL firstLoad=YES;
@implementation ZYHLoginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.userNameField addTarget:self action:@selector(textChange) forControlEvents:UIControlEventEditingChanged];
    [self.pwdField addTarget:self action:@selector(textChange) forControlEvents:UIControlEventEditingChanged];
    defaults=[NSUserDefaults standardUserDefaults];
    //NSLog(@"%@",[defaults boolForKey:@"rmbPwd"]);
    [self.rmbPwdS setOn:[defaults boolForKey:@"rmbPwd"]];
    
    [self.autoLoginS setOn:[defaults boolForKey:@"autoLogin"]];
    _userNameField.text=[defaults objectForKey:@"userName"];
    if (self.rmbPwdS.isOn) {
        _pwdField.text=[defaults objectForKey:@"pws"];
    }
    [self textChange];
     if (self.autoLoginS.isOn&&self.userNameField.text.length&&self.pwdField.text.length) {
         dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
             [self login:nil];
         });
        
    }
   }
//- (void)viewDidAppear:(BOOL)animated
//{
//       firstLoad=NO;
//}
- (IBAction)login:(id)sender
{
    BOOL isCorrectUser=[_userNameField.text isEqualToString:@"zyh"];
    BOOL isCorrectPwd=[_pwdField.text isEqualToString:@"123"];
    if (isCorrectPwd&&isCorrectUser) {
        [MBProgressHUD showMessage:@"正在登录中..." ];
        //[MBProgressHUD showMessage:@"正在登录中..." toView:self.view];
        //[MBProgressHUD hideHUD];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUD];
            [defaults setObject:self.pwdField.text forKey:@"pws"];
            [defaults setObject:self.userNameField.text forKey:@"userName"];
            [defaults synchronize];
            
            [self performSegueWithIdentifier:@"logincontact" sender:nil];
            [self.view endEditing:YES];
        });
    }
    else
        [MBProgressHUD showError:@"账号或密码错误"];
}

- (IBAction)rememberPwdSwitch:(UISwitch*)sender
{
    if (!sender.isOn) {
        [self.autoLoginS setOn:NO];
        [defaults setBool:NO forKey:@"autoLogin"];
    }
    [defaults setBool:sender.isOn forKey:@"rmbPwd"];
}
- (IBAction)autoLoginSwitch:(UISwitch*)sender
{
    if (sender.isOn) {
        [self.rmbPwdS setOn:YES];
         [defaults setBool:YES forKey:@"rmbPwd"];
    }
    [defaults setBool:sender.isOn forKey:@"autoLogin"];
}
- (void)textChange
{
    self.loginBtn.enabled=self.userNameField.text.length&&self.pwdField.text.length;
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    ZYHContactTableViewController *destinVC=segue.destinationViewController;
    destinVC.navigationItem.title=[NSString stringWithFormat:@"%@的联系人",self.userNameField.text];
}
@end

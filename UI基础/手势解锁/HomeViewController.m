//
//  HomeViewController.m
//  helloworld
//
//  Created by Apple on 16/1/29.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "HomeViewController.h"
#import "ViewController.h"

@interface HomeViewController ()
@property (weak, nonatomic) IBOutlet UIButton *clearPwdBtn;//清除密码按钮
@property (weak, nonatomic) IBOutlet UIButton *setPwnBtn;//设置密码按钮

@property(nonatomic,strong) NSString *pwd;//密码

@property(nonatomic,assign) ZYHStatePwd pwdState;//密码状态
@end

@implementation HomeViewController
- (void)viewWillAppear:(BOOL)animated
{
   NSUserDefaults *userDefault=[NSUserDefaults standardUserDefaults];
   _pwd=[userDefault objectForKey:@"gesturePwd"];//读取密码
    _clearPwdBtn.enabled=_pwd;
    _pwdState=_pwd?ZYHStateModifyPwd:ZYHStateSetPwd;
    [_setPwnBtn setTitle:_pwd?@"修改手势密码":@"设置手势密码" forState:UIControlStateNormal];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
     
}
- (IBAction)clear:(id)sender
{
     NSUserDefaults *userDefault=[NSUserDefaults standardUserDefaults];
    [userDefault removeObjectForKey:@"gesturePwd"];
    [_setPwnBtn setTitle:@"设置手势密码" forState:UIControlStateNormal];
    [userDefault synchronize];
    _clearPwdBtn.enabled=NO;
    _pwd=nil;
    _pwdState=ZYHStateSetPwd;
    NSLog(@"clear");
}

- (IBAction)clearPwd:(id)sender
{
    _pwdState=ZYHStateClearPwd;
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    ViewController *Vc=segue.destinationViewController;
    Vc.pwdState=_pwdState;
    Vc.pwd=_pwd;
}
@end

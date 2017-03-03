//
//  ViewController.m
//  手势解锁
//
//  Created by Apple on 16/1/28.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "ViewController.h"
#import "ZYHLockView.h"
#import "MBProgressHUD+MJ.h"
@interface ViewController ()
@property (weak, nonatomic)ZYHLockView *lockView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"Home_refresh_bg"]];
    CGFloat screenW=[UIScreen mainScreen].bounds.size.width;
    
    //创建锁屏界面
    ZYHLockView *lockView=[[ZYHLockView alloc] initWithFrame:CGRectMake(0, 0, screenW, screenW)];
    _lockView=lockView;
    lockView.pwd=_pwd;
    lockView.pwdState=_pwdState;
    lockView.center=self.view.center;
    lockView.backgroundColor=[UIColor clearColor];
    
    //添加消息图标
    CGFloat labelH=20;
    CGFloat labelW=screenW;
    CGFloat labelX=0;
    CGFloat labelY=CGRectGetMinY(lockView.frame)-labelH;
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(labelX, labelY, labelW, labelH)];
    _messageLabel=label;
    label.textAlignment=NSTextAlignmentCenter;
    label.backgroundColor=[UIColor clearColor];
    lockView.showMessage=^(NSString *text,BOOL correct)
    {
        label.textColor=correct?[UIColor whiteColor]:[UIColor redColor];
        label.text=text;
    };
    if (_pwd)//密码不为空
       lockView.showMessage(@"请输入原手势密码",YES);
    else
        lockView.showMessage(@"绘制解锁图案",YES);

     __weak __typeof(self) vc=self;
    lockView.finish=^(NSString *pwd,ZYHStatePwd pwdState)
    {
        [vc finish:pwd passwordState:pwdState];
    };
    [self.view addSubview:label];
    [self.view addSubview:lockView];
}
- (void)finish:(NSString*)password passwordState:(ZYHStatePwd)pwdState
{
    NSUserDefaults *userDefault=[NSUserDefaults standardUserDefaults];
   
    [UIView animateWithDuration:1.5 animations:^
    {
        switch (pwdState)
        {
            case ZYHStateSetPwd:
                [userDefault setObject:password forKey:@"gesturePwd"];
                [MBProgressHUD showSuccess:@"手势密码设置完成"];
                break;
            case ZYHStateClearPwd:
                 [userDefault removeObjectForKey:@"gesturePwd"];
                 [MBProgressHUD showSuccess:@"手势密码已清除"];
                 _lockView.pwd=nil;
                break;
            case ZYHStateModifyPwd:
                _lockView.pwd=nil;
                _lockView.showMessage(@"绘制解锁图案",YES);
                [userDefault removeObjectForKey:@"gesturePwd"];
                [MBProgressHUD showSuccess:@"旧手势密码已清除，重新输入密码"];
               
                break;
            case ZYHStateError:
                [MBProgressHUD showSuccess:@"5次修改机会已用完"];
                break;
            default:
                break;
        }
    } completion:^(BOOL finished)
     {
         if(_lockView.pwdState==ZYHStateModifyPwd)
              _lockView.pwdState=ZYHStateSetPwd;
         else
           [self.navigationController popViewControllerAnimated:YES];
    }];
  
}


@end

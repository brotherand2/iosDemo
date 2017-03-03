//
//  ViewController.m
//  网络
//
//  Created by Apple on 16/2/13.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "ViewController.h"
#import "MBProgressHUD+MJ.h"
#import "NSString+Hash.h"
#import "SSKeychain.h"
#define ZYHUserNameKey @"username"
#define ZYHPwdKey @"pwd"
#define ZYHPwdServiceName @"pwdService"
@interface ViewController ()<NSURLConnectionDataDelegate>
@property (weak, nonatomic) IBOutlet UITextField *userNameView;
@property (weak, nonatomic) IBOutlet UITextField *pwdView;
@property(nonatomic,strong) NSMutableData *data;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _userNameView.text=[[NSUserDefaults standardUserDefaults]objectForKey:ZYHUserNameKey];
    NSLog(@"%@",[SSKeychain allAccounts]);
    NSString *pwd=[SSKeychain passwordForService:ZYHPwdServiceName account:self.userNameView.text];
    self.pwdView.text=pwd;
}

- (IBAction)login:(id)sender
{
   if(!_userNameView.text.length)
   {
       [MBProgressHUD showError:@"用户名为空"];
       return;
   }
    if(!_pwdView.text.length)
    {
        [MBProgressHUD showError:@"密码为空"];
        return;
    }
    [MBProgressHUD showMessage:@"正在登录中..."];
    [NSThread sleepForTimeInterval:0.7];
    NSString *urlPath=[NSString stringWithFormat:@"http://%@:8080/MJServer/login?username=%@&pwd=%@",IPAdd, _userNameView.text,_pwdView.text];
    NSURL *url=[NSURL URLWithString:urlPath];
    switch (self.loginType)
    {
        case ZYHLoginGet:
            [self sendAsync:url];
            break;
        case ZYHLoginGetWithDelegate:
        {
            [self sendAysncUseDelegate:url];
        }
            break;
        case ZYHLoginPost:
        {
            [self postLogin];
        }
            break;
    }
    NSLog(@"请未已发出");
}
- (void)postLogin
{
    NSString *urlPath=[NSString stringWithFormat:@"http://%@:8080/MJServer/login",IPAdd];
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlPath] cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:15];
    request.HTTPMethod=@"POST";
    NSString *pwd=[_pwdView.text md5String];
    NSLog(@"pwd=%@",pwd);
    NSString *body=[NSString stringWithFormat:@"username=%@&pwd=%@",_userNameView.text,_pwdView.text];
    request.HTTPBody=[body dataUsingEncoding:NSUTF8StringEncoding];
    [request setValue:@"zyh mobile" forHTTPHeaderField:@"User-Agent"];
    [self send:request];
    
}
- (void)sendAysncUseDelegate:(NSURL*)url
{
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:15];
    [NSURLConnection connectionWithRequest:request delegate:self];
}
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"%s",__func__);
    [MBProgressHUD hideHUD];
    [MBProgressHUD showError:@"网络不可用, 请检查网络"];
}
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    NSLog(@"%s",__func__);
    [self.data appendData:data];
}
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    NSLog(@"%s",__func__);
    self.data=[NSMutableData data];
}
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    [MBProgressHUD hideHUD];
    NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:self.data options:0 error:NULL];
    NSString *error=dict[@"error"];
    if(error)
        [MBProgressHUD showError:error];
    else
        [MBProgressHUD showSuccess:@"登录成功"];
     NSLog(@"%s",__func__);
}
- (void)sendAsync:(NSURL*)url
{
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:15];
    [self send:request];
}
- (void)send:(NSURLRequest*)request
{
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        if(connectionError)
            NSLog(@"%@",connectionError);
        [MBProgressHUD hideHUD];
        if(data==nil)
            [MBProgressHUD showError:@"网络不可用, 请检查网络"];
        else
        {
            NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
            NSString *error=dict[@"error"];
            if(error)
                [MBProgressHUD showError:error];
            else
            {
                [MBProgressHUD showSuccess:@"登录成功"];
                [[NSUserDefaults standardUserDefaults]setObject:self.userNameView.text forKey:ZYHUserNameKey];
                [[NSUserDefaults standardUserDefaults]synchronize];
                [SSKeychain setPassword:self.pwdView.text forService:ZYHPwdServiceName account:self.userNameView.text];
            }
        }
        
    }];

}
@end

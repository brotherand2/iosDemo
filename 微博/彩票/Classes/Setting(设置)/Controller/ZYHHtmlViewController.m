//
//  ZYHHtmlViewController.m
//  微博
//
//  Created by Apple on 16/2/6.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "ZYHHtmlViewController.h"

@interface ZYHHtmlViewController ()<UIWebViewDelegate>
@property (strong, nonatomic)UIWebView *webView;
@end

@implementation ZYHHtmlViewController
- (void)loadView
{
    _webView=[[UIWebView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    _webView.delegate=self;
    self.view=_webView;
    NSString *path=[[NSBundle mainBundle]pathForResource:self.htmlModal.html ofType:nil];
    NSURL *url=[NSURL fileURLWithPath:path];
    NSURLRequest *request=[NSURLRequest requestWithURL:url];
    [_webView loadRequest:request];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    _webView=nil;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title=_htmlModal.title;
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    // Do any additional setup after loading the view.
}

- (void)back
{
    [self dismissModalViewControllerAnimated:YES];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSString *command=[NSString stringWithFormat:@"window.location.href='#%@'",self.htmlModal.ID];
    [webView stringByEvaluatingJavaScriptFromString:command];
}
@end

//
//  ZYHWebViewController.m
//  多线程
//
//  Created by Apple on 16/2/21.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "ZYHWebViewController.h"
#import "MBProgressHUD+MJ.h"
@interface ZYHWebViewController ()<UISearchBarDelegate,UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *backItem;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *forwardItem;

@end

@implementation ZYHWebViewController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.toolbarHidden=NO;
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.toolbarHidden=YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UISearchBar *searchBar=[[UISearchBar alloc]init];
    searchBar.bounds=CGRectMake(0, 0, 320, 44);
    self.navigationItem.titleView=searchBar;
    searchBar.delegate=self;
    NSURL *url=[NSURL URLWithString:[NSString stringWithFormat:@"http://%@:8080/MJServer",IPAdd]];
    NSURLRequest *request=[NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
    self.webView.delegate=self;
    
}
- (BOOL)searchBar:(UISearchBar *)searchBar shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    //NSLog(@"text=%@",text);
    return YES;
}
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
     NSLog(@"searchtext=%@",searchText);
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    NSURL *url=[NSURL URLWithString:[NSString stringWithFormat:@"http://%@",searchBar.text]];
    NSURLRequest *request=[NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    NSLog(@"%s",__func__);
}
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
     NSLog(@"%s",__func__);
    return YES;
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [MBProgressHUD hideHUD];
    self.backItem.enabled=[self.webView canGoBack];
    self.forwardItem.enabled=[self.webView canGoForward];
     NSLog(@"%s",__func__);
    self.title=[webView stringByEvaluatingJavaScriptFromString:@"document.title;"];
}
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [MBProgressHUD showMessage:@"正在加载网页"];
     NSLog(@"%s",__func__);
}
- (IBAction)forward:(id)sender
{
    [self.webView goForward];
   
    self.forwardItem.enabled=[self.webView canGoForward];
}
- (IBAction)backWard:(id)sender
{
    [self.webView goBack];
}
@end

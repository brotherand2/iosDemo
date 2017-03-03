//
//  ZYHWebViewTestController.m
//  多线程
//
//  Created by Apple on 16/2/21.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "ZYHWebViewTestController.h"

@interface ZYHWebViewTestController ()<UIWebViewDelegate>
@property (weak, nonatomic)IBOutlet UIWebView *webView;
@end

@implementation ZYHWebViewTestController
- (IBAction)clearAd:(id)sender
{
    //document.getElementsByTagName('header')[0].remove();
    [self.webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName('header')[0].remove();"];
    [self.webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName('footer')[0].remove();"];
}
- (IBAction)getTitle:(id)sender
{
    NSString *title=[self.webView stringByEvaluatingJavaScriptFromString:@"document.title;"];
    NSLog(@"title=%@",title);
}
- (void)openMyAlbum
{
    UIImagePickerController *ipc=[[UIImagePickerController alloc]init];
    ipc.sourceType=UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    [self presentModalViewController:ipc animated:YES];
}
- (void)openMyCamera
{
    NSLog(@"%s",__func__);
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //[self.webView sizeToFit];
   //NSURL *url=[[NSBundle mainBundle]URLForResource:@"test.html" withExtension:nil];
   NSURL *url=[[NSBundle mainBundle]URLForResource:@"deal.html" withExtension:nil];
   // NSURL *url=[[NSBundle mainBundle]URLForResource:@"iOS 7 Cookbook.pdf" withExtension:nil];
     //NSURL *url=[[NSBundle mainBundle]URLForResource:@"网络基础.pptx" withExtension:nil];
    //NSURL *url=[[NSBundle mainBundle]URLForResource:@"华为编程规范.doc" withExtension:nil];
      //NSURL *url=[[NSBundle mainBundle]URLForResource:@"minion.mp4" withExtension:nil];
     // NSURL *url=[[NSBundle mainBundle]URLForResource:@"关于.txt" withExtension:nil];
    NSURLRequest *request=[NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
    self.webView.dataDetectorTypes=UIDataDetectorTypeAll;
    self.webView.delegate=self;
    [self.webView scalesPageToFit];
    self.navigationController.toolbarHidden=YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSString *urlStr=request.URL.absoluteString;
    NSLog(@"url=%@",urlStr);
    NSRange range=[urlStr rangeOfString:@"ios://"];
    if(range.length!=0)
    {
        NSString *methodName=[urlStr substringFromIndex:range.location+range.length];
        SEL selector=NSSelectorFromString(methodName);
        [self performSelector:selector];
    }

    return YES;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

//
//  ZYHViewController.m
//  多线程
//
//  Created by Apple on 16/2/9.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "ZYHViewController.h"
#import "ZYHChildViewController.h"
#import "Masonry.h"
#define btnNum 47
@interface ZYHViewController ()
@property(nonatomic,strong) NSArray *btnNames;
//@property (weak, nonatomic)UIScrollView *scrollView;
@end

@implementation ZYHViewController
- (NSArray *)btnNames
{
    if (nil==_btnNames) {
        _btnNames=@[@"最常见网络访问方法",@"网络连接",@"json反序列化",@"JSONKit解析数据",@"Plist反序列化",@"xml解析",@"模型中数值应为NSNumber",@"XML解析（DOM模型）",@"GET用户登录",@"POST用户登录",@"POST上传",@"POST上传封装",@"POST上传JSON",@"直接下载",@"NSURLConnection-GET请求",@"NSURLConnection-GET请求代理",@"NSURLConnection-POST请求",@"黑酷",@"大文件下载",@"压缩与解压缩",@"多线程下载",@"URLSeccion的使用",@"URLSeccion下载",@"URLSeccion下载跟综进度",@"AFN Get登录",@"AFN Get登录2",@"AFN POST登录",@"AFN XML",@"AFN 上传",@"AFN(Session的演练)",@"NSURLCache",@"ASI 同步",@"ASI 代理异步",@"ASI block异步",@"ASI post",@"ASI 下载",@"ASI 上传",@"ASI 上传2",@"ASI 上传相册图片",@"ASI 上传大文件",@"ASI 只使用内存缓存",@"ASI 内存缓存+硬盘缓存",@"webView使用",@"webView使用2",@"公司网络接口",@"测试 我的POST接口",@"伪造 IP"];
    }
    return _btnNames;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImage *image=[UIImage imageNamed:@"1166593.jpg"];
    self.view.backgroundColor=[UIColor colorWithPatternImage:image];
    // Do any additional setup after loading the view, typically from a nib.
    CGFloat screenW=[UIScreen mainScreen].bounds.size.width;
    CGFloat screenH=[UIScreen mainScreen].bounds.size.height;
    self.view.bounds=[UIScreen mainScreen].bounds;
    UIScrollView *scroll=[[UIScrollView alloc]init];
    //_scrollView=scroll;
    [self.view addSubview: scroll];
    CGFloat btnW=screenW*0.5;
    CGFloat btnH=44;
    CGFloat padding=20;
    CGFloat btnX=(screenW-btnW)*0.5;
    UIView *lastView=nil;
    UIEdgeInsets insets=UIEdgeInsetsMake(0, 0, 0, 0);
    [scroll mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).insets(insets);
    }];
    
    for (NSInteger i=0; i<btnNum; i++) {
        CGFloat btnY=padding+(btnH+padding)*i;
        UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
        [scroll addSubview:btn];
        btn.frame=CGRectMake(btnX, btnY, btnW, btnH);
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view).offset(btnX);
            make.right.equalTo(self.view).offset(-btnX);
            //make.centerX.equalTo(self.view);
            make.height.equalTo(@44);
            //make.width.equalTo(@(btnW));
            if(lastView==nil)
                
            {
                make.top.equalTo(@0);
            }
            else
                make.top.equalTo(lastView.mas_bottom).offset(20);
            
        }];
        lastView=btn;
        [btn setTitle:self.btnNames[i] forState:UIControlStateNormal];
        [btn setBackgroundColor:[UIColor colorWithRed:0.25 green:0.44 blue:0.55 alpha:0.7]];
        [btn setBackgroundImage:[UIImage imageNamed:@"1037531"] forState:UIControlStateNormal];
        btn.tag=i;
        [scroll addSubview:btn];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    scroll.contentSize=CGSizeMake(screenW, CGRectGetMaxY(lastView.frame));
    // Do any additional setup after loading the view.
}

- (void)btnClick:(UIButton*)btn
{
    ZYHChildViewController *vc=[[ZYHChildViewController alloc]init];
    vc.tag=btn.tag;
    vc.title=[btn currentTitle];
    [self.navigationController pushViewController:vc animated:YES];
    UIBarButtonItem *back=[[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:nil action:nil];
    [vc.view setBackgroundColor:[UIColor whiteColor]];
    
    self.navigationItem.backBarButtonItem=back;
    
}


@end

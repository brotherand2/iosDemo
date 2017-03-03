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
#define btnNum 30
@interface ZYHViewController ()
@property(nonatomic,strong) NSArray *btnNames;
//@property (weak, nonatomic)UIScrollView *scrollView;
@end

@implementation ZYHViewController
- (NSArray *)btnNames
{
    if (nil==_btnNames) {
        _btnNames=@[@"TestPThread",@"NSThread测试1",@"NSThread测试2",@"NSThread测试3",@"NSThread状态",@"卖票",@"NSThread线程间通信",@"串行队列同歩",@"串行队列异步",@"并行队列同歩",@"并行队列异歩",@"主队列同歩",@"主队列异歩",@"全局队列同歩",@"全局队列异歩",@"GCD线程间通信",@"执行一次" ,@"队列调度组",@"延迟操作",@"NSOperation1",@"NSOperation2",@"NSOperation3",@"NSOperation4",@"NSOperation5",@"NSOperation6",@"NSOperation7",@"NSOperation8",@"NSOperation9",@"NSOperation10",@"NSOperation11"];
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
       [self.navigationController pushViewController:vc animated:YES];
    vc.tag=btn.tag;
    vc.title=[btn currentTitle];
    
    UIBarButtonItem *back=[[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:nil action:nil];
    [vc.view setBackgroundColor:[UIColor whiteColor]];
    
    self.navigationItem.backBarButtonItem=back;
    
}


@end

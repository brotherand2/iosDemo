//
//  ViewController.m
//  UI练习
//注意，添加约束时不要参考UIScrollView
//  Created by Apple on 16/2/1.
//  Copyright © 2016年 Apple. All rights reserved.
//
#import "UIColor+extention.h"
#import "ViewController.h"
#import "ZYHViewController.h"
#import "TestTwoTableViewController.h"
#define btnNum 13
@interface ViewController ()
@property(nonatomic,strong) NSArray *btnNames;
@property (weak, nonatomic)UIScrollView *scrollView;
@property(nonatomic,assign)  CGSize contentSize;
@end

@implementation ViewController
- (NSArray *)btnNames
{
    if (nil==_btnNames) {
        _btnNames=@[@"UISlider",@"tableView",@"下划线按钮",@"测试4",@"测试5",@"测试2",@"测试3",@"测试4",@"测试5",@"测试2",@"测试3",@"测试4",@"测试5"];
    }
    return _btnNames;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"482821"]];
    // Do any additional setup after loading the view, typically from a nib.
    CGFloat screenW=[UIScreen mainScreen].bounds.size.width;
    CGFloat screenH=[UIScreen mainScreen].bounds.size.height;
    self.view.bounds=[UIScreen mainScreen].bounds;
    UIScrollView *scroll=[[UIScrollView alloc]init];
    _scrollView=scroll;
    [self.view addSubview: scroll];
    CGFloat btnW=screenW*0.5;
    CGFloat btnH=84;
    CGFloat padding=20;
    CGFloat btnX=(screenW-btnW)*0.5;
    UIView *lastView=nil;
    UIEdgeInsets insets=UIEdgeInsetsMake(0, 0, 0, 0);
    [scroll mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).insets(insets);
    }];
    for (NSInteger i=0; i<btnNum; i++)
    {
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
        [btn setBackgroundImage:[UIImage imageNamed:@"895452"] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor randomColor] forState:UIControlStateNormal];
        btn.tag=i;
        
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    _contentSize=CGSizeMake(screenW, CGRectGetMaxY(lastView.frame));
    scroll.contentSize=CGSizeMake(screenW, CGRectGetMaxY(lastView.frame));
}
//- (void)viewWillAppear:(BOOL)animated
//{
//    [super viewWillAppear:animated];
//    self.scrollView.contentSize=_contentSize;
//}
//- (void)viewDidAppear:(BOOL)animated
//{
//    [super viewDidAppear:animated];
//    //self.scrollView.contentSize=_contentSize;
//}
- (void)btnClick:(UIButton*)btn
{
    UIViewController *vc;
    if(btn.tag!=1)
    {
        
        ZYHViewController *vewVC=[[ZYHViewController alloc]init];
        vewVC.tag=btn.tag;
        vc=vewVC;
    }
    else
    {
        TestTwoTableViewController *viewVC=[[TestTwoTableViewController alloc]init];
        vc=viewVC;
    }

        [self.navigationController pushViewController:vc animated:YES];
    UIBarButtonItem *back=[[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:nil action:nil];
    [vc.view setBackgroundColor:[UIColor whiteColor]];
    
    self.navigationItem.backBarButtonItem=back;

}

@end

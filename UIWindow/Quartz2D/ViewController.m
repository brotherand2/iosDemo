//
//  ViewController.m
//  Quartz2D
//
//  Created by Apple on 16/1/26.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "ViewController.h"
#import "CALayerTestViewController.h"
#import "ZYHViewController.h"
#import "Masonry.h"
#define btnNum 25
@interface ViewController ()
@property(nonatomic,strong) NSArray *btnNames;
//@property (weak, nonatomic)UIScrollView *scrollView;
@end

@implementation ViewController
- (NSArray *)btnNames
{
    if (nil==_btnNames) {
        _btnNames=@[@"矩阵变换",@"裁剪图片",@"气球上升",@"UIKitTest",@"模仿ImageView",@"绘制水印图片",@"裁剪图片2",
                    @"柱状图",@"背景平铺",@"裁剪图片2",@"阴影",@"CALayer基本属性",@"CALayer平移旋转缩放",@"自定义图层",@"隐式动画",@"隐式动画平移旋转缩放",@"CAKeyframeAnimation动画",@"图片抖动",@"图片浏览器",@"组动画",@"车小弟模仿",@"底部旋转菜单",@"倒影",@"核心动画旋转",@""];
    }
    return _btnNames;
}
- (void)viewDidLoad {
    [super viewDidLoad];
//    UIImageView *imageView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"1166593"]];
//    imageView.frame=[UIScreen mainScreen].bounds;
//    imageView.contentMode=UIViewContentModeScaleToFill;//裁剪边缘,使图片居中，上下进行拉伸
//    [self.view addSubview:imageView];
    self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"1166593"]];
    // Do any additional setup after loading the view, typically from a nib.
    CGFloat screenW=[UIScreen mainScreen].bounds.size.width;
    CGFloat screenH=[UIScreen mainScreen].bounds.size.height;
    self.view.bounds=[UIScreen mainScreen].bounds;
    UIScrollView *scroll=[[UIScrollView alloc]init];
    //_scrollView=scroll;
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
    
}
- (void)btnClick:(UIButton*)btn
{
    UIViewController *vc;
    if(btn.tag!=12&&btn.tag!=15)
    {
        
       ZYHViewController *vewVC=[[ZYHViewController alloc]init];
       vewVC.tag=btn.tag;
        vc=vewVC;
    }
    else
    {
        CALayerTestViewController *viewVC=[[CALayerTestViewController alloc]init];
        viewVC.tag=btn.tag;
        if (btn.tag==15) {
            viewVC.isHideAnimate=YES;
        }
        vc=viewVC;
    }
    [self.navigationController pushViewController:vc animated:YES];
    UIBarButtonItem *back=[[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:nil action:nil];
    [vc.view setBackgroundColor:[UIColor whiteColor]];
     
    self.navigationItem.backBarButtonItem=back;
    
}

@end

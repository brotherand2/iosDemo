//
//  ZYHViewController.m
//  helloworld
//
//  Created by Apple on 16/2/1.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "ZYHViewController.h"
#import "ZYHOneView.h"
#import "LineButton.h"

@interface ZYHViewController ()
{
    CGFloat screenW,screenH;
}
@property (weak, nonatomic)LineButton *lastBtn;
@end

@implementation ZYHViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    screenW=[UIScreen mainScreen].bounds.size.width;
    screenH=[UIScreen mainScreen].bounds.size.height;
    [self setViewWithTag:self.tag];
}
-  (void)setViewWithTag:(NSInteger)tag
{
    switch (tag)
    {
        case 0:
        {
          ZYHOneView *view=[ZYHOneView oneView];
            [self.view addSubview:view];
            //添加约束出问题
//          [view mas_makeConstraints:^(MASConstraintMaker *make) {
//              make.left.right.equalTo(self.view);
//              make.center.equalTo(self.view);
//              make.width.equalTo(self.view);
//          }];
          CGFloat   viewW=view.bounds.size.width;
          CGFloat   viewH=view.bounds.size.height;
          CGFloat   scale=viewH/viewW;
            view.center=self.view.center;
            view.bounds=self.view.bounds;
        }
            break;
        case 2:
        {
            NSMutableArray *buttons=[ NSMutableArray array];
            NSArray *names=@[@"新闻",@"最新动态",@"消息"];
            for(NSInteger i=0;i<3;i++)
            {
                LineButton *btn=[[LineButton alloc]init];
                [buttons addObject:btn];
                [btn setTitle:names[i] forState:UIControlStateNormal];
                [btn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
                [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
                [self.view addSubview:btn];
                if(0==i)
                {
                    btn.selected=YES;
                    btn.line.hidden=NO;
                    _lastBtn=btn;
                }
            }
            [buttons mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:20 leadSpacing:50 tailSpacing:50];
            [buttons mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.height.equalTo(@50);
            }];

        }
            break;
    }

}
- (void)btnClick:(LineButton*)btn
{
    _lastBtn.line.hidden=YES;
    _lastBtn.selected=NO;
    btn.line.hidden=NO;
    btn.selected=YES;
    _lastBtn=btn;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

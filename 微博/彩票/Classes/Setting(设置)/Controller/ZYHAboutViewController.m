//
//  ZYHAboutViewController.m
//  微博
//
//  Created by Apple on 16/2/5.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "ZYHAboutViewController.h"
#import "ZYHSettingItem.h"
#import "ZYHItemGroup.h"
#import "ZYHAboutHeadView.h"
@interface ZYHAboutViewController ()
@property(nonatomic,strong) UIWebView *webView;
@end

@implementation ZYHAboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    ZYHSettingItem *gradeSupport=[ZYHSettingItem settingItemWithTitle:@"评分支持"];
    gradeSupport.operation=^
    {
        NSString *appid = @"725296055";
        NSString *str = [NSString stringWithFormat:
                         @"itms-apps://itunes.apple.com/cn/app/id%@?mt=8", appid];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];

    };
    ZYHSettingItem *customPhone=[ZYHSettingItem settingItemWithTitle:@"客户电话"];
    customPhone.operation=^
    {
//        方法1
       NSURL *url=[NSURL URLWithString:@"tel://10086"];

        //方法2,会被询问
       // NSURL *url=[NSURL URLWithString:@"telprompt://10086"];
        //方法3,会被询问
        if(_webView==nil)
        _webView=[[UIWebView alloc]init];
        [_webView loadRequest:[NSURLRequest requestWithURL:url]];
        //[[UIApplication sharedApplication]openURL:url];
    };
    customPhone.labelText=@"10086";
    customPhone.itemType=ZYHItemLabel;
    ZYHItemGroup *group=[[ZYHItemGroup alloc]init];
    group.items=@[gradeSupport,customPhone];
    [self.data addObject:group];
    self.tableView.tableHeaderView=[ZYHAboutHeadView headView];
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

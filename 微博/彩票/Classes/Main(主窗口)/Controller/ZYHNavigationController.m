//
//  ZYHNavigationController.m
//  微博
//
//  Created by Apple on 16/2/4.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "ZYHNavigationController.h"

@interface ZYHNavigationController ()

@end

@implementation ZYHNavigationController
#pragma mark 类第一次使用的时候被调用
+ (void)initialize
{
     //设置状态栏样式
    [UIApplication sharedApplication].statusBarStyle=UIStatusBarStyleLightContent;
    [UIApplication sharedApplication].statusBarHidden=NO;
    // 设置主题
    /**设置导航条的背景图片注意点
     * 1.在ios7以上，背景图片的高度一定要64(点)
     * 2.背景图片的宽度无限制，1点，自动会拉伸
     * 3.如果是通过导航控制器获取的导航条来设置背景，它是局部
     *   self.navigationController.navigationBar
     * 4.如果想设置一次导航栏的背景，这个导航条的对象，通过导航条的一个类方法获取的就可以 [UINavigationBar appearance]
     
     */
    // 设置当前导航控制器的背景
    //[self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"NavBar64"] forBarMetrics:UIBarMetricsDefault];

    UINavigationBar *navBar=[UINavigationBar appearance];//获取全局导航条外观
    UIImage *image=[UIImage imageNamed:@"NavBar64"];
    [navBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    NSDictionary *textInfo=@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:20]};
    [navBar setTitleTextAttributes:textInfo];
    
    //设置返回按钮颜色//tintColor是用于导航条的所有Item
    [navBar setTintColor:[UIColor whiteColor]];
    UIBarButtonItem *item=[UIBarButtonItem appearance];
    [item setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} forState:UIControlStateNormal];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    viewController.hidesBottomBarWhenPushed=YES;
    [super pushViewController:viewController animated:animated];
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

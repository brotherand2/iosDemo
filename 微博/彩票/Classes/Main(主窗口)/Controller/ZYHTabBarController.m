//
//  ZYHTabBarController.m
//  微博
//
//  Created by Apple on 16/2/4.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "ZYHTabBarController.h"
#import "ZYHTabBar.h"
@interface ZYHTabBarController ()

@end

@implementation ZYHTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //自定义TabBar是因为系统TabBar的ICON大小为30*30，TabBar高度为49*49，当前用的图标为49*49，比30大，所以自定义
    ZYHTabBar *tabBar=[[ZYHTabBar alloc]initWithFrame:self.tabBar.bounds];
    __weak typeof(self)vc=self;
    tabBar.btnClick=^(NSInteger tag)
    {
        vc.selectedIndex=tag;
    };
    [self.tabBar addSubview:tabBar];//添加到系统TabBar,不删除系统的是因为当要隐藏TabBar时，
    //要靠隐藏系统的TabBar来
    for (NSInteger i=0; i<5; i++) {
        NSString *normalImageName=[NSString stringWithFormat:@"TabBar%ld",i+1];
        NSString *selectedImageName=[NSString stringWithFormat:@"TabBar%ldSel",i+1];
        [tabBar addTabBarItemWithBkgImageName:normalImageName andSelectedName:selectedImageName];
    }
    
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

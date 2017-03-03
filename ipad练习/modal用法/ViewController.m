//
//  ViewController.m
//  modal用法
//
//  Created by Apple on 16/3/16.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "ViewController.h"
#import "UIColor+extention.h"
#import "ZYHSecondViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    ZYHSecondViewController *vc=[[ZYHSecondViewController alloc]init];
    /*
     UIModalPresentationFullScreen = 0,
     UIModalPresentationPageSheet NS_ENUM_AVAILABLE_IOS(3_2) __TVOS_PROHIBITED,
     UIModalPresentationFormSheet NS_ENUM_AVAILABLE_IOS(3_2) __TVOS_PROHIBITED,
     UIModalPresentationCurrentContext NS_ENUM_AVAILABLE_IOS(3_2),
     UIModalPresentationCustom NS_ENUM_AVAILABLE_IOS(7_0),
     UIModalPresentationOverFullScreen NS_ENUM_AVAILABLE_IOS(8_0),
     UIModalPresentationOverCurrentContext NS_ENUM_AVAILABLE_IOS(8_0),
     UIModalPresentationPopover NS_ENUM_AVAILABLE_IOS(8_0) __TVOS_PROHIBITED,
     UIModalPresentationNone NS_ENUM_AVAILABLE_IOS(7_0) = -1,
     
     
     
     UIModalPresentationFullScreen是弹出VC时，VC充满全屏，UIModalPresentationPageSheet是如果设备横屏，VC的显示方式则从横屏下方开始，UIModalPresentationFormSheet是VC显示都是从底部，宽度和屏幕宽度一样。UIModalPresentationCurrentContext是VC的弹出方式和VC父VC的弹出方式相同。.....UIModalPresentationNone测试时会崩溃，出错'The specified modal presentation style doesn't have a corresponding presentation controller.'-------------------------------
     */
    //vc.modalPresentationStyle=UIModalPresentationFormSheet;//广告常用这种类型
    @try
    {
        vc.modalPresentationStyle=arc4random()%8;
        
        /*
         UIModalTransitionStyleCoverVertical = 0,
         UIModalTransitionStyleFlipHorizontal __TVOS_PROHIBITED,
         UIModalTransitionStyleCrossDissolve,
         UIModalTransitionStylePartialCurl NS_ENUM_AVAILABLE_IOS(3_2) __TVOS_PROHIBITED,
         UIModalTransitionStyleCoverVertical是从底部滑入，UIModalTransitionStyleFlipHorizontal是水平翻转，UIModalTransitionStyleCrossDissolve是交叉溶解，UIModalTransitionStylePartialCurl是翻页效果。
         */
        // vc.modalTransitionStyle=UIModalTransitionStyleFlipHorizontal;
        vc.modalTransitionStyle=arc4random()%4;
        if(vc.modalTransitionStyle==UIModalTransitionStylePartialCurl)
            vc.modalPresentationStyle=0;//全屏显示
        if(vc.modalPresentationStyle==UIModalPresentationPopover)
         vc.popoverPresentationController.sourceView=self.view;
        [self presentViewController:vc animated:YES completion:nil];
    }
    @catch (NSException *exception) {
        NSLog(@"%ld %ld",vc.modalPresentationStyle,(long)vc.modalTransitionStyle);
    }
    @finally {
        
    }
    
    
}
- (IBAction)rmbPwnBtnClick:(id)sender {
}
@end

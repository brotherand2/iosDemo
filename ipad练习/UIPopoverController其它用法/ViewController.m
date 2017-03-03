//
//  ViewController.m
//  UIPopoverController其它用法
//
//  Created by Apple on 16/3/16.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "ViewController.h"
#import "ZYHColorMenuViewController.h"
@interface ViewController ()<UIPopoverControllerDelegate>
@property (weak, nonatomic) IBOutlet UIButton *redBtn;

@property (strong, nonatomic)UIPopoverController *popVC;
@property (weak, nonatomic) IBOutlet UIButton *greenBtn;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)greentnClick:(id)sender
{
    NSLog(@"green click");
}
- (IBAction)redBtnClick:(id)sender
{
    ZYHColorMenuViewController *colorVC=[[ZYHColorMenuViewController alloc]init];
    __weak typeof(self)selfObj=self;
    colorVC.selectRow=^(UIColor *color)
    {
        selfObj.redBtn.backgroundColor=color;
        [self.popVC dismissPopoverAnimated:YES];
    };
    
    UIPopoverController *popVC=[[UIPopoverController alloc]initWithContentViewController:colorVC];
    //[popVC presentPopoverFromRect:self.redBtn.bounds inView:self.redBtn permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
//    [popVC presentPopoverFromRect:CGRectMake(100, 200, 100, 200) inView:self.redBtn.superview permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    [popVC presentPopoverFromRect:self.redBtn.frame inView:self.redBtn.superview permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];

    popVC.delegate=self;
    //// 3.设置哪里控件在popover显示出来的时候,仍旧可以跟用户进行交互
    popVC.passthroughViews=@[self.greenBtn];
    self.popVC=popVC;
}
- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController
{
    NSLog(@"销毁了");
}
@end

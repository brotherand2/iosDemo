//
//  ViewController.m
//  倒计时
//
//  Created by Apple on 15/12/19.
//  Copyright © 2015年 Apple. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *counterLabel;
@property(nonatomic,strong)NSTimer *timer;
@property(nonatomic,assign)BOOL isStart;
@end

@implementation ViewController

- (IBAction)start
{
    if(self.isStart)
        return;
    if(self.counterLabel.text.intValue<=0)
    [self reset];
    self.isStart=YES;
    self.timer=[NSTimer timerWithTimeInterval:1 target:self selector:@selector(updateTimer:) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop]addTimer:self.timer forMode:NSRunLoopCommonModes];
}
- (IBAction)valueChange:(id)sender {
}
- (void)updateTimer:(NSTimer*)timer
{
    int counter=self.counterLabel.text.intValue;
    if(--counter<0)
    {
        [self pause];
        [[[UIAlertView alloc]initWithTitle:@"开始" message:@"开始计时啦" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",@"哈哈", nil] show];
        
    }
    else
        self.counterLabel.text=[NSString stringWithFormat:@"%d",counter];
}

- (IBAction)pause
{
    self.isStart=NO;
    [self.timer invalidate];
}
- (IBAction)reset
{
    [self pause];
    self.counterLabel.text=@"10";
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex==0)
    NSLog(@"YOU CLICK:%ld  cancel",buttonIndex);
}
@end

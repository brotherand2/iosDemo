//
//  ViewController.m
//  button
//
//  Created by Apple on 15/11/23.
//  Copyright © 2015年 Apple. All rights reserved.
//

#import "ViewController.h"
int const length=80;
@interface ViewController ()
- (IBAction)up;
- (IBAction)previous:(UIButton *)sender;
- (IBAction)down;
- (IBAction)left;
- (IBAction)right;
- (IBAction)bigger;
- (IBAction)smaller;
- (IBAction)move:(UIButton*)sender;
@property(nonatomic,weak)IBOutlet UIButton *head;
@end

@implementation ViewController
- (void)move:(UIButton*)sender
{
    //NSLog(@"MOVE :%@",sender);
    [UIView beginAnimations:nil context:nil];//开始动画
    [UIView setAnimationDuration:1.5];//动画延迟时间
    NSString *direct;
    switch (sender.tag) {
        case 0:
            direct=@"move up";
            [self up];
            break;
        case 1:
            direct=@"move left";
            [self left];
            break;
        case 2:
            direct=@"move down";
            [self down];
            break;
        case 3:
            direct=@"move right";
            [self right];
            break;
        default:
            break;
    }
    NSLog(@"%@",direct);

}
- (void)up
{

    CGRect frame= self.head.frame;
    NSLog(@"up=%f",self.head.frame.origin.y);
    frame.origin.y-=length;
 
    self.head.frame=frame;
    NSLog(@"up=%f",self.head.frame.origin.y);

}

- (IBAction)previous:(UIButton *)sender {
}
- (void)bigger
{
    NSLog(@"bigger");
    CGRect frame= self.head.frame;
    frame.origin.x-=5;
    frame.origin.y-=5;
    frame.size.height+=5;
    frame.size.width+=5;
    self.head.frame=frame;
}
- (void)down
{
    NSLog(@"down");
    CGRect frame= self.head.frame;
    frame.origin.y+=length;
    self.head.frame=frame;
}
- (void)left
{
    NSLog(@"left");
    CGRect frame= self.head.frame;
    frame.origin.x-=length;
    self.head.frame=frame;
}
- (void)right
{
    NSLog(@"right");
    CGRect tempframe= self.head.frame;
    tempframe.origin.x+=length;
    self.head.frame=tempframe;
}
- (void)smaller
{
    NSLog(@"smaller");
    NSLog(@"bigger");
    CGRect frame= self.head.frame;
    frame.origin.x+=5;
    frame.origin.y+=5;
    frame.size.height-=5;
    frame.size.width-=5;
    self.head.frame=frame;
}
@end

//
//  ViewController.m
//  calculate
//
//  Created by Apple on 15/11/23.
//  Copyright © 2015年 Apple. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
- (IBAction)login:(UIButton *)sender;
- (IBAction)previous:(UIButton *)sender;
- (IBAction)drink:(UIButton *)sender;

@end

@implementation ViewController
- (IBAction)calculate
{
    NSString *text1= self.textField1.text;
    NSString *text2=self.textField2.text;
    int num1=[text1 intValue];
    int num2=[text2 intValue];
    int diference=0;
    if(num1>=num2)
    {
        diference=num1-num2;
        [self.label setText:[NSString stringWithFormat:@"%d",diference]];
    }
    else{
//        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"输入的数字不合理" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"其它", nil];
//           [alert show];
        UIAlertController *alertC=[UIAlertController alertControllerWithTitle:@"提示" message:@"输入的数字不合理"  preferredStyle:UIAlertControllerStyleAlert];
        [alertC addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
        [self presentViewController:alertC animated:NO completion:nil];
//        [self.textField1 resignFirstResponder];
      
    }
      [self.view endEditing:YES];//隐藏键盘
     NSLog(@"I AM click");
}
- (IBAction)undo:(id)sender {
}

- (IBAction)login:(UIButton *)sender {
}

- (IBAction)previous:(UIButton *)sender {
}

- (IBAction)drink:(UIButton *)sender {
}
@end

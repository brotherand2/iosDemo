//
//  ViewController.m
//  键盘处理
//
//  Created by Apple on 16/1/16.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *dateView;
@property (weak, nonatomic)UIDatePicker *datePicker;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UIDatePicker *datePicker=[[UIDatePicker alloc]init];
    datePicker.locale=[NSLocale localeWithLocaleIdentifier:@"zh"];
    datePicker.datePickerMode=UIDatePickerModeDate;
    self.dateView.inputView=datePicker;
    UIToolbar *toobar=[[UIToolbar alloc]init];
    toobar.frame=CGRectMake(0, 0, 320, 44);
    UIBarButtonItem *previous=[[UIBarButtonItem alloc]initWithTitle:@"上一个" style:UIBarButtonItemStylePlain target:nil action:nil];
     UIBarButtonItem *next=[[UIBarButtonItem alloc]initWithTitle:@"下一个" style:UIBarButtonItemStylePlain target:nil action:nil];
     UIBarButtonItem *finish=[[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(finishSelectDate)];
    UIBarButtonItem *tanhuang= [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    toobar.backgroundColor=[UIColor grayColor];

    toobar.items=@[previous,tanhuang,next,tanhuang,finish];
    self.dateView.inputAccessoryView=toobar;
    self.datePicker=datePicker;
}

- (void)finishSelectDate
{
    NSDate *date=self.datePicker.date;
    NSDateFormatter *format=[[NSDateFormatter alloc]init];
    format.dateFormat=@"YYYY-MM-dd";
    NSString *dateStr=[format stringFromDate:date];
    self.dateView.text=dateStr;
    [self.dateView resignFirstResponder];
}
@end
